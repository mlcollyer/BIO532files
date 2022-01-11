#---------------------------------------------------------------------------------
#
#  BIO532 R INTRODUCTION, just some basics for using R
#
#---------------------------------------------------------------------------------


# First thing to note, if one wants to add notes to an R script
# one must use a # to type the note
# DO THIS OFTEN!!!!  IT HELPS OTHERS UNDERSTAND YOUR INTENTION
# IT ALSO REMINDS YOU WHAT YOU WERE ATTEMPTING TO DO LATER
# FINALLY, YOU MIGHT HAVE TO SUBMIT SOME HOMEWORK USING SCRIPTS
# IF YOU HAVE TROUBLE, IT'S EASIER TO COMMUNICATE WHAT YOU WERE
# ATTEMPTING TO DO WITH ANNOTATED SCRIPTS

### Typing in data or data files

a = 4

# To look at the value of an object, just type the object name

a

# Note: R is an open-source programming language that was modeled after
# the S programming language (yes, the name is a bit of a play on the name S, but
# the original authors had the first names Ross and Robert).  The creator of the S
# programming language is a member of the R Core Development team (so no competition).
# R makes a point to work with all S programming.  In S, one must do the following,
# which also works perfectly fine in R

a <- 4

# Note that spaces are not needed.
# Note that the arrow assigns an object a value, a string of values, or a function. 
# Note that in R, as we will see later, an actual equality might need "==" (two equal signs)
# to differentiate it from an assignment.  
# Therefore, I recommend using arrows instead of equal sign.

### Other types of assignments

b <- c(4, 2, 5) # c means concatenate or combine
c <- array(1:5)
c <- 1:5
d <- array(1, 10)
e <- array(1:3, 15)
f <- rep(seq(1, 4, 1), 5) # seq means sequence (from 1 to 4 by 1s); rep = repeat (5 times)
g <- c("I", "LOVE","R",4,"STATISTICS")
h <- c("I love R for statistics")

# If one wants to assign a few variables they can type it all in
# and assemble a data frame

# E.g., 

x = c(10, 11, 14, 15, 9, 12, 8)
y = c(100, 100, 110, 100, 120, 140, 110)
z = factor(c(rep("A", 4),rep("B", 3))) # factor means a nominal/categorical variable

x
y
z

# Data Frames are the most common way to deal with data for statistical analysis
# They are matrices, but with the specific designation that columns are variables

Y = data.frame(x,y,z)
Y # each row is a subject with three values for three variables/variates

### Reading in files
# One will do this a lot, if one has data, say, in an Excel file
# or other type of spreadsheet.

# IT IS BEST TO SAVE EXCEL FILES AS TEXT DOCUMENTS.  FOR EXAMPLE, "SAVE.AS"
# THEN CHOOSE .csv or .txt

# There are different formats to use, but .csv (comma separated values) files
# work regularly and do not require knowing the difference
# between a space and a tab (values in text files can be separated or 
# 'delimited' by commas, spaces, or tabs)

### At this point, please download the CSV file, lowbwt.csv, from Brightspace/Resources/Data Files.
### Make sure you know the location of the file on your computer.
### lowbwt.csv is a set of data for babies born with low 
### birthweight (from Pagano and Gauvreau, Biostatistics, 1992)

# The simple way (if you like clicking buttons).  
# Look over to the right,
# Click on "Environment" tab, then "Import Dataset".
# Should be sort of obvious what to do...

# The purer way (if you like command line text).  
# First, change the directory in R to match that directory 
# (Session/Set Working Directory/Choose Location)
# Go to the "Session" pull-down menu
# Go to "Set Working Directory"
# Find the directory where the spreadsheet is saved.

lowbwt = read.csv("low.bwt.csv",header=T)

# look at the data in the environment (click on it in the environment - opens a spreadsheet)

# or just do this

lowbwt

# or this

View(lowbwt)

# No matter how the data were opened, look at the console

