## Loading of the training data ##

x.train <- read.table("/home/madleni/Sonstiges/Getdata/UCI HAR Dataset/train/X_train.txt")
subject.train <- read.table("/home/madleni/Sonstiges/Getdata/UCI HAR Dataset/train/subject_train.txt")
y.train <- read.table("/home/madleni/Sonstiges/Getdata/UCI HAR Dataset/train/y_train.txt")

## Loading of the test data ##

x.test <- read.table("/home/madleni/Sonstiges/Getdata/UCI HAR Dataset/test/X_test.txt")
subject.test <- read.table("/home/madleni/Sonstiges/Getdata/UCI HAR Dataset/test/subject_test.txt")
y.test <- read.table("/home/madleni/Sonstiges/Getdata/UCI HAR Dataset/test/y_test.txt")


## Merging of the datasets ##

x <- rbind(x.train, x.test)
subject <- rbind(subject.train, subject.test)
y <- rbind(y.train, y.test)


## Loading the information about the features and the activity names and extracting the features with mean and standard deviation
features <- read.table("/home/madleni/Sonstiges/Getdata/UCI HAR Dataset/features.txt")
ind1<-grepl("std()",features[,2]) | grepl("mean()",features[,2])


## Rename the activities 
activities <- read.table("/home/madleni/Sonstiges/Getdata/UCI HAR Dataset/activity_labels.txt")
for (i in 1:nrow(activities)) {
  ind2 <- which(y==activities[i,1])
  y[ind2,] <- toString(activities[i,2])
}

## Combine all Vectors to one dataset
all <- cbind(subject,y,x[ind1])
colnames(all) <- c("subject","activitiy",sub("","",features[ind1,2]))

## Tidy dataset with average of each variable for each activity and each subject
res<-apply(all[,3:ncol(all)],2, function(x) tapply(x,list(all[,2],all[,1]),mean))
result <-data.frame(subject=rep(1:30,each=6),activity=rep(levels(activities[,2]),30),res)

## Save the data
write.table(result,file="tidydata.txt",row.names=FALSE)