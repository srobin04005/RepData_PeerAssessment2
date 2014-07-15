setwd("C:\\Users\\srobin\\Documents\\GitHub\\RepData_PeerAssessment1\\RepData_PeerAssessment1-master")
active <- read.csv(paste0(getwd(),"\\activity\\activity.csv"))

summary(active)

activeComplete <- active[complete.cases(active),]
activeComplete$dow <- weekdays(as.Date(activeComplete$date))

replaceMissing <- active[complete.cases(active),]
replaceMissing$dow <- weekdays(as.Date(activeComplete$date))

mean_steps_per_Day <- aggregate(activeComplete$steps, 
                                by=list(interval = activeComplete$interval,
                                        dow = activeComplete$dow),
                                FUN=mean)

dowMean <- mean_steps_per_Day[,1:3]
names(dowMean)[1:3] <-  c("interval","dow","steps")

missing <- subset(active, is.na(active$steps))
missing$dow <- weekdays(as.Date(missing$date))

miss <- aggregate(missing$steps,by=list(date=missing$date),mean)
miss$dow <- weekdays(as.Date(miss$date))



for(i in 1:nrow(miss)){

  mUse <- subset(missing,missing$date == miss$date[i])
  iData <- subset(mean_steps_per_Day, mean_steps_per_Day$dow == miss$dow[i])
  names(iData)[3] <- "steps"
  
  mUse$steps <- ifelse(is.na(mUse$steps),
                          iData$steps[mUse$interval==iData$interval] ,
                          mUse$steps)
  
  # merge missing and activeComplete 
  replaceMissing <- rbind(mUse,replaceMissing)
 
  
}


meanTotal <- mean(activeComplete$steps)
meanA <- mean(replaceMissing$steps)

                     