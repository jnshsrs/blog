---
title: Interpreting Logistic Regression Coefficients - Odds Ratios
author: Jens Hüsers
date: '2019-08-02'
slug: interpreting-logistic-regression-coefficients-odds-ratios
categories: []
tags: []
---

# Logistic Regression

The Logisitc Regression is a generalized linear model, which models the relationship between a dichotomous dependent outcome variable $y$ and a set of independent response variables $X$.

However, to get meaningful predictions on the binary outcome variable, the linear combination of regression coefficients models transformed $y$ values.
The transformations is done via the Logit, which basically is the natural logarithm of the odds, also called **Logit**: $log(\frac{p(x)}{1 - p(x)})$, where $p(x)$ is the probability that $y=$.
The log odds are modeled as a linear combinations of the predictors and regression coefficients: $\beta_0 + \beta_1x_i$

The complete model looks like this: 

$Logit = ln(\frac{p(x)}{1 - p(x)}) = \beta_0 + \beta_1x_i$

This equation shows, that the linear combination models the Logit and model coefficients $\beta$ descibe the influence of the predictors $X$ on the logit, e.g. a one unit increase in $x_i$ changes the Logit by the amout of $\beta_i$.
Unfortunatly, we do not have a reasonable intuition about the **Logit** and this makes it hard to interpret the $\beta$-coefficients.

Often, the regression coefficients of the logistic model are exponentiated and interpreted as Odds Ratios, which are easier to understand than the plain regression coefficients.

So the odds ratio tells us something about the change of the odds when we increase the predictor variable $x_i$ by one unit. In the following two sections, First, I will present a mathematial expression to show that exponentiated betas are actually the odds ratio and secondly, I will give an illustrative example in R.


# Odds Ratios

We start with the **Logit** and as explained in the introduction it is the natual logarithm of the odds. Odds are the ratio of the probability that the outcome variable will be 1 $p(Y=1)$, also considered as the proabability of success, over the proabability that it will be 0 $p(Y=0)$, sometimes considered as the probability of failure. The probabilty can also be expressed as $p(Y=0) = 1-p(Y=1)$.

So the ratio of the probability of success over the probability is simply:
