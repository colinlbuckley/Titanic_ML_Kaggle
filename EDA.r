# Objectives
# - Top level examination of data (missing values, columns, size/shape)
# - Univariate analysis
# - Bivariate analysis
# - Select potential features for ML model (target variable is "Survived")

# 0 Setup and Cleaning ----

# Load dependencies
library(tidyverse)
library(magrittr)
library(DataExplorer)
library(funModeling)
library(aod)

# Import data
training <- read_csv("train.csv")

# Cleaning
factor_cols <- c("Pclass", "Sex", "Embarked", "Survived", "SibSp", "Parch")
training %<>% mutate(across(all_of(factor_cols), as_factor))
levels(training$Pclass) <- c("First", "Second", "Third")
levels(training$Sex) <- c("Male", "Female")
levels(training$Survived) <- c("No", "Yes")
levels(training$Embarked) <- c("Southampton", "Cherbourg", "Queenstown")


# 1 EDA ---- 

# Examine column names/length
glimpse(training) # Notice we can confirm our factors are assigned correctly

# Profile Missing Values
colMeans(is.na(training)) # Proportion of missing values per column

# Broad Examination of Variables
summary(training)
status(training)
profiling_num(training)
plot_num(training)
describe(training)


# 2 Logistic Regression Analysis ----

# Check for Missing Cells in Categorical Comparisons
xtabs(~ Survived + Pclass, data = training)
xtabs(~ Survived + Sex, data = training)
xtabs(~ Survived + Embarked, data = training)
xtabs(~ Survived + Parch, data = training)
xtabs(~ Survived + SibSp, data = training)


# * 2.1 Bivariate Logit Regression ----
# Survived ~ Pclass
logit_Pclass <- glm(Survived ~ Pclass, family = binomial(link="logit"), data = training)
summary(logit_Pclass)
confint(logit_Pclass)

# Survived ~ Sex
logit_Sex <- glm(Survived ~ Sex, family = binomial(link="logit"), data = training)
summary(logit_Sex)
confint(logit_Sex)


# * 2.2 Multivariate Logit Regressions ----

# Survived ~ Pclass + Sex
logit_Pclass_Sex <- glm(Survived ~ Pclass + Sex, family = binomial(link="logit"), data = training)
summary(logit_Pclass_Sex)
confint(logit_Pclass_Sex)
stargazer(logit_Pclass_Sex)

wald.test(b = coef(logit_Pclass_Sex), Sigma = vcov(logit_Pclass_Sex), Terms = 2:3)

# Survived ~ Pclass + Sex + Fare
logit_Pclass_Sex_Fare <- glm(Survived ~ Pclass + Sex + Fare, family = binomial(link="logit"), data = training)
summary(logit_Pclass_Sex_Fare)
confint(logit_Pclass_Sex_Fare)

# Wald test for overall impact of Pclass
wald.test(b = coef(logit_Pclass_Sex_Fare), Sigma = vcov(logit_Pclass_Sex_Fare), Terms = 2:3)

# Another Wald test on the hypothesis Pclass2 - Pclass3 = 0 tests the 
# significance of the difference between ranks of Pclass.
l <- cbind(0, 1, -1, 0, 0)
wald.test(b = coef(logit_Pclass_Sex_Fare), Sigma = vcov(logit_Pclass_Sex_Fare), L = l)


# Conclusions ---- 