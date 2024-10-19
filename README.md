# Project: Spam Filter Using Bagging, Random Forest, and Boosting

## Description
This repository contains the implementation of a spam filter using various machine learning algorithms including PCA, bagging, random forest, and boosting. The feature matrix includes individual emails with features representing the count of words or characters, as well as numerical measures regarding capital letters.

The dataset is split into training and test sets, and models are built to classify emails as either spam or not spam based on these features.

The project explores:
- Random Forests with Out-Of-Bag (OOB) evaluation
- Boosting with Gradient Boosting Machines (GBM)
- Feature importance using both Random Forest and Boosting
- Comparison of training and test errors between bagging and boosting

## Dataset
The dataset (`spam.Rdata`) is provided as an R data file. It contains a feature matrix representing emails and their respective labels (spam or not spam).

## Dependencies
- R (version 3.6 or higher recommended)
- `randomForest` package
- `gbm` package

To install the necessary packages, you can run the following commands in your R environment:

```r
install.packages("randomForest")
install.packages("gbm")
```

## Usage
1. Load the dataset `spam.Rdata`.
2. Split the data into training and test sets.
3. Train models using bagging, random forest, and boosting techniques.
4. Evaluate model performance using metrics such as misclassification rate, precision, recall, sensitivity, and specificity.

To run the script, execute the RMarkdown (`.Rmd`) file in an R environment or using RStudio.

## Functions Overview
- `misClass(predClass, trueClass)`: Calculates the misclassification rate and confusion matrix.
- `checkNumberItersF(ntrees, tolParm, maxIter, verbose)`: Implements iterative computation for random forest trees until OOB error rate stabilizes.
- Gradient Boosting (`gbm`) to explore parameter tuning and evaluate test performance.


## License
This project is open-source under the MIT License. See the `LICENSE` file for more details.

## Contact
For any questions or suggestions, please create an issue in this repository.

---

### Repository Files
- `spam_filter.Rmd`: Main RMarkdown file containing all the code and analysis.
- `spam.Rdata`: The dataset used for training and testing.
- `README.md`: Overview of the repository.
- `LICENSE`: License information for this repository.

---

## Notes
- The original content for this implementation was designed for educational purposes and has been generalized for practical usage.
- The aim is to build and evaluate machine learning models for spam detection using ensemble learning techniques.
