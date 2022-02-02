library(tidyverse)
library(magrittr)
library(DataExplorer)
library(funModeling)
library(aod)
library(ggthemes)


## Import data
training <- read_csv("train.csv")

## Cleaning
factor_cols <- c("Pclass", "Sex", "Embarked", "Survived", "SibSp", "Parch")
training %<>% mutate(across(all_of(factor_cols), as_factor))
levels(training$Pclass) <- c("First", "Second", "Third")
levels(training$Sex) <- c("Male", "Female")
levels(training$Survived) <- c("No", "Yes")
levels(training$Embarked) <- c("Southampton", "Cherbourg", "Queenstown")



## Continuous Variables
## Age
training %>%
        ggplot(aes(Age)) +
        geom_histogram(binwidth = 4, color = "black", fill = "grey") +
        geom_vline(xintercept = median(training$Age, na.rm = TRUE),
                   color = "red") +
        geom_rug(alpha = 0.2) +
        labs(title = "Age Distribution",
             x = "Age",
             y = "Number of Passengers") +
        theme_minimal()

## SibSp
training %>%
        ggplot(aes(SibSp)) +
        geom_histogram(binwidth = 1, color = "black", fill = "grey") +
        geom_vline(xintercept = median(training$SibSp, na.rm = TRUE)) +
        geom_rug(alpha = 0.2) +
        labs(title = "Siblings/Spouses Distribution",
             x = "Number of Siblings/Spouses Aboard",
             y = "Number of passengers") +
        theme_minimal()

## Parch
train %>%
        ggplot(aes(Parch)) +
        geom_histogram(binwidth = 1, color = "black", fill = "grey", stat = "count") +
        geom_vline(xintercept = median(train$Fare)) +
        geom_rug(alpha = 0.2) +
        labs(title = "Parch Distribution",
             x = "Number of Parents and Children Aboard",
             y = "Number of Passengers") +
        theme_minimal()

## Fare
train %>%
        ggplot(aes(Fare)) +
        geom_histogram(binwidth = 10, color = "black", fill = "grey") +
        geom_vline(xintercept = median(train$Fare)) +
        geom_rug(alpha = 0.2) +
        labs(title = "Fare Distribution",
             x = "Fare ($)",
             y = "Number of Passengers") +
        theme_minimal()


## Discrete Variables
## Pclass
train %>%
        ggplot(aes(Pclass)) +
        geom_bar() +
        theme_minimal()

## Survived
train %>%
        ggplot(aes(Survived)) +
        geom_bar() +
        theme_minimal()

## Sex
train %>%
        ggplot(aes(Sex)) +
        geom_bar() +
        theme_minimal()

## Embarked
train %>%
        ggplot(aes(Embarked)) +
        geom_bar() +
        theme_minimal()

## Bivariate Analysis

## Survived ~ Pclass
table(training$Survived, training$Pclass)
training %>%
        ggplot(aes(Survived)) +
        geom_bar() +
        facet_grid(Pclass ~ Embarked)

## Survived ~ Embarked
table(train$Survived, train$Embarked)
train %>%
        ggplot(aes(Embarked, Survived)) +
        geom_count() +
        theme_minimal()