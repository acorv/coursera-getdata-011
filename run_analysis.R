library(dplyr)

#Read activity labels 
activities<-read.table(header=FALSE, file = "activity_labels.txt")

#Read features
features<-read.table(header=FALSE, file = "features.txt")

feature_indexes<-numeric()
feature_names<-character()

#Filter features containing 'mean()' and 'std()'. Features containing 'meanFreq' are ignored
#Store feature column index in feature_indexes, and corresponding feature name in feature_names
for (i in 1:nrow(features)) {
    feature_name<-as.character(features[i, 2])
    if (length(grep("mean\\(|std\\(", feature_name))>0) {
        feature_indexes<-c(feature_indexes, i)
        feature_name<-gsub("-","_",feature_name, fixed = TRUE) 
        feature_name<-gsub("()","",feature_name, fixed = TRUE) 
        feature_names<-c(feature_names, feature_name)
    }
}

#Number of samples to read from values. -1 for all.
n<--1

#Read values, activities and subjects from training dataset
train_values<-read.fwf(file = "train/X_train.txt", widths = rep(16, 561), n=n)
train_activities<-read.table(header=FALSE, file = "train/y_train.txt")
train_subjects<-read.table(header=FALSE, file = "train/subject_train.txt")

#Read values, activities and subjects from test dataset
test_values<-read.fwf(file = "test/X_test.txt", widths = rep(16, 561), n=n)
test_activities<-read.table(header=FALSE, file = "test/y_test.txt", nrows = n)
test_subjects<-read.table(header=FALSE, file = "test/subject_test.txt" , nrows = n)

#On train data:
#Keep only std and avg columns
train_values<-train_values[,feature_indexes]
#Add column names
colnames(train_values)<-feature_names
#Add Subject column
train_values[,"Subject"]<-train_subjects 
#Add column 'act_temp' with activity number
train_values[,"act_temp"]<-train_activities 
#Replace column 'act_temp' with proper activity name
train_values<-mutate(train_values, Activity=activities[act_temp, 2])  
#Remove 'act_temp' column
train_values[,"act_temp"]<-NULL 

#On test data:
#Keep only std and avg columns
test_values<-test_values[,feature_indexes] 
#Add column names
colnames(test_values)<-feature_names
#Add Subject column
test_values[,"Subject"]<-test_subjects
#Add column 'act_temp' with activity number
test_values[,"act_temp"]<-test_activities
#Replace column 'act_temp' with proper activity name
test_values<-mutate(test_values, Activity=activities[act_temp, 2])
#Remove 'act_temp' column
test_values[,"act_temp"]<-NULL

#Join training and test values
values<-rbind(train_values, test_values)

#Group by Activity and Subject
grouped<-group_by(values, Activity, Subject)

