#---------------------------------------------------------------------------------
#
#  BIO532 R The General Linear Model
#
#---------------------------------------------------------------------------------

# The same examples as in Chapter 3

set.seed(21) # This is a trick to set the seed for random numbers (not needed)

# After running through this, come back and set the seed to a different number 
# to see what happens.

# Create random data

y <- c(rnorm(10, mean = 0.9, sd = 0.2), rnorm(10, mean = 0.6, sd = 0.2))
y

group1 <- factor(c(rep("Mexico", 10), rep("USA", 10)), levels = c("Mexico", "USA"))
group2 <- factor(c(rep("Mexico", 10), rep("AZ-NM", 5), rep("NM", 5)), 
                 levels = c("Mexico", "AZ-NM", "NM"))

group1
group2

# Make a data frame (always a good idea!)

df <- data.frame(y = y, group1 = group1, group2 = group2)

df


# Plots
par(mfrow = c(1, 2)) # make a two-panel canvas, by row

# Strip-chart style plots
stripchart(y ~ group1, pch = 19, data = df, vertical = TRUE)
stripchart(y ~ group2, pch = 19, data = df, vertical = TRUE)

par(mfrow = c(1, 1)) # Reset the canvas

#### GLM STEPS ---------------------------------------------------

# "By Hand"

# Model (design) matrices

X0 <- model.matrix(y ~ 1, data = df)
X1 <- model.matrix(y ~ group1, data = df)
X2 <- model.matrix(y ~ group2, data = df)

X0
X1
X2

# Coefficients

b0 <- solve(crossprod(X0)) %*% crossprod(X0, y)
b1 <- solve(crossprod(X1)) %*% crossprod(X1, y)
b2 <- solve(crossprod(X2)) %*% crossprod(X2, y)

b0
b1
b2

# With the help of R

fit0 <- lm(y~ 1, data = df)
fit1 <- lm(y~ group1, data = df)
fit2 <- lm(y~ group2, data = df)

# coefficients

coef(fit0)
coef(fit1)
coef(fit2)

# fitted values

fitted(fit0)
fitted(fit1)
fitted(fit2)

# residuals

resid(fit0)
resid(fit1)
resid(fit2)

e0 <- resid(fit0)
e1 <- resid(fit1)
e2 <- resid(fit2)

# RSS

RSS0 <- crossprod(e0)
RSS1 <- crossprod(e1)
RSS2 <- crossprod(e2)

RSS0
RSS1
RSS2

# The R summary for linear model fits

summary(fit1)

# How R finds Rsq and F

MS1 <- (RSS0 - RSS1) / (ncol(X1) - ncol(X0))
MSE1 <- RSS1 / (nrow(X1) - ncol(X1))

MS1 / MSE1 # F stat
(RSS0 - RSS1) / RSS0 # Rsq
sqrt(MSE1) # SE of model


summary(fit2)

MS2 <- (RSS0 - RSS2) / (ncol(X2) - ncol(X0))
MSE2 <- RSS2 / (nrow(X2) - ncol(X2))

MS2 / MSE2 # F stat
(RSS0 - RSS2) / RSS0 # Rsq
sqrt(MSE2) # SE of model

# Diagnostics

par(mfrow = c(1,2)) # 1 x 2 plotting canvas
plot(fit1, which = 1:2)

par(mfrow = c(1,2)) # 1 x 2 plotting canvas
plot(fit2, which = 1:2)

par(mfrow = c(1,2) # reset canvas
