# Assignment for Getting and Cleaning Data Course Project
# @written by Youngok Kim, joylife052@gmail.com


#wd <- paste(getwd(), "/DS3_GetCleanData_Assignment/", sep="")

##
## Instruction 1. 
##    Merges the training and the test sets to create one data set.
##

merge_datasets <- function(data_path = "UCI HAR Dataset") {

    # set data file name 
    f_xtest <- paste(data_path,"test/X_test.txt", sep="/")
    f_ytest <- paste(data_path,"test/y_test.txt", sep="/")
    f_stest <- paste(data_path,"test/subject_test.txt", sep="/")
    
    f_xtrain <- paste(data_path,"train/X_train.txt", sep="/")
    f_ytrain <- paste(data_path,"train/y_train.txt", sep="/")
    f_strain <- paste(data_path,"train/subject_train.txt", sep="/")
    
    # make data frame of test and train
    df_test <- bind_cols(read.table(f_stest), read.table(f_ytest)) %>% 
        bind_cols(read.table(f_xtest))
    df_train <- bind_cols(read.table(f_strain), read.table(f_ytrain)) %>% 
        bind_cols(read.table(f_xtrain))

    # create one data set and assign it to "df_run"
    df_run <- bind_rows(df_test, df_train)
    colnames(df_run) <- c("subject","Y",1:561)
    
    # create a file
    write.csv(df_run, file = "run.csv", row.names = FALSE)
    
    df_run
}

##
## Instruction 2. Extracts only the measurements on the mean and standard 
##    deviation for each measurement.
##

extract_mean_std <- function(df_run, data_path = "UCI HAR Dataset") {
    
    f_features <- paste(data_path,"features.txt", sep="/")
    df_features <- read.table(f_features)
    
    # df <- df_features[grep("mean()",df_features$V2),]
    
    df_meanstd <- df_features
    
    df_meanstd
}