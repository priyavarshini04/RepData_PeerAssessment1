1. Total number of missing values in the dataset

# table for dplyr
ACT <- tbl_df(activity)
# find the column
ACT %>% filter(is.na(steps)) %>% summarize(missing_values = n())
## Source: local data frame [1 x 1]
## 
##   missing_values
##            (int)
## 1           2304


#2. Replace missing values
The rounded values of the average 5-minute interval is used to replace the NA values.
CompleteSteps is the new column without missing values.

# values without NA are imputed in a new column
activity$CompleteSteps <- ifelse(is.na(activity$steps), round(StepsPerTime$steps[match(activity$interval, StepsPerTime$interval)],0), activity$steps)


#3. New dataset that is equal to the original dataset but with the missing data filled in
The first ten values of the new dataset are shown below.

# new dataset activityFull
activityFull <- data.frame(steps=activity$CompleteSteps, interval=activity$interval, date=activity$date)
# see first 10 values of the new dataset
head(activityFull, n=10)


#4A. Histogram of the total number of steps taken each day with missing data filled in

# prepare data
StepsPerDayFull <- aggregate(activityFull$steps, list(activityFull$date), FUN=sum)
colnames(StepsPerDayFull) <- c("Date", "Steps")
# draw the histogram
g <- ggplot(StepsPerDayFull, aes(Steps))
g+geom_histogram(boundary=0, binwidth=2500, col="darkblue", fill="lightblue")+ggtitle("Histogram of steps per day")+xlab("Steps")+ylab("Frequency")+theme(plot.title = element_text(face="bold", size=12))+scale_x_continuous(breaks=seq(0,25000,2500))+scale_y_continuous(breaks=seq(0,26,2))


#4B. Calculate and report the mean and median total number of steps taken per day. Do these values differ from the estimates from the first part of the assignment? What is the impact of imputing missing data on the estimates of the total daily number of steps?

# Mean
mean(StepsPerDayFull$Steps)
## [1] 10765.64
#Median
median(StepsPerDayFull$Steps)
## [1] 10762
