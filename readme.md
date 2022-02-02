# Titanic: Machine Learning From Disaster: Project Overview 
* 

## Resources
**R Version:** 4.1.0  
**Packages:** ggplot2, dplyr, magrittr, DataExplorer, funModeling, aod 
**Other Resources:** https://stats.idre.ucla.edu/r/dae/logit-regression/


## Data Import/Cleaning
The dataset was provided in good condition by the Kaggle competition and doesn't need much. It includes training and test sets so we do not need to partition our own.

## Exploratory Data Analysis
I explored the data in the following ways to gain information for feature selection:

*   Examined column names, lengths, general size/shape of data.
*   Profiled percentage of missing values for each column.
*   Examined summary statistics and distributions for each column.
*   Examined relationships between columns with tables and 
*   Performed logistic (binomial logit) regression to explore relationships between my target variable (Survived) and factor columns.
*   Interpreted logit regression results with 95% confidence intervals and Wald tests.
