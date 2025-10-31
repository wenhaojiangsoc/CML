<h1 align="center">SOCIOL 690S: Machine Learning in Causal Inference</h1>

<p align="center"><b> Taught by <a href="https://wenhaojiangsoc.github.io">Wenhao Jiang</a> · Department of Sociology · Duke University · Fall 2025 </b></p>

---

<details>
  <summary><h2>Week 1 Introduction, Motivation, and Linear Regression</h2></summary>

This week sets the stage for the course and introduces how and *why* Machine Learning (ML) can be integrated into causal inference.

### Roadmap
- Motivate the integration of statistical prediction with causal inference in response to the emergence of high-dimensional data and the need for flexible, non-linear modeling of covariates.
- Review the statistical properties of the Conditional Expectation Function (CEF) and linear regression in a low-dimensional setting.  
  + The basic matrix formulation of linear regression is revisited.  
- Introduce the Frisch–Waugh–Lovell (FWL) Theorem as a partialling-out technique in linear regression.  
- Review asymptotic OLS inference and discuss issues with standard error estimation in high-dimensional settings.  
- Summarize the concept of *Neyman Orthogonality* as an extension of the FWL Theorem to motivate Double Machine Learning (DML) in high-dimensional settings.  

### Materials
- [Slides: Week 1 Introduction](./Week%201%20Motivation%20and%20Linear%20Regression/Week%201%20Slides.pdf)  
- [Supplements: Asymptotic OLS Inference](./Week%201%20Motivation%20and%20Linear%20Regression/Week%201%20Supplements.pdf)  

> **Optional Reading:** For students who wish to explore the asymptotic properties of OLS in greater depth, see the *Week 1 Supplements* on asymptotic inference. Models that satisfy *Neyman Orthogonality* retain the classic asymptotic properties required for valid statistical inference.

---
</details>

<details>
  <summary><h2>Week 2 Machine Learning Basics</h2></summary>
  
Building on Week 1, where we introduced both the benefits and the challenges of high-dimensional data, this week focuses on regularization regression methods. These approaches address high dimensionality in order to improve out-of-sample prediction and strengthen statistical inference.

### Roadmap
- Review the motivation for using high-dimensional data in analysis, and examine the limitations of ordinary linear regression in high-dimensional settings.
- Introduce regularization methods for handling high-dimensional data. We focus in particular on LASSO regression as a feature selection method under approximate sparsity, and Ridge regression for dense coefficient distributions. We also cover variants that combine LASSO and Ridge penalties.
- Introduce cross-validation and plug-in methods for fine-tuning the penalty level in regularization.
- Revisit the Frisch–Waugh–Lovell (FWL) Theorem and introduce Double LASSO for statistical inference in high-dimensional settings.
- Present other LASSO-like methods that satisfy Neyman orthogonality for valid inference.
- Demonstrate `R` implementations of regularization methods and Double LASSO, applying them to test the Convergence Hypothesis in Macroeconomics with high-dimensional data.

### Materials
- [Slides: Week 2 Machine Learning Basics](./Week%202%20Machine%20Learning%20Basics/Week%202%20Slides.pdf)  
- [R Code: Regularization Methods](./Week%202%20Machine%20Learning%20Basics/regularization.pdf)  
- [R Code: Double LASSO and the Convergence Hypothesis](./Week%202%20Machine%20Learning%20Basics/doubleLASSO.pdf)  

---
</details>


<details>
  <summary><h2>Week 3 Machine Learning Advanced</h2></summary>
  
Building on Week 2, where we introduced linear regularization methods to address high-dimensional data, this week we turn to non-linear models in Machine Learning. These approaches are designed to capture flexible and complex relationships among covariates. Our focus will be on two broad classes: Tree-based Methods and Neural Networks, along with their key variants.

### Roadmap

- Formally introduce the concept of the bias-variance tradeoff and explain its role in tuning Machine Learning models.
- Present classic Tree-based Methods, including Regression Trees, Bagging, Random Forests, and Boosted Trees, showing how each builds on the bias-variance tradeoff.
- Introduce the foundational Neural Network framework and discuss the theoretical background of training a Neural Network model.
  
### Materials
- [Slides: Week 3 Machine Learning Advanced](./Week%203%20Machine%20Learning%20Advanced/Week%203%20Slides.pdf)  
- [R Code: Fit ML Models](./Week%203%20Machine%20Learning%20Advanced/fitML.pdf)
---
</details>

<details>
  <summary><h2>Week 4 Neyman Orthogonality and Potential Outcome Framework</h2></summary>

Building on the Machine Learning methods introduced in the last two weeks, this week we focus on the Double Machine Learning (DML) approach in partial linear regression, where covariates may be high-dimensional. We formally justify DML using the concept of *Neyman Orthogonality*, a framework that ensures consistent estimation of the treatment effect even when nuisance functions are estimated with ML. We then connect DML to the potential outcomes framework in causal inference, introducing the key assumption of conditional ignorability, which links regression-based estimation to causal interpretation.

