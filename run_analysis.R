base_folder <- "UCI HAR Dataset"

Run_Analysis <- function(){
    wd = getwd()
    setwd(base_folder)
    
#     is_test_acc_x = read.table("test/Inertial Signals/body_acc_x_test.txt")
#     is_test_acc_y = read.table("test/Inertial Signals/body_acc_y_test.txt")
#     is_test_acc_z = read.table("test/Inertial Signals/body_acc_z_test.txt")
#     is_test_acc = cbind(is_test_acc_x, is_test_acc_y, is_test_acc_z)
#     
#     is_test_gyr_x = read.table("test/Inertial Signals/body_gyro_x_test.txt")
#     is_test_gyr_y = read.table("test/Inertial Signals/body_gyro_y_test.txt")
#     is_test_gyr_z = read.table("test/Inertial Signals/body_gyro_z_test.txt")
#     is_test_gry = cbind(is_test_gyr_x, is_test_gyr_y, is_test_gyr_z)
#     
#     #2974 obs of 768 variables
#     is_test = cbind(is_test_acc, is_test_gry)
    
    
    feature = as.vector(read.table("features.txt")[,2])
    activity = as.vector(read.table("activity_labels.txt")[,2])
    
    #7352 obs of 561 variables
    x_train <- read.table("train/X_train.txt")
    #2974 obs of 561 variables
    x_test <- read.table("test/X_test.txt")
    x_merge <- rbind(x_train, x_test)
    colnames(x_merge) = feature
    
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
    mean_and_std = x_merge[,feature[grepl("-mean()", feature, fixed = T) | grepl("-std()", feature, fixed = T)]]
    
    #step 3:Uses descriptive activity names to name the activities in the data set.
    for(i in 1:length(activity)){
        y_merge[y_merge == i] = activity[i]
    }
    
    #step 4:Appropriately labels the data set with descriptive variable names. 
    colnames(y_merge) <- "activity"
    colnames(sub_merge) <- "subject"
    data_set = cbind(x_merge, y_merge, sub_merge)
    #step 5:From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
    
    setwd(wd)
}