#Create tidy data set
tidy<-summarise(grouped, 
                tBodyAcc_mean_X=mean(tBodyAcc_mean_X),
                tBodyAcc_mean_Y=mean(tBodyAcc_mean_Y),
                tBodyAcc_mean_Z=mean(tBodyAcc_mean_Z),
                tBodyAcc_std_X=mean(tBodyAcc_std_X),
                tBodyAcc_std_Y=mean(tBodyAcc_std_Y),
                tBodyAcc_std_Z=mean(tBodyAcc_std_Z),
                tGravityAcc_mean_X=mean(tGravityAcc_mean_X),
                tGravityAcc_mean_Y=mean(tGravityAcc_mean_Y),
                tGravityAcc_mean_Z=mean(tGravityAcc_mean_Z),
                tGravityAcc_std_X=mean(tGravityAcc_std_X),
                tGravityAcc_std_Y=mean(tGravityAcc_std_Y),
                tGravityAcc_std_Z=mean(tGravityAcc_std_Z),
                tBodyAccJerk_mean_X=mean(tBodyAccJerk_mean_X),
                tBodyAccJerk_mean_Y=mean(tBodyAccJerk_mean_Y),
                tBodyAccJerk_mean_Z=mean(tBodyAccJerk_mean_Z),
                tBodyAccJerk_std_X=mean(tBodyAccJerk_std_X),
                tBodyAccJerk_std_Y=mean(tBodyAccJerk_std_Y),
                tBodyAccJerk_std_Z=mean(tBodyAccJerk_std_Z),
                tBodyGyro_mean_X=mean(tBodyGyro_mean_X),
                tBodyGyro_mean_Y=mean(tBodyGyro_mean_Y),
                tBodyGyro_mean_Z=mean(tBodyGyro_mean_Z),
                tBodyGyro_std_X=mean(tBodyGyro_std_X),
                tBodyGyro_std_Y=mean(tBodyGyro_std_Y),
                tBodyGyro_std_Z=mean(tBodyGyro_std_Z),
                tBodyGyroJerk_mean_X=mean(tBodyGyroJerk_mean_X),
                tBodyGyroJerk_mean_Y=mean(tBodyGyroJerk_mean_Y),
                tBodyGyroJerk_mean_Z=mean(tBodyGyroJerk_mean_Z),
                tBodyGyroJerk_std_X=mean(tBodyGyroJerk_std_X),
                tBodyGyroJerk_std_Y=mean(tBodyGyroJerk_std_Y),
                tBodyGyroJerk_std_Z=mean(tBodyGyroJerk_std_Z),
                tBodyAccMag_mean=mean(tBodyAccMag_mean),
                tBodyAccMag_std=mean(tBodyAccMag_std),
                tGravityAccMag_mean=mean(tGravityAccMag_mean),
                tGravityAccMag_std=mean(tGravityAccMag_std),
                tBodyAccJerkMag_mean=mean(tBodyAccJerkMag_mean),
                tBodyAccJerkMag_std=mean(tBodyAccJerkMag_std),
                tBodyGyroMag_mean=mean(tBodyGyroMag_mean),
                tBodyGyroMag_std=mean(tBodyGyroMag_std),
                tBodyGyroJerkMag_mean=mean(tBodyGyroJerkMag_mean),
                tBodyGyroJerkMag_std=mean(tBodyGyroJerkMag_std),
                fBodyAcc_mean_X=mean(fBodyAcc_mean_X),
                fBodyAcc_mean_Y=mean(fBodyAcc_mean_Y),
                fBodyAcc_mean_Z=mean(fBodyAcc_mean_Z),
                fBodyAcc_std_X=mean(fBodyAcc_std_X),
                fBodyAcc_std_Y=mean(fBodyAcc_std_Y),
                fBodyAcc_std_Z=mean(fBodyAcc_std_Z),
                fBodyAccJerk_mean_X=mean(fBodyAccJerk_mean_X),
                fBodyAccJerk_mean_Y=mean(fBodyAccJerk_mean_Y),
                fBodyAccJerk_mean_Z=mean(fBodyAccJerk_mean_Z),
                fBodyAccJerk_std_X=mean(fBodyAccJerk_std_X),
                fBodyAccJerk_std_Y=mean(fBodyAccJerk_std_Y),
                fBodyAccJerk_std_Z=mean(fBodyAccJerk_std_Z),
                fBodyGyro_mean_X=mean(fBodyGyro_mean_X),
                fBodyGyro_mean_Y=mean(fBodyGyro_mean_Y),
                fBodyGyro_mean_Z=mean(fBodyGyro_mean_Z),
                fBodyGyro_std_X=mean(fBodyGyro_std_X),
                fBodyGyro_std_Y=mean(fBodyGyro_std_Y),
                fBodyGyro_std_Z=mean(fBodyGyro_std_Z),
                fBodyAccMag_mean=mean(fBodyAccMag_mean),
                fBodyAccMag_std=mean(fBodyAccMag_std),
                fBodyBodyAccJerkMag_mean=mean(fBodyBodyAccJerkMag_mean),
                fBodyBodyAccJerkMag_std=mean(fBodyBodyAccJerkMag_std),
                fBodyBodyGyroMag_mean=mean(fBodyBodyGyroMag_mean),
                fBodyBodyGyroMag_std=mean(fBodyBodyGyroMag_std),
                fBodyBodyGyroJerkMag_mean=mean(fBodyBodyGyroJerkMag_mean),
                fBodyBodyGyroJerkMag_std=mean(fBodyBodyGyroJerkMag_std)
                )

write.table(file="tidy.txt", x=tidy, row.names = FALSE )
