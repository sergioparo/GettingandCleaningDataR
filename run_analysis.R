# run_analysis.R

prepare_data_set <- function(path_to_dataset, path_to_subjects, path_to_act_features) {
        
        # read features names
        features <- read.delim(".\\UCI HAR Dataset\\features.txt",sep=" ", header=FALSE, col.names =  c("seq", "feature"))
        features$feature <- gsub("-|\\(|\\)|," ,"", features$feature)
        
        # keep features mean and std
        features_mean_std <- features[grep("mean|std",features$feature , ignore.case = TRUE),]
        # read labels for activities
        activity_labels <- read.delim(".\\UCI HAR Dataset\\activity_labels.txt",sep=" ", header=FALSE, col.names =  c("act_code", "activity"))
        
        # read data set and column names from features, keep only "mean" and "std"
        X_mean_std <- read.fwf(path_to_dataset, rep(16,561), header = FALSE, col.names = features$feature)[,features_mean_std$feature]
        
        # read subjects
        subject <- readLines(path_to_subjects)
        
        # append subject feature to feature data.frame
        X_mean_std <- cbind(X_mean_std, subject = as.integer(subject))
        
        #read activity features
        activity <- read.csv(path_to_act_features, header=FALSE, col.names = c("act_code"))
        
        # append activity feature to feature data.frame
        X_mean_std <- cbind(X_mean_std, act_code = activity$act_code)
        # merge data set with activtiy labels to include the labels into data set
        X_mean_std <- merge(X_mean_std, activity_labels)
        
        X_mean_std$act_code <- NULL
        
        X_mean_std
        
}

test_train_dataset <- rbind(prepare_data_set (".\\UCI HAR Dataset\\test\\X_test.txt", ".\\UCI HAR Dataset\\test\\subject_test.txt", ".\\UCI HAR Dataset\\test\\y_test.txt"),
                            prepare_data_set (".\\UCI HAR Dataset\\train\\X_train.txt", ".\\UCI HAR Dataset\\train\\subject_train.txt", ".\\UCI HAR Dataset\\train\\y_train.txt")                        )

library(dplyr)

test_train_dataset_grp <- test_train_dataset %>% group_by(activity, subject) %>% summarise_all(list(~mean))

write.table(test_train_dataset_grp, file = "test_train_dataset_grp.txt", row.names = FALSE)
