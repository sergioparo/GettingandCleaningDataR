#Getting and Cleaning Data using R Course Project

The project was based on the data files available in the following file:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Refers to the README.txt inside the zip file for details on how the data was collecetd and all the availables features.

##File: run_analysis.R script

This file contains the script to produce the 'test_train_dataset' dataframe which contains the test and train features (only the average and standard deviation variables) plus the activity label (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) and subject identification (1 to 30) for each record.

The script has the function 'prepare_data_set' that will prepare each dataset (test and train), receiving the path to the dataset, path to the file that relates each record from dataset to subject and path the file that relates each record from dataset to activity codes (1, 2, 3, 4, 5, 6). The function uses the file 'features.txt' to name the columns of the dataset, the 'activity_labels.txt' to translate the activity codes to activity description.

Then the script calls the 'prepare_data_set' function twice, one for test and other for train data. The union of both datasets is 'test_train_dataset'.

After that, all the 'test_train_dataset' features are summarized by activity and subject using mean function. The result dataframe is store into "test_train_dataset_grp.txt" file.

##Needed file structure:
> .\UCI HAR Dataset\activity_labels.txt
> .\UCI HAR Dataset\features.txt
> .\UCI HAR Dataset\test\subject_test.txt
> .\UCI HAR Dataset\test\X_test.txt
> .\UCI HAR Dataset\test\y_test.txt
> .\UCI HAR Dataset\train\subject_train.txt
> .\UCI HAR Dataset\train\X_train.txt
> .\UCI HAR Dataset\train\y_train.txt

##Features
Check features_info.txt for the full list of dataframes features.