# 'read.csv' is a function.  It performs a task.  If you ever need help using a function
# use '?' followed by the function.  E.g., 

? read.csv
? factor
? seq

# Note that any spreadsheet in Excel can be saved as a text file.
# One must do this to read the file into R
# Other stats programs might be able to read Excel files
# There used to be a package for doing this in R but I beleive it had trouble 
# keeping up with Microsoft updates.  Using ext files is universal.
# JUST MAKE TEXT FILES!  Saves some headaches.

### NOTE

# When one wants to read a file from a URL directly into R....

lowbwt <- read.csv("https://raw.githubusercontent.com/mlcollyer/chatham.bio532/master/Data/lowbwt.csv")

# Note that quotes are used around the URL or file name.  They can be single or double quotes.

### Playing with the data

dim(lowbwt) # provides the dimensions of the "data frame"
str(lowbwt) # an overview of the structure of the object, lowbwt

lowbwt[33,2] # provides the value in the 33rd row and 2nd column
lowbwt[33,] # provides the entire 33rd row
lowbwt[,2] # provides the entire 2nd column

lowbwt[1:10,] # provides the first 10 rows
lowbwt[-(3:20),] # provides the entire data frame, minus the third through twentieth rows

# When objects have "sublevels", the symbol,'$',is used to strictly
# pay attention to a sublevel

# E.g.,
str(lowbwt)

# Make certain variables are turned into factors
lowbwt$sex <- factor(lowbwt$sex)
lowbwt$tox <- factor(lowbwt$tox)
lowbwt$grmhem <- factor(lowbwt$grmhem)

str(lowbwt)

lowbwt$sbp
lowbwt$apgar5

#----------------------------------------------------------------------------------

# COMMON SUMMARY FUNCTIONS

# summary, mean, median, quantile, min, max
# var, sd, IQR,
# plot (generic), barplot, boxplot, hist, rug, table

# Remember, for R, a qualitative variable is a "factor"; quantitative variables can be
# integer (discrete) or numeric (continuous)

# Quick summaries

summary(lowbwt) 

# quartiles...  (Note difference between quantile and quartile)

quantile(lowbwt$sbp, c(0.25, 0.50, 0.75)) # Quartiles are quantiles; not the other way around
quantile(lowbwt$sbp, 0.37) # 37th percentile (quantiles also called percentiles)

# histogram

hist(lowbwt$sbp)

?hist

hist(lowbwt$sbp, right = FALSE, 
     breaks = c(10, 20, 30, 40, 50, 60, 70, 80, 90))

# let's get fancier...

hist(lowbwt$sbp, right = FALSE, 
     breaks = c(10, 20, 30, 40, 50, 60, 70, 80, 90), 
     col = "yellow")

hist(lowbwt$sbp, right = FALSE, 
     breaks = c(10, 20, 30, 40, 50, 60, 70, 80, 90), 
     col = "yellow",
     xlab = "Serum Zinc, micrograms per decilitre",
     ylab = "Frequency")


# more plots

boxplot(lowbwt$sbp, ylab = "Systolic Blood Pressure, mm Hg")

boxplot(lowbwt$sbp, horizontal = TRUE, 
        xlab = "Systolic Blood Pressure, mm Hg")


boxplot(lowbwt$sbp, horizontal = TRUE, 
        xlab = "Systolic Blood Pressure, mm Hg",
        notch = TRUE,
        col = "dark red")

?boxplot


# Dispersion

var(lowbwt$sbp) # sample variance
sd(lowbwt$sbp) # sample SD
IQR(lowbwt$sbp)

#---------------------------------------------------------------------------------

### There are so many things we can do with R but it can also be overwhelming
### Future exercises will introduce new functions to use.  Do not worry about
### how much you understand right now.  Here are some goals for this session:

# 1. Be able to read in data frames
# 2. Understand what a functi is/does; e.g., var( )
# 3. Understand how to find help; e.g., ? var
# 4. Get comfortable moving around in R Studio
