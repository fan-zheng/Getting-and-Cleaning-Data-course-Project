library(plyr)
# import data
X_test<-read.table("X_test.txt")
X_train<-read.table("X_train.txt")
features<-read.table("features.txt")
subject_test<-read.table("subject_test.txt")
subject_train<-read.table("subject_train.txt")
y_test<-read.table("y_test.txt")
y_train<-read.table("y_train.txt")
# combine train and test data
train_test<-rbind(X_train,X_test)
# generate features vector
features_vector<-features$V2
features_vector<-as.character(features_vector)
# feature names that contains mean or std only
features_vector_sub<-features_vector[grepl(("mean|std"),features_vector)]
# generate subset of train_test that only have mean or std in the name
train_test_sub<-train_test[,grepl(("mean|std"),features_vector)]
# add column names to train_test_sub
colnames(train_test_sub)<-features_vector_sub
# change value of activity to more descriptive names
train_test_act<-rbind(y_train,y_test)
train_test_act$V1<-as.factor(train_test_act$V1)
train_test_act$V1<-revalue(train_test_act$V1,c("5"="STANDING","1"="WALKING","2"="WALKING_UPSTAIRS","3"="WALKING_DOWNSTAIRS","4"="SITTING","6"="LAYING"))
# change column names of activity to be more descriptive
colnames(train_test_act)<-c("Activity_Labels")
# combine data set with activity set
train_test_sub<-cbind(train_test_act,train_test_sub)
# change variable names to be more descriptive
desnames<-names(train_test_sub)
desnames<-gsub("Acc","Accelerator",desnames)
desnames<-gsub("^t","time",desnames)
desnames<-gsub("^f","frequency",desnames)
desnames<-gsub("Gyro","Gyroscope",desnames)
desnames<-gsub("Mag","Magnitude",desnames)
colnames(train_test_sub)<-desnames
# combine train and test subject and add descriptive column name
train_test_subject<-rbind(subject_train,subject_test)
train_test_subject$V1<-as.factor(train_test_subject$V1)
colnames(train_test_subject)<-c("Participant")
# add Participant data to main data set
train_test_sub<-cbind(train_test_subject,train_test_sub)
# Generate new summary data frame that take average of each variable 
# for each activity and each subject (participant).
summary_train_test_sub<-aggregate(train_test_sub[,3:81],train_test_sub[,1:2],FUN=mean)
write.csv(train_test_sub,"tidydata.csv")
write.csv(summary_train_test_sub,"new_tidydata_average.csv")
write.table(summary_train_test_sub,file="summary_train_test_sub.txt",col.names = F, row.names = F)# So to summarize, tidy data set:train_test_sub
# New data set average by activity and subject: summary_train_test_sub
 
