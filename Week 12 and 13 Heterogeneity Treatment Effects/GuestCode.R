# Random Forests & Causal Forests on Titanic
#  - Predict survival with a Random Forest (classification)
#  - Estimate heterogeneous effects with a Causal Forest (male "treatment")
#  - Compare to a simple OLS baseline
#  - Calibrate, visualize CATEs, and interpret sociologically

# 0) Packages ----------------------------------------------------------
library(stablelearner)   # Titanic data
library(tidyverse)       # wrangling + plots
library(randomForest)    # random forest classifier (less annoying given data)
library(grf)             # generalized random forests (causal forests)
theme_set(theme_minimal())

set.seed(42)

# 1) Data --------------------------------------------------------------
data("titanic")
titanic_df <- titanic %>%
  dplyr::select(-name, -ticketno, -fare, -parch, -sibsp, -embarked) %>%
    mutate(
        English       = as.integer(country == "England"),
        survived_num  = as.integer(survived == "yes"),
        male          = as.integer(gender  == "male"),
        class_ordinal = case_when(
            class == "1st" ~ 1L,
            class == "2nd" ~ 2L,
            class == "3rd" ~ 3L,
            TRUE           ~ 4L
        )
    ) %>%
    dplyr::select(-class, -gender, -country) %>%
    drop_na()

glimpse(titanic_df)

Y_tit <- titanic_df$survived_num
W_tit <- titanic_df$male
X_tit <- titanic_df %>% dplyr::select(-survived, -survived_num, -male)

# 2) Random Forest (prediction) ----------------------------------------
rf_df <- titanic_df %>%
    mutate(survived = factor(survived))

rf_model <- randomForest(
    survived ~ .,
    data       = rf_df %>% dplyr::select(-survived_num),
    na.action  = na.omit,
    importance = TRUE
)
print(rf_model)   # OOB error + confusion matrix
varImpPlot(rf_model, main = "Random Forest Variable Importance (Prediction)")

# 3) Causal Forest (heterogeneous effects of being male) ---------------
titanic_cf <- causal_forest(
    X = X_tit,
    Y = Y_tit,
    W = W_tit,
    tune.parameters = "all",
    seed = 42
)

# 3a) Average Treatment Effect (ATE)
ate <- average_treatment_effect(titanic_cf, target.sample = "control")
cat("\nATE (male vs female) from causal forest:\n")
print(ate)

# 3b) Calibration (are CATEs reasonable?)
cat("\nCalibration test:\n")
print(test_calibration(titanic_cf))

# 3c) CATE distribution -----------------------------------------------
tau_hat <- predict(titanic_cf)$predictions
hist(
    tau_hat,
    breaks = 30, col = "skyblue", border = "white",
    main = "Distribution of Estimated Treatment Effects (Male)",
    xlab = "Estimated CATE (Δ survival | male vs female)"
)
abline(v = mean(tau_hat), lty = 2)

# 3d) Heterogeneity by age group × class ------------------------------
df_tau <- titanic_df %>%
    mutate(
        tau_hat   = as.numeric(tau_hat),
        age_group = cut(
            age, breaks = c(0, 10, 20, 40, Inf),
            labels = c("0–10", "11–20", "21–40", "41+"),
            include.lowest = TRUE
        )
    )

ggplot(df_tau, aes(x = factor(class_ordinal), y = tau_hat)) +
    geom_boxplot(outlier.alpha = 0.3) +
    facet_wrap(~ age_group) +
    labs(
        x = "Passenger Class (ordinal)",
        y = "Estimated CATE (male)",
        title = "Estimated Gender Effect by Age Group and Class"
    )

# 3d+) Observed survival by class × age (by sex) ----------------------
obs_df <- titanic_df %>%
    mutate(
        age_group = cut(
            age, breaks = c(0, 10, 20, 40, Inf),
            labels = c("0–10", "11–20", "21–40", "41+"),
            include.lowest = TRUE
        ),
        sex = factor(male, levels = c(0, 1), labels = c("Female", "Male"))
    ) %>%
    group_by(class_ordinal, age_group, sex) %>%
    dplyr::summarize(
        surv_rate = mean(survived_num),
        n         = n(),
        .groups   = "drop"
    )

ggplot(obs_df, aes(x = factor(class_ordinal), y = surv_rate, fill = sex)) +
    geom_col(position = position_dodge()) +
    facet_wrap(~ age_group) +
    scale_y_continuous(labels = scales::percent_format(accuracy = 1)) +
    labs(
        x = "Passenger Class (ordinal)",
        y = "Observed Survival Rate",
        fill = "Sex",
        title = "Observed Survival by Class and Age (by Sex)"
    )
# PROMPT: Does this show why the absolute male penalty can’t get very large
# in strata where baseline survival is already near zero?

# 3e) Heatmap: CATE over age × class grid -----------------------------
tau_fun <- function(age_val, class_val) {
    newx <- X_tit[1, , drop = FALSE]
    newx$age <- age_val
    newx$class_ordinal <- class_val
    as.numeric(predict(titanic_cf, newx)$predictions)
}

age_seq   <- seq(0, 70, by = 1)
class_seq <- 1:4
df_grid <- expand.grid(age = age_seq, class_ordinal = class_seq)
df_grid$tau_hat <- mapply(tau_fun, df_grid$age, df_grid$class_ordinal)

ggplot(df_grid, aes(x = age, y = factor(class_ordinal), fill = tau_hat)) +
    geom_tile() +
    scale_fill_gradient2(midpoint = 0, low = "blue", mid = "white", high = "red") +
    labs(
        x = "Age",
        y = "Class (ordinal)",
        fill = "CATE (male)",
        title = "Estimated Treatment Effect Surface (Male vs Female)"
    )

# 3f) Variable importance (causal forest) -----------------------------
vi <- variable_importance(titanic_cf)
vip_df <- tibble(variable = colnames(X_tit), importance = vi) %>%
    arrange(desc(importance))

ggplot(vip_df, aes(x = reorder(variable, importance), y = importance)) +
    geom_col(fill = "steelblue") +
    coord_flip() +
    labs(
        title = "Variable Importance (Causal Forest)",
        x = "Covariate",
        y = "Importance"
    )
print(head(vip_df, 10))

# 4) Sanity check vs naive difference (by class, with ATE line) -------
naive_by_class <- titanic_df %>%
    group_by(class_ordinal) %>%
    dplyr::summarize(
        surv_male   = mean(survived_num[male == 1]),
        surv_female = mean(survived_num[male == 0]),
        diff        = surv_male - surv_female,
        .groups     = "drop"
    )

print(naive_by_class)

# Extract ATE estimate safely (works if vector or data.frame)
ate_est <- if (is.data.frame(ate)) ate$estimate[1] else ate[1]

ggplot(naive_by_class, aes(x = factor(class_ordinal), y = diff)) +
    geom_col(fill = "steelblue") +
    geom_hline(yintercept = ate_est, linetype = "dashed", color = "red") +
    annotate(
        "text",
        x = 3, y = ate_est,
        label = sprintf("ATE ≈ %.0f pp", 100 * ate_est),
        vjust = -0.5, color = "red"
    ) +
    scale_y_continuous(labels = scales::percent_format(accuracy = 1)) +
    labs(
        x = "Passenger Class (ordinal)",
        y = "Male – Female Survival Difference",
        title = "Observed Male Penalty by Class vs Overall ATE"
    )

# 5) Optional: simple policy tree -------------------------------------
library(policytree, DiagrammeR)
dr <- double_robust_scores(titanic_cf)
tree <- policy_tree(as.data.frame(X_tit), dr, depth = 3)
plot(tree); tree