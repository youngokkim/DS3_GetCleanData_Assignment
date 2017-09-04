# Assignment for Getting and Cleaning Data Course Project
# @written by Youngok Kim, joylife052@gmail.com


#wd <- paste(getwd(), "/DS3_GetCleanData_Assignment/", sep="")


do_all <- function(data_path = "UCI HAR Dataset") {
    
    # instruction 1
    df_run <- merge_datasets()
    
    # instruction 2
    df_meanstd <- extract_mean_std(df_run)
    
    #indsturcion 3
    df_meanstd <- set_activity_names(df_meanstd)
    
    #indsturcion 4
    df_meanstd <- set_variable_names(df_meanstd)
    
    #indsturcion 5
    df_tidydata <- get_newtidydata(df_meanstd)
    # write a file
    write.table(df_tidydata, file = "run.txt", row.names = FALSE)
    
    df_tidydata
}


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
    colnames(df_run) <-c("Subject","Y",paste("V", 1:561, sep=""))
    
    df_run
}

##
## Instruction 2. Extracts only the measurements on the mean and standard 
##    deviation for each measurement.
##

extract_mean_std <- function(df_run, data_path = "UCI HAR Dataset") {
    
    #read "features.txt" and make features dataframe
    f_features <- paste(data_path,"features.txt", sep="/")
    df_features <- read.table(f_features)
    
    #select only mean() or std() features
    df_features <- df_features[grep('mean\\W()|std\\W()',df_features$V2),]
    
    #get subset from merged data 
    df_meanstd <- df_run[1:2] %>% 
        bind_cols(df_run[paste("V", df_features$V1, sep="")])
    
    df_meanstd
}

##
## Instruction 3.Uses descriptive activity names to name the activities
##      in the data set
##

set_activity_names <- function(df, data_path = "UCI HAR Dataset") {
    
    #read "activity_labels.txt" and make features dataframe
    f_alabels <- paste(data_path,"activity_labels.txt", sep="/")
    df_alabels <- read.table(f_alabels)
    
    for (i in 1: nrow(df_alabels)) {
        df$Y <- gsub(df_alabels[i,1], df_alabels[i,2],df$Y)
    }
    
    df
}


##
## Instruction 4. Appropriately labels the data set with descriptive variable 
##      names.
##

set_variable_names <- function(df, data_path = "UCI HAR Dataset") {
    
    #read "features.txt" and make features dataframe
    f_features <- paste(data_path,"features.txt", sep="/")
    df_features <- read.table(f_features, colClasses = "character")
    
    for (i in 1 : ncol(df)) {
        if (i == 1) colnames(df)[i] <- "Subject"
        else if (i == 2) colnames(df)[i] <- "Activity"
        else {
            colnames(df)[i] <- df_features[as.numeric(gsub("V","", colnames(df)[i])), 2]
        }
    }
    
    df
}

##
## Instruction 5. From the data set in step 4, creates a second, independent 
##      tidy data set with the average of each variable for each activity and 
##      each subject.
##
get_newtidydata <- function (df_meanstd) {
    df_new <- data.frame()

    for (i in 1:30) {
        df_subject <- filter(df_meanstd, Subject == i)
        df_average <- data.frame(Subject=i, Group.1=unique(df_subject$Activity))
        k <- 3
        for(k in 3:ncol(df_meanstd)) {
            #print(paste("k:",k,sep=""))
            df_average <- merge(df_average, 
                                aggregate(df_subject[k], by=list(df_subject$Activity), FUN=mean),
                                key=Group.1)
        }
        df_new <- rbind(df_new, df_average)
    }
    
    df_new <- df_new[,c(2,1,3:68)]
    colnames(df_new)[2] <- "Activity"
    
    df_new
}
