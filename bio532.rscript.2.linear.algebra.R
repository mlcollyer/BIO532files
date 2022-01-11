#---------------------------------------------------------------------------------
#
#  BIO532 R LINEAR ALGEBRA
#
#---------------------------------------------------------------------------------


# Some very basic demonstration of how to do calculations 
# with vectors and matrices in R

y1 <- c(2, 3, 2, 5, 6, 8) # variable 1 with 6 observations
y2 <- c(-1, -2, 0, 0, 1, -1) # variable 2 with 6 observations
Y <- as.matrix(data.frame(y1 = y1, y2 = y2))
rownames (Y) <- paste("obs", 1:6, sep = ".") # giving our observations some names


x1 <- rep(1, 6) # variable x1 with 6 observations
x2 <- c(rep(0, 3), rep(1,3)) # variable x2 with 6 observations
X <- as.matrix(data.frame(x1 = x1, x2 = x2))
rownames(X) <- rownames(Y)

X
Y

# Inner-products.  Note how many are possible!

crossprod(x1)
crossprod(x2)
crossprod(x1, x2)
crossprod(X)

crossprod(y1)
crossprod(y2)
crossprod(y1, y2)
crossprod(Y)

crossprod(x1, y1)
crossprod(x1, y2)
crossprod(x2, y1)
crossprod(x2, y2)
crossprod(X, Y)
crossprod(Y, X)

# Invert a matrix

solve(X) # does not work
solve(crossprod(X))

# Prelude to linear models

solve(crossprod(x1)) %*% crossprod(x1, y1) # mean
solve(crossprod(X)) %*% crossprod(X, y1) # group means
solve(crossprod(X)) %*% crossprod(X, Y) # group means for two variables

# Think about how long this would take to do "by hand"

# 10,000 x 100 matrices of random values
Y <- matrix(rnorm(1000000), nrow = 10000, ncol = 100) 
X <- matrix(rnorm(1000000), nrow = 10000, ncol = 100) 

XtY <- crossprod(X, Y) # transpose of X times Y
dim(XtY)
XYt <- tcrossprod(X, Y) # X times the transpose of Y
dim(XYt)

# the first does a 100 x 100 calculation of inner products, each 10,000 values
# the second does a 10,000 x 10,000 calculation of inner products, each 100 values

system.time(crossprod(X, Y))
system.time(tcrossprod(X, Y))

# The difference is staggering but realize that 10,000 x 10,000 = 100,000,000 operations!
# yet the computer did it in probably less than 1/2 minute!




