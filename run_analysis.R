library(plyr)

## Download dataset:
if (!file.exists("./projdata")){dir.create("./projdata")}
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
# download.file(fileURL, destfile="./projdata/Dataset.zip" method = "curl")
download.file(fileURL, destfile="./projdata/Dataset.zip")


#Unzip the file   
if (!file.exists("UCI HAR Dataset")) {unzip(zipfile = "./projdata/Dataset.zip", exdir="./projdata") }

fileloc <- file.path("./projdata", "UCI HAR Dataset") 

# read the activity files 
ActTest  <- read.table(file.path(fileloc, "test" , "Y_test.txt" ),header = FALSE)
ActTrain <- read.table(file.path(fileloc, "train", "Y_train.txt"),header = FALSE) 

# read the subject files 
SubjTrain <- read.table(file.path(fileloc, "train", "subject_train.txt"),header = FALSE)
SubjTest  <- read.table(file.path(fileloc, "test" , "subject_test.txt"),header = FALSE)

# read feature files 
FeatTest  <- read.table(file.path(fileloc, "test" , "X_test.txt" ),header = FALSE)
FeatTrain <- read.table(file.path(fileloc, "train", "X_train.txt"),header = FALSE)

#bind the dataset 
subject <- rbind(SubjTrain, SubjTest)
activity<- rbind(ActTrain, ActTest)
features<- rbind(FeatTrain, FeatTest)

# add labels 
featuresNames <- read.table(file.path(fileloc, "features.txt"),head=FALSE)
names(features) <- featuresNames$V2 
names(activity) <- "Activity"
names(subject) <- "Subject"

# merge columns 
allData <- cbind(features,subject,activity) 

# Name of Features by measurements on the mean and standard deviation 
subFeaturesNames<-featuresNames$V2[grep("mean\\(\\)|std\\(\\)", featuresNames$V2)]

# pick up data by selected feature names 
selectedNames<-c(as.character(subFeaturesNames), "Subject", "Activity" )
allData<-subset(allData,select=selectedNames)

# label the columns appropriately 
names(allData)<-gsub("^t", "time", names(allData))
names(allData)<-gsub("^f", "frequency", names(allData))
names(allData)<-gsub("Acc", "Accelerometer", names(allData))
names(allData)<-gsub("Gyro", "Gyroscope", names(allData))
names(allData)<-gsub("Mag", "Magnitude", names(allData))
names(allData)<-gsub("BodyBody", "Body", names(allData))

# create a file with tidy data  
Data2<-aggregate(. ~Subject + Activity, allData, mean)
Data2<-Data2[order(Data2$Subject,Data2$Activity),]
write.table(Data2, file = "tidydata.txt",row.name=FALSE)






