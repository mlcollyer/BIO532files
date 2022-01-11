#---------------------------------------------------------------------------------
#
#  BIO532 Linear Prediction
#
#------------------------------------------------------------------------------

# Read in the pupfish MR data
# Either use the Import Dataset tab or change working directory to where the 
# pupfish.mr.csv file is found and run command below.  (To change the directory 
# in R Studio: Session --> Set Working Directory --> Choose location.  
# A pop-up window will appear.)


# A good idea to make sure that RRPP is most current:

devtools::install_github("mlcollyer/RRPP",
                         build_vignettes = TRUE,
                         force = TRUE)

library(RRPP)

pupfish.mr <- read.csv("pupfish.mr.csv", header = TRUE, stringsAsFactors = TRUE)

pupfish.mr <- pupfish.mr[!rownames(pupfish.mr) == "58",] # remove aberrant observation -- see text

plot(MR ~ Mass, data = pupfish.mr,
     pch = 19, col = as.numeric(pupfish.mr$Treatment))
legend("topleft", levels(pupfish.mr$Treatment), pch = 19, col = 1:2)

# ------------------------------------------------------------------------------
# See R scripts 5-7  for ANOVA details.

# See Chapter 8 for plotting details.  The script below is for making predictions,
# only, and should be the focus for problem-solving.

# ------------------------------------------------------------------------------

### Model fits

# Need to do this trick

pupfish.mr$logMass <- log(pupfish.mr$Mass)
pupfish.mr$logMR <- log(pupfish.mr$MR)

# This will allow us to remove the log() function from the formula,
# which cause problems with the predict function

fit1 <- lm.rrpp(logMR ~ Treatment, data = pupfish.mr, iter = 9999)
fit2 <- lm.rrpp(logMR ~ logMass, data = pupfish.mr, iter = 9999)

# Predictions for categorical  levels

nd <- data.frame(Treatment = c("CONTROL", "INFECTED"))
preds1 <- predict(fit1, newdata = nd, confidence = 0.95)
summary(preds1)

# Note that 1 = Female; 2 = Male
# Note that "Predicted values" are means from 10,000 bootstrap values

# 95% CI for Control fish: -0.84, -0.59
# 95% CI for Infected fish: -1.07, -0.83


# Predictions for continuous variables

# Fish weighing 1 gram, 1.5 grams, or 2 grams

nd <- data.frame(logMass = log(c(1, 1.5, 2)))
preds2 <- predict(fit2, newdata = nd, confidence = 0.95)
summary(preds2)

# Note that 1, 2, 3 are the three fish, in order, but 1, 2, 3
# does not mean 1, 2, 3 grams 

# 95% CI for 1 g fish: -0.65, -0.47
# 95% CI for 1.5 g fish: -0.35, -0.04
# 95% CI for 2 g fish: -0.16, +0.27

# All of the above can be plotted, as in the examples in Chapter 8,
# but it is more important to know how to obtain and interpret these values.