### Roadmap

- Formally introduce *Neyman Orthogonality* and explain why orthogonality is key to making ML-based nuisance estimates usable for valid inference in Double Machine Learning (DML)

- Connect DML to the partial linear regression model with high-dimensional covariates. We explain the importance of hyperparameter tuning and *cross-fitting* in DML and demonstrate the technique based on the high-dimensional data we used to test the Convergence Hypothesis.

- Link DML to the potential outcomes framework and *conditional ignorability*. We highlight how the regression-based approach ties to causal interpretation under ignorability.  

### Materials
- [Slides: Week 4 Neyman Orthogonality and Causal Inference Basics](./Week%204%20Neyman%20Orthogonality%20and%20Causal%20Inference%20Basics/Week%204%20Slides.pdf)  
- [R Code: Fit Double ML Models](./Week%204%20Neyman%20Orthogonality%20and%20Causal%20Inference%20Basics/doubleML.pdf)
---
</details>

<details>
  <summary><h2>Week 5 Causal Inference from Directed Acyclic Graphs</h2></summary>

Building on last week’s discussion of Neyman Orthogonality and the potential outcome framework, this week introduces the *graphical approach* to causal inference through *Directed Acyclic Graphs (DAGs)*. We connect structural equation modeling (SEM) to modern causal reasoning by showing how DAGs formally represent causal assumptions and clarify identification strategies. This approach allows us to diagnose when and why causal effects can or cannot be identified from observational data.

We begin with a *linear structural equation model* to motivate the transition from equations to DAGs, demonstrating how causal paths encode relationships among treatment, covariates, and outcomes. We then introduce the *backdoor criterion* for identifying confounding and show its equivalence to *conditional ignorability* in the potential outcome framework. Next, we examine *collider bias*—a common pitfall that arises when conditioning on variables influenced by both treatment and outcome—and discuss the distinction between *good* and *bad* controls. Finally, we explore the *front-door criterion*, which enables identification even in the presence of unobserved confounders when a mediating mechanism is observed.

### Roadmap

- Connect *Structural Equation Models (SEM)* to DAGs, showing how causal relationships can be represented graphically and interpreted in terms of directed paths.

- Define the *backdoor criterion* and explain its link to *conditional ignorability* as a condition for causal identification.

- Illustrate *collider bias* and the consequences of conditioning on colliders or post-treatment variables, using examples such as the *birth-weight paradox*.

- Distinguish between *good controls* (confounders) and *bad controls* (colliders, post-treatment variables, or instruments mistakenly adjusted for).

- Introduce the *front-door criterion* as a mechanism-based identification strategy and discuss its assumptions, advantages, and limitations.

### Materials
- [Slides: Week 5 Causal Inference from Directed Acyclic Graphs](./Week%205%20Causal%20Inference%20through%20DAG/Week%205%20Slides.pdf)
---
</details>

<details>
  <summary><h2>Week 6 Matching, Propensity, Weighting, and Doubly Robust Estimation</h2></summary>

This week focuses on causal inference under the *Conditional Ignorability Assumption (CIA)* and explores various strategies for covariate adjustment. We examine how *matching*, *propensity score weighting*, and *regression adjustment* provide alternative approaches for estimating treatment effects from observational data, and how these methods relate to the *potential outcome framework* introduced earlier.  

We begin with *matching* and *regression-based estimands*, showing how both aim to eliminate selection bias by conditioning on observed covariates. We then formalize the *propensity score theorem*, which reduces high-dimensional covariate adjustment to a single scalar—the probability of treatment given covariates. Using this foundation, we introduce *Inverse Probability Weighting (IPW)* and its stabilized variant (*SIPW*) to construct pseudo-populations that mimic random treatment assignment.  

Finally, we study *Augmented Inverse Probability Weighting (AIPW)*, a *doubly robust* estimator that remains consistent if either the outcome model or the propensity model is correctly specified. We close by linking AIPW back to *Neyman Orthogonality*, illustrating how double robustness prepares the ground for modern *Double Machine Learning* approaches.

### Roadmap

- Review the *Conditional Ignorability Assumption (CIA)* and discuss how matching and regression estimators address selection bias under ignorability.

- Introduce the *propensity score theorem*, demonstrating how causal identification can rely on a single balancing score rather than the full covariate vector.

- Derive the *Inverse Probability Weighting (IPW)* estimator and explore its relation to weighted regression and the Horvitz–Thompson formulation.

- Explain *Stabilized IPW (SIPW)* and how stabilization mitigates extreme weights and reduces estimator variance.

- Introduce *G-computation* as an alternative adjustment method based on outcome modeling.

- Present the *Augmented Inverse Probability Weighting (AIPW)* estimator, emphasizing its *double robustness* and connection to *Neyman Orthogonality*, which forms the theoretical bridge to *Double Machine Learning*.

