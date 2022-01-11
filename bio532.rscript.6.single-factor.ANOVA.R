#---------------------------------------------------------------------------------
#
#  BIO532 ANOVA
#
#---------------------------------------------------------------------------------

# The same examples as in Chapter 5

######### IMPORTANT ###########

# BEFORE GOING FURTHER, DO THESE TWO THINGS:

install.packages("devtools") # Do this just this once

devtools::install_github("mlcollyer/RRPP", 
                         build_vignettes = TRUE) # Do this every script

# The reason for doing that above is that RRPP is a package published on 
# CRAN but it takes a long time to update it.  On Github it can be updated instantly.
# As the instructor is also the RRPP author, it is better to make sure updates
# can happen fast.

###----------------------------------------------------------------------------------

# Read in the pupfish MR data
# Either use the Import Dataset tab or change working directory to where the 
# pupfish.mr.csv file is found and run command below.  (To change the directory 
# in R Studio: Session --> Set Working Directory --> Choose location.  
# A pop-up window will appear.)

calluna <- read.csv("calluna.csv", 
                       header = TRUE, 
                       stringsAsFactors = TRUE)

str(calluna) # or view in Environment tab

calluna <- calluna[c("treatment", "cn.ratio")] # eliminate unneeded columns
calluna <- na.omit(calluna) # Eliminate rows with NA as values
str(calluna)

# Plot

boxplot(cn.ratio ~ treatment, data = calluna, 
        border = 1:4, col = "gray")
stripchart(cn.ratio ~ treatment, data = calluna, 
           pch = 19, col = 1:4, vertical = TRUE,
           add = TRUE)


# State null and alternative hypotheses:
# Ho: Variance for treatment effect, given mu = 0
# Ha: Variance for treatment effect, given mu = 0

# Confidence level = 95% (alpha = 0.05)

# Fit linear model

library(RRPP) # open RRPP library

fit1 <- lm.rrpp(cn.ratio ~ treatment, 
                data = calluna, 
                iter = 9999, 
                print.progress = TRUE)

# linear model parts
model.matrix(fit1)
coef(fit1)
fitted(fit1)
residuals(fit1)

# Residual diagnostics
plot(fit1, which = c(1, 2))

# Perform ANOVA
anova(fit1)

# Conclusion?

# Reject H0; Treatment important term in model; 
# Z-score suggests it is a large effect

# We are not done !!! ---------------------------------------------------------

PW <- pairwise(fit1, groups = calluna$treatment)
summary(PW, confidence = 0.95, show.vectors = TRUE)

# Conclusion?

# In terms of means
# D no different than Control
# N > Control
# D + N > Control
# D + N > N?  (Close but cannot reject H0)
