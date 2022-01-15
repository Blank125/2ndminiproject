#run_analysis.R
#this script is used for the first problem in the miniproject

library(dplyr)

#assigning data

feats <- read.table("specdata/UCI HAR Dataset/features.txt", col.names = c("n","functions"))
acts <- read.table("specdata/UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))

xtrain <- read.table("specdata/UCI HAR Dataset/train/X_train.txt", col.names = feats$functions)
ytrain <- read.table("specdata/UCI HAR Dataset/train/y_train.txt", col.names = "code")
subjtrain <- read.table("specdata/UCI HAR Dataset/train/subject_train.txt", col.names = "subject")

xtest <- read.table("specdata/UCI HAR Dataset/test/X_test.txt", col.names = feats$functions)
ytest <- read.table("specdata/UCI HAR Dataset/test/y_test.txt", col.names = "code")
subjtest <- read.table("specdata/UCI HAR Dataset/test/subject_test.txt", col.names = "subject")

############################################################################################################
#Merges the training and test sets to create one data set

train <- cbind(subjtrain, xtrain, ytrain)
test <- cbind(subjtest, xtest, ytest)
mergedData <- rbind(train, test)

############################################################################################################
#Extracts only the measurements on the mean and standard deviation for each measurement

extractedData <- mergedData %>% 
  select(subject, code, contains("mean"), contains("std"))

############################################################################################################
#Uses descriptive activity names to name the activities in the dataset

extractedData$code <- acts[extractedData$code, 2]

############################################################################################################
#Appropriately labels the data set with descriptive variable names

names(extractedData)[2] = "activity"
names(extractedData)<-gsub("Acc", "Accelerometer", names(extractedData))
names(extractedData)<-gsub("Gyro", "Gyroscope", names(extractedData))
names(extractedData)<-gsub("BodyBody", "Body", names(extractedData))
names(extractedData)<-gsub("Mag", "Magnitude", names(extractedData))
names(extractedData)<-gsub("^t", "Time", names(extractedData))
names(extractedData)<-gsub("^f", "Frequency", names(extractedData))
names(extractedData)<-gsub("tBody", "TimeBody", names(extractedData))
names(extractedData)<-gsub("-mean()", "Mean", names(extractedData), ignore.case = TRUE)
names(extractedData)<-gsub("-std()", "STD", names(extractedData), ignore.case = TRUE)
names(extractedData)<-gsub("-freq()", "Frequency", names(extractedData), ignore.case = TRUE)
names(extractedData)<-gsub("angle", "Angle", names(extractedData))
names(extractedData)<-gsub("gravity", "Gravity", names(extractedData))

############################################################################################################
#From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.

secondDataset <- extractedData %>%
  group_by(subject, activity) %>% summarise_all(funs(mean))

write.table(secondDataset, "TidyDataset.txt", row.name=FALSE)
secondDataset
#############################################################################################################