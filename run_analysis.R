Run_Analysis <- function(){
    library(plyr)
    
    base_folder <- "UCI HAR Dataset"
    wd = getwd()
    setwd(base_folder)
    
    activity <- read.table("activity_labels.txt")[,2]
    feature <- read.table("features.txt")[,2]
    
    #7352 obs of 561 variables
    x_train <- read.table("train/X_train.txt")
    #2974 obs of 561 variables
    x_test <- read.table("test/X_test.txt")
    x_merge <- rbind(x_train, x_test)
    
    y_train <- read.table("train/Y_train.txt")
    y_test <- read.table("test/Y_test.txt")
    y_merge <- rbind(y_train, y_test)
    
    sub_train <- read.table("train/subject_train.txt")
    sub_test <- read.table("test/subject_test.txt")
    sub_merge <- rbind(sub_train, sub_test)
    
    #10299 obs of 563 variables
    #xys_merge <- cbind(x_merge, y_merge, sub_merge)
    #step 1: Merges the training and the test sets to create one data set.
    xys_merge <- list(x=x_merge, y=y_merge, sub=sub_merge)
    
    #step 2:Extracts only the measurements on the mean and standard deviation for each measurement. 
    colnames(x_merge) <- feature
    #mean_and_std = x_merge[,feature[grepl("-mean()", feature, fixed = T) | grepl("-std()", feature, fixed = T)]]
    step2 <- x_merge[grepl("mean()", feature, fixed = T) | grepl("std()", feature, fixed = T)]
    
    #step 3:Uses descriptive activity names to name the activities in the data set.
    step3 <- factor(y_merge[,1])
    levels(step3) <- activity
    
    #step 4:Appropriately labels the data set with descriptive variable names. 
    colnames(y_merge) <- "activity"
    y_merge$activity <- step3
    
    colnames(sub_merge) <- "subject"
    
    xys_merge <- cbind(step2, y_merge, sub_merge)
    #step 5:From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
    tidy <- ddply(xys_merge, .(subject, activity), function(x) colMeans(x[,1:ncol(step2)]))
    
    setwd(wd)
    
    tidy
}

#write.table(Run_Analysis(), "tidy_data.txt", row.names=FALSE)