# Import data
activity <- read.csv("activity.csv")
# libraries
library(ggplot2)
library(dplyr)
Sys.setlocale("LC_TIME", "English")
# some information about the variables
str(activity)
