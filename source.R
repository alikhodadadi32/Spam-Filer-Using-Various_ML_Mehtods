# Spam Filter and Principal Component Analysis (PCA)

# Load Packages
```r
require(igraph)
require(dplyr)
```

# Introduction
In this project, we create a simple spam filter using an existing feature matrix. The dataset includes individual emails and several features extracted from these emails, such as word counts, punctuation, and capital letter metrics.

# Load Dataset
```r
load('spam.Rdata')
Xfull = spam$XdataF

# Removing 'word' features and retaining 'punc' and 'cap' features
X = Xfull %>% select(contains('punc'), contains('cap'))

n = dim(X)[1] # Number of observations
p = dim(X)[2] # Number of features
```

We have `r n` number of emails (observations) and `r p` features.

# Graphical Models

## Bootstrap Method
We estimate a partial correlation graph using 500 bootstrap draws, drawing an edge between two nodes if 0 is not in the bootstrap confidence interval.

```r
B = 500
Rhat_starOutput = array(dim = c(p, p, B))
for (b in 1:B) {
  bootSamp = sample(1:n, n, replace = TRUE)
  X_star = X[bootSamp, ]
  S_star = cov(X_star)
  OmegaHat_star = solve(S_star)
  Rhat_star = -diag(1 / sqrt(diag(OmegaHat_star))) %*% OmegaHat_star %*% diag(1 / sqrt(diag(OmegaHat_star)))
  Rhat_starOutput[, , b] = Rhat_star
}

noedge = apply(Rhat_starOutput, c(1, 2), quantile, 0.005) < 0 & apply(Rhat_starOutput, c(1, 2), quantile, 0.995) > 0
g = graph.adjacency(!noedge, mode = "undirected", diag = FALSE)
plot(g, layout = layout.auto, vertex.color = 'white', vertex.size = 3, vertex.label = names(X), vertex.frame.color = NA)
```

## QQ Plots for Normality
We investigate if the partial correlation graph can be extended to conditional independence.

```r
par(mfrow = c(3, 3))
for (j in 1:p) {
  qqnorm(X[, j], main = colnames(X)[j], xlab = "Theoretical Quantiles", ylab = "Sample Quantiles")
  qqline(X[, j], col = 'red', probs = c(0.25, 0.75))
}
```

# Principal Component Analysis (PCA)

## Scree Plots
Get the PCA of the stock price data and make a scree plot.

```r
StockPrices <- read.csv("stock_prices.csv")
pca_out <- prcomp(scale(StockPrices, center = TRUE, scale = FALSE))
plot(seq(1, length(pca_out$sdev)), cumsum((pca_out$sdev)^2 / sum((pca_out$sdev)^2)), type = "l", xlab = "Components", ylab = "Variance")
```

Retain `r nPCs` principal components to retain 90% of the variance.

# Conclusion
This project involved creating a spam filter using graphical models and leveraging PCA for exploratory data analysis of stock price data. The partial correlation graph and PCA helped to understand relationships among features and reduce dimensionality for analysis.
