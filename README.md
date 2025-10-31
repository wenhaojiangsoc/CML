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
