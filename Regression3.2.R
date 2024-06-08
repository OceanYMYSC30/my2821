library(ISLR)
library(glmnet)
library(caret)
library(dplyr)
library(ggplot2)

data(Hitters)
hitters = na.omit(Hitters)

X = model.matrix(Salary ~ ., hitters)[, -1]
y = hitters$Salary

set.seed(42)
trainIndex = createDataPartition(y, p = 0.8, list = FALSE)
X_train = X[trainIndex, ]
X_test = X[-trainIndex, ]
y_train = y[trainIndex]
y_test = y[-trainIndex]

lambdas = 10^seq(5, -5, length = 100)

# Perform cross-validation to find the best lambda
cv_df = cv.glmnet(X_train, y_train, alpha = 0, lambda = lambdas)
best_lambda = cv_df$lambda.min

# Fit the Ridge Regression model with the best lambda
df_model = glmnet(X_train, y_train, alpha = 0, lambda = best_lambda)

# Predict on the test set and calculate the MSE
y_pred = predict(df_model, s = best_lambda, newx = X_test)
out_sample_mse = mean((y_test - y_pred)^2)

# Create a dataframe for plotting
MSE_df = data.frame(lambda = cv_df$lambda, in_sample_mse = cv_df$cvm)

# Plotting In-Sample and Out-Sample MSE by lambda using ggplot2
ggplot(MSE_df, aes(x = lambda, y = in_sample_mse)) +
  geom_line(color = "black") +
  geom_hline(yintercept = out_sample_mse, linetype = "dashed", color = "orange") +
  scale_x_log10() +
  labs(title = "In-Sample and Out-Sample MSE by Lambda", x = "Lambda", y = "MSE") + theme_minimal() +
  annotate("text", x = min(cv_df$lambda), y = out_sample_mse, 
           label = paste("Out-Sample MSE:", round(out_sample_mse, 2)), 
           vjust = -1, color = "orange") +
  annotate("text", x = best_lambda, y = min(cv_df$cvm), 
           label = paste("Best Lambda:", round(best_lambda, 2)), 
           vjust = -1, color = "black")

# Print the best lambda and MSE values
cat("Best lambda:", best_lambda, "\n")
cat("In-Sample MSE (at best lambda):", min(cv_df$cvm), "\n")
cat("Out-Sample MSE:", out_sample_mse, "\n")

