#---------------------------------------------------------------------------------
#
#  BIO532 Hypothesis-testing with Sampling Distributions 
#  for Linear Model Statistics
#
#---------------------------------------------------------------------------------

# The same examples as in Chapter 4

set.seed(21) # This is a trick to set the seed for random numbers (not needed)

# Data and Group variable

y <- c(rnorm(10, mean = 0.9, sd = 0.2), rnorm(10, mean = 0.6, sd = 0.2))
group1 <- factor(c(rep("Mexico", 10), rep("USA", 10)), 
                 levels = c("Mexico", "USA"))

df <- data.frame(y = y, group1 = group1)

df

# Linear Model Statistics

fit0 <- lm(y ~ 1, data = df)
fit1 <- lm(y ~ group1, data = df)

fit0
fit1

X0 <- model.matrix(fit0)
X1 <- model.matrix(fit1)

X0
X1

coef(fit0)
coef(fit1)

fitted(fit0)
fitted(fit1)

resid(fit0)
resid(fit1)

e0 <- resid(fit0)
e1 <- resid(fit1)

RSS0 <- crossprod(e0)
RSS1 <- crossprod(e1)

RSS0
RSS1


# Model-Comparison Statistics

SS1 <- RSS0 - RSS1

SS1

Rsq1 <- SS1 / RSS0

Rsq1

df1 <- ncol(X1) - ncol(X0) # degrees of freedom for the group1 1 effect 

MS1 <- SS1 / df1

MS1

dfr1 <- nrow(X1) - ncol(X1) # degrees of freedom for the residuals

MSE1 <- RSS1 / dfr1

MSE1

F1 <- MS1 / MSE1

F1


#-------------------------------------------------------------------------
# Null hypothesis (H0): variance of group effect = 0 (variance estimated as MS)
# Alternative hypothesis (H1): variance of group effect > 0 
#-------------------------------------------------------------------------


# RRPP: The method of generating sampling distributions.  How does it work?

y.r1 <- fitted(fit1) + sample(resid(fit1))
y.r2 <- fitted(fit2) + sample(resid(fit2))

y  # observed (counts as one permutation)
y.r1 # first random permutation
y.r2 # second random permutation

fit1.r1 <- lm(y.r1 ~ group1)
fit1.r2 <- lm(y.r2 ~ group1)

# See how statistics change below:

summary(fit1) # observed
summary(fit1.r1) # first random permutation after observed
summary(fit1.r2) # second random permutation after observed

# How do we repeat this many times?

install.packages("RRPP") # Or go to the tools drop-down menu

library(RRPP)

fit1.rrpp <- lm.rrpp(y ~ group1, 
                     data = df, 
                     print.progress = TRUE, 
                     iter = 999)

coef(fit1)
coef(fit1.rrpp)


# What does lm.rrpp do for us?

attributes(fit1.rrpp)

# Just the $LM bin

attributes(fit1.rrpp$LM)

# E.g.,

fit1.rrpp$LM$n
fit1.rrpp$LM$coefficients
fit1.rrpp$LM$fitted
fit1.rrpp$LM$residuals

# Now let's look at the `$ANOVA` bin.

attributes(fit1.rrpp$ANOVA)

# Notice some statistics look familiar

# Use attach and detach to liberate components to the search path

attach(fit1.rrpp$ANOVA)

RSS[, 1:100] # just the first 100
SS[, 1:100] # just the first 100
MS[, 1:100] # just the first 100
Rsq[, 1:100] # just the first 100
Fs[, 1:100] # just the first 100

detach(fit1.rrpp$ANOVA)

# Let's create a 2 x 2 plotting canvas

par(mfrow = c(2, 2))

attach(fit1.rrpp$ANOVA)

hist(SS, col = "gray")
abline(v = SS[1]) # note the location of the observed value
hist(MS, col = "gray")
abline(v = MS[1]) # note the location of the observed value
hist(Rsq, col = "gray")
abline(v = Rsq[1]) # note the location of the observed value
hist(Fs, col = "gray")
abline(v = Fs[1]) # note the location of the observed value

detach(fit1.rrpp$ANOVA)

par(mfrow = c(1, 1)) # reset the canvas


# Plots!

# Let's create a 2 x 2 plotting canvas
attach(fit1.rrpp$ANOVA)

# where our observed value ranks from small to large
rank(SS)[1] 
# probability of finding a value larger 
1 - rank(SS)[1] / length(SS) 
# probability of finding a value as large or larger 
1 - (rank(SS)[1] - 1) / length(SS) 

# and likewise
1 - (rank(MS)[1] - 1) / length(MS) 
1 - (rank(Rsq)[1] - 1) / length(Rsq) 
1 - (rank(Fs)[1] - 1) / length(Fs) 

detach(fit1.rrpp$ANOVA)

# Conclusion: reject H0

# -----------------------------------------------------------------

# Why statistics with computers is wonderful.  
# Let's see how long it takes to do computations

# How long does it take to do 1,000 permutations?

system.time(lm.rrpp(y~group1, data = df, print.progress = FALSE, iter = 999))

# How long does it take to do 10,000 permutations?

system.time(lm.rrpp(y~group1, data = df, print.progress = FALSE, iter = 9999))

# How long does it take to do 100,000 permutations?

system.time(lm.rrpp(y~group1, data = df, print.progress = FALSE, iter = 99999))


