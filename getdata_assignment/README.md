Getting and Cleaning Data: Course Project
========================================================

First of all, the training (21 subjects) and the test datasets (9 subjects) have to load into R:
```{r}
x.train <- read.table("/train/X_train.txt")
subject.train <- read.table("/train/subject_train.txt")
y.train <- read.table("/train/y_train.txt")

x.test <- read.table("/test/X_test.txt")
subject.test <- read.table("/test/subject_test.txt")
y.test <- read.table("/test/y_test.txt")
```
After that one dataset is made from these two, so that we get the whole sample of 30 subjects. For that the test dataset will be attached to the training data with rbind, because the order of the data from the different volunteers is not important.
```{r}
x <- rbind(x.train, x.test)
subject <- rbind(subject.train, subject.test)
y <- rbind(y.train, y.test)
```
The next step is to extract only the mean and the standard deviation for each measurement. For that, the file with the features is loaded and the features with mean() and std() in the name can be find by using the which-function und grepl. Thus, ind1 includes the relevant rownumbers.
```{r}
features <- read.table("features.txt")
ind1<-grepl("std()",features[,2]) | grepl("mean()",features[,2])
```
After that the acitivities in the data set is renamed. For that the descriptive names in activity_lables.txt are used. A loop runs over all descriptive names and finds and replaces the respective rows in the dataset, where the number corresponds to the new activity name.

```{r}
activities <- read.table("activity_labels.txt") 
for (i in 1:nrow(activities)) {
  ind2 <- which(y==activities[i,1])
  y[ind2,] <- toString(activities[i,2])
}
```
After doing this, all vectors are combined to one vector and appropriate names are labelled. For the features of the mean and standard deviations the names are taken from features.txt.

```{r}
all <- cbind(subject,y,x[ind1])
colnames(all) <- c("subject","activitiy",sub("","",features[ind1,2]))
```

Next, a tidy dataset with the average of each variable for each activity and each subject is made. Therefor the tapply function is used to calculate the mean for each activitiy (all[,2]) and each subject (all[,1]) for one features. Because of the fact, that the tapply function built the function of a second apply-function, it is possible to calculate this for all featuresc. After that, the columns of the subjects and activities are lost, thus a new data.frame is created. Because of the fact, that during the calculation of the mean, the activity names are sorted alphabetically, it is possible to get the right order of the names with levels(activities[,2]), because by doing this, the names are sorted in the same way.

```{r}
res<-apply(all[,3:ncol(all)],2, function(x) tapply(x,list(all[,2],all[,1]),mean))
result <-data.frame(subject=rep(1:30,each=6),activity=rep(levels(activities[,2]),30),res)
```

Finally the tidy dataset has to saved in a textfile.
```{r}
write.table(result,file="tidydata.txt",row.names=FALSE)
```