# Data Science Final Project - UCL Prediciton 

- A data-driven analysis of Tommy John injury in the MLB between 2018 and 2024.

## Overview

- This research project investigates potential correlating factors between pitches thrown and pitchers who undergo Tommy John surgery (ulnar collateral ligament reconstruction). The study employs both traditional machine learning models and bayesian approaches to build a strong framework to better predict Tommy John Injury.
- Machine Learning models were used as preliminarily methods to root out predictors that had limited impact upon predicting Tommy John Surgery. The focus of this study was on 'common' pitch types like fastball, slider, and curveball to build a framework that could predict if a certain ball came from a injured pitcher or not.
- All of the preliminary work with the machine learning models was used to build a strong Bayesian Regression Model for predicitng injury outcomes, which had mixed results.

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
