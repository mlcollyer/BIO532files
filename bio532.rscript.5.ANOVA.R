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

pupfish.mr <- read.csv("pupfish.mr.csv", 
                       header = TRUE, 
                       stringsAsFactors = TRUE)

str(pupfish.mr) # or view in Environment tab

# Add a variable to the data frame

pupfish.mr$SMR <- pupfish.mr$MR / pupfish.mr$Mass

# Plot

boxplot(SMR ~ Treatment, data = pupfish.mr, 
        border = 1:2, col = "gray", notch = TRUE)
        
stripchart(SMR ~ Treatment, data = pupfish.mr, 
           pch = 19, col = 1:2, vertical = TRUE,
           add = TRUE)

# State null and alternative hypotheses:
# Ho: Variance for treatment effect, given mu = 0
# Ha: Variance for treatment effect, given mu = 0

# Confidence level = 95% (alpha = 0.05)

# Fit linear model

library(RRPP) # open RRPP library

fit1 <- lm.rrpp(SMR ~ Treatment, 
                data = pupfish.mr, 
                iter = 9, 
                print.progress = FALSE)

# linear model parts
model.matrix(fit1)
coef(fit1)
fitted(fit1)
residuals(fit1)

# Residual diagnostics
plot(fit1, which = c(1, 2))

# Perform ANOVA
anova(fit1)

# How does RRPP change things?
           
fit2 <- lm.rrpp(SMR ~ Treatment, 
                data = pupfish.mr, 
                iter = 99, 
                print.progress = FALSE)
fit3 <- lm.rrpp(SMR ~ Treatment, 
                data = pupfish.mr, 
                iter = 999, 
                print.progress = FALSE)
fit4 <- lm.rrpp(SMR ~ Treatment, 
                data = pupfish.mr, 
                iter = 9999, 
                print.progress = FALSE)
fit5 <- lm.rrpp(SMR ~ Treatment, 
                data = pupfish.mr, 
                iter = 99999, 
                print.progress = FALSE)

anova(fit1)
anova(fit2)
anova(fit3)
anova(fit4)
anova(fit5)

# Conclusion?

# Reject H0; Treatment important term in model; 
# Z-score suggests it is a large effect