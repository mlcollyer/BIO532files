#---------------------------------------------------------------------------------
#
#  BIO532 Linear Regression and Correlation
#
#------------------------------------------------------------------------------

# Read in the pupfish MR data
# Either use the Import Dataset tab or change working directory to where the 
# pupfish.mr.csv file is found and run command below.  (To change the directory 
# in R Studio: Session --> Set Working Directory --> Choose location.  
# A pop-up window will appear.)

pupfish.mr <- read.csv("pupfish.mr.csv", header = TRUE, stringsAsFactors = TRUE)

pupfish.mr <- pupfish.mr[!rownames(pupfish.mr) == "58",] # remove aberrant observation -- see text

plot(MR ~ Mass, data = pupfish.mr,
     pch = 19, col = as.numeric(pupfish.mr$Treatment))
legend("topleft", levels(pupfish.mr$Treatment), pch = 19, col = 1:2)

# Model matrices (null and alternative)

model.matrix(log(MR) ~ 1, data = pupfish.mr)[1:10, ] # just first 10 observations
model.matrix(log(MR) ~ log(Mass), data = pupfish.mr)[1:10, ] # just first 10 observations


# Coefficient estimation

library(RRPP)
fit0 <- lm.rrpp(log(MR) ~ 1, data = pupfish.mr, 
                iter = 9999, 
                print.progress = FALSE)
fit1 <- lm.rrpp(log(MR) ~ log(Mass), data = pupfish.mr, 
                iter = 9999,
                print.progress = FALSE)
coef(fit0)
coef(fit1)


# Residuals and Assumptions

par(mfrow = c(2,2))
plot(fit1)


# Scatterplot with best fit line

# Linear
par(mfrow = c(1, 1))
plot(log(MR) ~ log(Mass), data = pupfish.mr,
     pch = 19)

abline(fit1, col = "blue")


# Exponential
plot(MR ~ log(Mass), data = pupfish.mr,
     pch = 19)
points(log(pupfish.mr$Mass), exp(fitted(fit1)), pch = 19, col = "blue")


# ANOVA (sampling distributions for model comparison statistics) and Null hypothesis evaluation

anova(fit1)


# Correlation

cor(log(pupfish.mr$MR), log(pupfish.mr$Mass))


# Linear model exegesis

model.matrix(fit1)

# new variable
x <- model.matrix(fit1)[,2]

model.matrix(~ x) # same result!

pupfish.mr$x <- x
fit2 <- lm(log(MR) ~ x, data = pupfish.mr)
fit3 <- lm(log(MR) ~ Treatment, data = pupfish.mr)

coef(fit2)
coef(fit3) # these are the same, but x is continuous!

# Plot with continuous x

plot(log(MR) ~ x, data = pupfish.mr,
     pch = 19)

abline(fit2, col = "dark green")
points(0, coef(fit3)[1], pch = 19, 
       cex = 1.5, col = "dark green") # Control mean
points(1, coef(fit3)[1] + coef(fit3)[2], pch = 19, 
       cex = 1.5, col = "dark green") # Infected mean

# There is no difference between categorical and continuous x

### THE POINT IS THAT THERE IS NO DIFFERENCE BETWEEN SINGLE FACTOR ANOVA
### AND LINEAR REGRESSION