# Specify regression model in JAGS
model <- "model {
  for(i in 1:N) {
    zy[i] ~ dt(mu[i], 1/zsigma^2, nu)
    mu[i] <- zbeta0 + zbeta1 * zx[i] + zbeta2 * zxsq[i]
  }
  zbeta0 ~ dnorm(0, 1/(10)^2)
  zbeta1 ~ dnorm(0, 1/10^2)
  zbeta2 ~ dnorm(0, 1/10^2)
  zsigma ~ dunif(1.0E-3, 1.0E+3)
  nu <- nuMinusOne+1  
  nuMinusOne ~ dexp(1/29.0)

}"

# Standardize variables
zx <- (mean(mtcars$wt) - mtcars$wt) / sd(mtcars$wt)
zy <- (mean(mtcars$mpg) - mtcars$mpg) / sd(mtcars$mpg)
par(mfrow = c(1, 1))
plot(x = zx, 
     y = zy, 
     xlab = "z-values of Car Weight", 
     ylab = "z-values of Miles per Gallon (MPG)", 
     main = "Relationship between Car Weight and Miles per Gallon")

# Create list that keeps data used by JAGS
# Each element corresponds to an datum in the model specification
# and each of the elements used must have the same name as in the model specification
data <- list("zx" = zx, "zy" = zy, "zxsq" = zy^2, N = length(zx))

# Compile model by using the rjags function jags.model 
jags_model <- rjags::jags.model(textConnection(model), data = data)
# Sample posterior distribution of model parameters using rjags function coda.samples
reg_model <- coda.samples(model = jags_model, variable.names = c("zbeta0", "zbeta1", "zbeta2"), n.iter = 1e4)

# Summary of posterior (marginal distribition)
summary(reg_model)
# Plot MCMC Chains and final parameter distribution
plot(reg_model)

# Predict values
pred_x <- seq(-4, 2, by = .1)
coefs <- reg_model[[1]] %>% 
  as_tibble() %>% 
  summarise_all(mean) %>% 
  unlist

# The prediction y_hat is normally distributed around the mu, the mean of this distribution 
# We can see that the prediction away from the center of the predictior distribution is more uncertain 
# than predictions in the center of the predictor variable (mpg)
par(mfrow = c(2, 1))
hist(reg_model[[1]] %*% c(1, 1, 1), xlim = c(-2, 3), seq(-2, 3, by = .025))
text(x = 0, y = 600, label = paste0("SD: ", round(sd(reg_model[[1]] %*% c(1, 1, 1)), 3)))
hist(reg_model[[1]] %*% c(1, -2, -2), xlim = c(-2, 3), seq(-2, 4, by = .025))
text(x = 0, y = 300, paste0("SD: ", round(sd(reg_model[[1]] %*% c(1, -2, -2)), 2)))
par(mfrow = c(1, 1))


# Plot 100 random sample regression lines from the posterior distribution
# Each line is transparent and darker areas indicate overlapping regression lines 
# Therefore darker areas are more credible
# Predict regression line based on the mean of the posterior distribution of each coefficient
y_hat <- coefs[1] + coefs[2] * pred_x  + coefs[3] * pred_x^2
# Plot data pairs
plot(xz, yz)

# Plot 100 random selected regression lines
for(i in seq(idx)) {
  coefs <- reg_model[[1]][i, ]
  y_hat_iter <- coefs[1] + coefs[2] * pred_x + coefs[3] * (pred_x^2)
  lines(pred_x, y_hat_iter, type = "l", col = alpha("grey50", .2))
}

# Plot the regression line based on the mean of the posterior distributions of each coefficient
lines(pred_x, y_hat, type = "l", lwd = 4, col = "red")
# Superimpose data points by plotting data pairs again
points(zx, zy, col = "black", cex = 1)
