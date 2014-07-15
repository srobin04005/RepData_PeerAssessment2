setwd("C:\\Users\\srobin\\Documents\\GitHub\\RepData_PeerAssessment1\\RepData_PeerAssessment1-master")
active <- read.csv(paste0(getwd(),"\\activity\\activity.csv"))

summary(active)

activeComplete <- active[complete.cases(active),]
activeComplete$dow <- weekdays(as.Date(activeComplete$date))


##meanTotal <- mean(activeComplete$steps)

missing <- subset(active, is.na(active$steps))
missing$dow <- weekdays(as.Date(missing$date))

activeComplete$dow <- weekdays(as.Date(activeComplete$date))

mean_Interval <- aggregate(activeComplete, 
                           by=list(interval=activeComplete$interval, dow=activeComplete$dow),
                           FUN=mean)
subI <- mean_Interval[,1:3]

total <- merge(missing,subI,by=c("interval","dow"))
data <- read.csv('data.csv') 
data = as.matrix(data) 
indx <- which(is.na(data[, 3])==TRUE) 
data[indx, 3] = "NAReplaced" 
data = data.frame(data) 

missing$Value <- ifelse(is.na(missing$Value), 
                    breaks$Value[match(df1$Break, breaks$Break)], 
                    df1$Value)



