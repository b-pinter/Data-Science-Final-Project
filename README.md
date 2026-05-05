# Tommy John Surgery Research

- A data-driven analysis exploring the relationship between pitching characteristics and Tommy John surgery outcomes using Bayesian statistical methods and machine learning.

## Overview

- This research project investigates potential correlating factors between pitches thrown and pitchers who undergo Tommy John surgery (ulnar collateral ligament reconstruction). The study employs Bayesian statistical methods to identify  correlations and develop predictive models for surgery risk assessment.

**Research Presentation:** 
- Preliminary findings were presented at the Conneticut Sports Analytics Symposium (CSAS) 2026 at UCONN.

## Features

- **Data Collection & Processing**: Automated web scraping and data cleaning pipelines using BaseballR
- **Statistical Modeling**: Multiple analytical approaches including:
  - Multiple Linear Regression
  - Logistic Regression
  - Shrinkage and Variable Importance 
    - LASSO / Ridge Regression
    - Priniciple Component Regression
    - Partial Least Squares Regression
  - Random Forest
  - Bayesian Regression Model using STAN (BRMS)

## Repository Structure

```
├── Baseball_Basics.R          # Data gathering and cleaning scripts
├── MachineLearningModels.qmd  # Pitch Analysis and Prediction using Machine Learning 
├── ProjectProposal.pdf        # Project Outline and semester long goals
├── RegressionBoundaries.qmd   # Model tuning 
├── SPARK_Presenation.pdf      # Project Presenation
├── data_smaller.csv           # Data used for project
└── data_completed_na.csv      # A cleaned version of data_smaller.csv
```

## Technologies Used

### R Environment
- **BaseballR**: MLB data acquisition and processing
- **RStan**: Bayesian statistical modeling and inference
- **tidyverse**: Data manipulation and visualization

### Running Statistical Analysis

Open and execute the R files in RStudio or your preferred R environment:
1. Start with `Baseball_Basics.R` for data preparation
2. Explore `MachineLearningModels.qmd` and `RegressionBoundaries.qmd` for model development and use

## Methodology

The research pipeline consists of:

1. **Data Collection**: Aggregating pitcher statistics and Tommy John surgery records using BaseballR
2. **Feature Engineering**: Extracting relevant pitching metrics and temporal patterns
3. **Model Development**: Building and comparing multiple statistical and machine learning models
4. **Bayesian Inference**: Implementing hierarchical models to account for individual pitcher variability
5. **Validation**: Cross-validation and prediction accuracy assessment
6. **Visualization**: Interactive exploration of patterns and predictions

## Key Findings

The project identifies correlations between specific pitching patterns and Tommy John surgery risk, with the Bayesian hierarchical model providing probabilistic predictions that account for individual pitcher characteristics and uncertainty in the data.

## Contact

www.linkedin.com/in/brady-pinter
