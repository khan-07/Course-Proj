library(plyr)
##Read the activity labels file to find the number to name mapping
num_to_name<-read.table("./UCI HAR Dataset/activity_labels.txt",colClasses="character")
##First read the features.txt file 
feature_names<-read.table("./UCI HAR Dataset/features.txt",colClasses="character")
##Split the name of the features by "-"
mean<-strsplit(feature_names[,2],split="-",fixed=T)
std<-strsplit(feature_names[,2],split="-",fixed=T)
##Find all the matches for std() and mean()
mean<-sapply(mean,function(x) match("mean()",x))
std<-sapply(std,function(x) match("std()",x))
##Find the indices that are a match
mean<-which(mean==2)
std<-which(std==2)
##Read the names of the feature that will be later used ot name the variables
mean_names<-feature_names[mean,2]
std_names<-feature_names[std,2]
##first read the training data 
table_subject<-read.table("./UCI HAR Dataset/train/subject_train.txt",colClasses="character")
##Now read the activity data
activity<-read.table("./UCI HAR Dataset/train/y_train.txt",colClasses="character")

##Replace activity number with the corresponding name of the activity
activity<-num_to_name[activity[,1],2]
##Now combine both files in to a single dataframe
table_subject<-cbind(table_subject,activity)
##Now go on to read the feature vector from x_train
feature_train<-read.table("./UCI HAR Dataset/train/X_train.txt",colClasses="numeric")
##Subset the dataframe first according to mean() readings
feature_train_mean<-feature_train[,mean]
##Subset the dataframe according to the std() readings
feature_train_std<-feature_train[,std]
##Now merge all the train datasets together
table_subject_final<-cbind(table_subject,feature_train_mean,feature_train_std)
##Now read the test dataset 
table_subject<-read.table("./UCI HAR Dataset/test/subject_test.txt",colClasses="character")
##Now read the activity data for test dataset
activity<-read.table("./UCI HAR Dataset/test/y_test.txt",colClasses="character")
##Replace activity number with the corresponding name of the activity
activity<-num_to_name[activity[,1],2]
##Now bind the two datasets together
##Now combine both files in to a single dataframe
table_subject<-cbind(table_subject,activity)
##Now go on to read the feature vector from x_train
feature_test<-read.table("./UCI HAR Dataset/test/X_test.txt",colClasses="numeric")
##Subset the dataframe first according to mean() readings
feature_test_mean<-feature_test[,mean]
##Subset the dataframe according to the std() readings
feature_test_std<-feature_test[,std]
##Now merge all the train datasets together
table_subject_final1<-cbind(table_subject,feature_test_mean,feature_test_std)
##Now bind the train and test dataset together
Tidy_1<-rbind(table_subject_final,table_subject_final1)
##Replace - and () with dots. So the variable names are legal 
names<-gsub("-|\\()",".",c("Subject","Activity",mean_names,std_names))
##Now remove the dobule dots from the names
names<-gsub("..",".",names,fixed=T)
##Now name each column according to the feature name        
colnames(Tidy_1)<-gsub("BodyBody","Body",names)
##Now create the second tidy dataset with average of each variable
Tidy_2<-ddply(Tidy_1,.(Subject,Activity),function(x) colMeans(x[,c(3:68)]))
Tidy_2<-Tidy_2[order(as.numeric(Tidy_2$Subject)),]
write.table(Tidy_2,"./UCI HAR Dataset/Tidy2.txt",row.names=F)
