Description 

Source of the data is available at https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

Step 1 :
- Download the source data file and put in the folder
- Unzip the file 

Following files will be used :

    test/subject_test.txt
    test/X_test.txt
    test/y_test.txt
    train/subject_train.txt
    train/X_train.txt
    train/y_train.txt

Step 2 : 
 - Read data from the files into variables 
 - Merge the training and the test data and set variable names 
 
   Values of Variable Activity consist of data from “Y_train.txt” and “Y_test.txt”
    values of Variable Subject consist of data from “subject_train.txt” and subject_test.txt"
    Values of Variable Features consist of data from “X_train.txt” and “X_test.txt”
    Names of Variable Features come from “features.txt”
    Names of Variable Activity come from “activity_labels.txt”

Step 3 : Merge columns to get the data frame 

Step 4 : 
- Extract only the measurements on mean and standard deviation for each measurement 
- Appropriately labels the data set 

Step 5 : Create a tidy data set 