### Materials
- [Slides: Week 6 Matching, Propensity, Weighting, and Beyond](./Week%206%20Matching%2C%20Propensity%2C%20Weighting/Week%206%20Slides.pdf)  
- [R Code: PSweight Demonstration](./Week%206%20Matching%2C%20Propensity%2C%20Weighting/PSweight.pdf)
---
</details>

<details>
  <summary><h2>Week 7 Instrumental Variable Estimation</h2></summary>

This week introduces the *Instrumental Variable (IV)* framework for identifying causal effects when the treatment variable is *endogenous*—that is, correlated with unobserved confounders. Building on the potential outcomes and DAG frameworks from earlier weeks, we explore how valid instruments can recover causal estimates by generating *exogenous variation* in the treatment.  

We begin by revisiting the problem of *omitted variable bias*, showing how unobserved confounders can bias regression estimates. We then define the two key assumptions of IV identification—*relevance* (the instrument must shift the treatment) and *exogeneity* (the instrument must not directly affect the outcome). Using these conditions, we derive the *Wald estimator* and extend to the general *Two-Stage Least Squares (2SLS)* framework.  

We illustrate these concepts through two canonical applications: *settler mortality and institutional quality* (Acemoglu, Johnson, and Robinson, 2001) and *quarter of birth and education* (Angrist and Krueger, 1991). We then discuss inference challenges under weak instruments, review the *Anderson–Rubin (AR)* test, and introduce its robust extension for use with *Double Machine Learning (DML)* in high-dimensional settings.  

### Roadmap

- Revisit the problem of *omitted variable bias* and explain why standard regression or matching approaches fail when unobserved confounding exists.  

- Introduce *instrumental variables* and the conditions for valid identification: *relevance* and *exogeneity*.  

- Derive the *Wald estimator* and connect it to the *Two-Stage Least Squares (2SLS)* procedure.  

- Explore empirical applications including:
  - *Colonial Origins of Comparative Development* (AJR, 2001): settler mortality as an instrument for institutional quality.  
  - *Quarter-of-Birth and Schooling* (Angrist & Krueger, 1991): compulsory schooling laws as instruments for education.  

- Discuss the consequences of *weak instruments* and diagnose instrument strength using the *first-stage F-statistic*.  

- Introduce the *Anderson–Rubin (AR)* approach to inference, which remains valid even under weak instruments.  

- Extend the IV framework with *Double Machine Learning for Partially Linear IV Models*, combining residualization and cross-fitting for high-dimensional data.  

### Materials
- [Slides: Week 7 Instrumental Variable Estimation](./Week%207%20Instrumental%20Variable%20Estimation/Week%207%20Slides.pdf)  
- [R Code: Double Machine Learning for IV](./Week%207%20Instrumental%20Variable%20Estimation/DoubleMLIV.pdf)
---
</details>

<details>
  <summary><h2>Week 10 Regression Discontinuity Design</h2></summary>

This week introduces the *Regression Discontinuity Design (RDD)*, a powerful quasi-experimental method for causal inference when treatment assignment follows a deterministic rule based on a continuous running variable and a known cutoff. We focus on the *sharp* RDD setup, where treatment status changes discretely at the cutoff, and examine both its theoretical foundations and empirical implementation.  

We begin by formalizing the identifying assumptions of RDD—*continuity of potential outcomes* and *no manipulation* of the running variable—and illustrate these ideas through classic examples such as academic recognition thresholds and close elections. We then derive the local treatment effect at the cutoff, emphasizing *local linear regression* and *kernel weighting* as the core estimation tools.  

Next, we discuss *bandwidth selection* and the Imbens–Kalyanaraman (IK) optimal bandwidth formula, highlighting the bias–variance tradeoff inherent to local estimation. We also examine how incorporating covariates can improve estimation efficiency without affecting bias and extend this idea to *machine learning–assisted RDD*, where nuisance components are estimated flexibly using algorithms such as random forests, gradient boosting, and lasso.  

### Roadmap

- Introduce the *sharp regression discontinuity (RD)* framework and the two core assumptions.  

- Define the *local average treatment effect (LATE)* at the cutoff and illustrate its estimation using local linear regression. We illustrate the use of RD by discussing several empirical applications.

- Explain the *bias–variance tradeoff* and the logic of *kernel weighting* and *bandwidth selection* (Imbens–Kalyanaraman rule).  

- Demonstrate how to incorporate *covariates* in RDD to improve precision and efficiency.  

- Extend RDD with *machine learning* to estimate nuisance functions, using *cross-fitting* and flexible models (Random Forest, GBM, and Lasso) to residualize outcomes near the cutoff.  

### Materials
- [Slides: Week 10 Regression Discontinuity Design](./Week%2010%20Regression%20Discontinuity/Week%2010%20Slides.pdf)  
- [R Code: Machine Learning for RDD](./Week%2010%20Regression%20Discontinuity/MLRDD.pdf)
---
</details>


