base_folder <- "UCI HAR Dataset"

Run_Analysis <- function(){
    wd = getwd()
    setwd(base_folder)
    
    is_test_acc_x = read.table("test/Inertial Signals/body_acc_x_test.txt")
    is_test_acc_y = read.table("test/Inertial Signals/body_acc_y_test.txt")
    is_test_acc_z = read.table("test/Inertial Signals/body_acc_z_test.txt")
    is_test_acc = cbind(is_test_acc_x, is_test_acc_y, is_test_acc_z)
    
    is_test_gyr_x = read.table("test/Inertial Signals/body_gyro_x_test.txt")
    is_test_gyr_y = read.table("test/Inertial Signals/body_gyro_y_test.txt")
    is_test_gyr_z = read.table("test/Inertial Signals/body_gyro_z_test.txt")
    is_test_gry = cbind(is_test_gyr_x, is_test_gyr_y, is_test_gyr_z)
    
    #2974 obs of 768 variables
    is_test = cbind(is_test_acc, is_test_gry)
    
    
    
    
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
    xys_merge <- cbind(x_merge, y_merge, sub_merge)
    
    
    setwd(wd)
}