base_folder <- "UCI HAR Dataset"

Run_Analysis <- function(){
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
    #xys_merge <- list(x_merge, y_merge, sub_merge)
    
    colnames(x_merge) <- feature
    step2 <- x_merge[grepl("mean()", feature, fixed = T) | grepl("std()", feature, fixed = T)]
    
    step3 <- factor(y_merge[,1])
    levels(step3) <- activity
    
    colnames(y_merge) <- "activity"
    y_merge$activity <- step3
    
    colnames(sub_merge) <- "subject"
    
    xys_merge <- cbind(step2, y_merge, sub_merge)
    
    
    
    setwd(wd)
}