Michael John R. Garcia
BS in Computer Science-IV

run_analysis.R performs the actions specified in the pdf. Firstly, it loads the dplyr library which would be used in providing functions tailor-made for manipulating databases.

The UCI HAR Dataset has two main categories: the training and test sets wherein the data are derived from. Each person among the 30 subjects performed six activities. All of these activities were then measured based on numerous features. All of this information can be learned from studying the files in the folders as well as reading its source website.

Firstly, the files features.txt, activity_labels.txt and the files within the test and training folders were assigned into data frames and this is where the script really starts.

----------------------------------------------------------------------------------------------------------------------------------------------------------
Files within the UCI HAR Dataset

-- 'README.txt'

-- 'features_info.txt': Shows information about the variables used on the feature vector.

--'features.txt': List of all features.

-- 'activity_labels.txt': Links the class labels with their activity name.

-- 'train/X_train.txt': Training set.

-- 'train/y_train.txt': Training labels.

-- 'test/X_test.txt': Test set.

-- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

-- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

-- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 

-- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 

-- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

----------------------------------------------------------------------------------------------------------------------------------------------------------
The first step in the script is to merge the training and test sets. After getting and assigning the data, the corresponding variables (subjtrain, xtrain, ytrain) representing the data within subject_train.txt, x_train.txt and y_train.txt were merged using cbind(). The same was done for the test side as well (subjtest, xtest, ytest). When all is said and done, the two merged datasets were further merged into one data set called mergedData by using rbind().

The next instruction is to extract only mean and std measurements from the newly merged dataset. Selected data (using select()) within mergedData which includes subject and dataset labels as well as related mean and standard deviation data (obtained from using the contains() function) were then placed within extractedData.

The next step is to use descriptive activity names to name the activities in the dataset. The code columnn (named during the assignment of data explained above) of extractedData was then replaced with corresponding activity labels obtained from the acts variable.

Afterwards, the act of labeling the dataset with descriptive variable names would then take center stage. This was done by firstly using the names() function wherein it gets the names/columns from extractedData and then those names would be replaced with more appropriate descriptions using gsub(). For example, "Acc" would be replaced by the more appropriately accepted word "Accelerometer". 

Lastly, a second, independendent and tidy data set named secondDataset was then made by grouping the data within extractedData by subjects and activities (group_by()). Afterwards, the average/mean of each variable for each activity and subject was then summarized using summarise_all().

The newly made tidy dataset can be viewed by opening the TidyDataset.txt (made using the write.table() function) or by simply typing secondDataset.