
#Downloading and unziping the files
url="https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url,destfile="./UCI HAR Dataset.zip")
unzip ("UCI HAR Dataset.zip", exdir = "./")

setwd("./UCI HAR Dataset")

trainLabel <- read.table("./train/y_train.txt")
table(trainLabel)
testLabel <- read.table("./test/y_test.txt") 
table(testLabel)

#Question one 
#Read the data files.
trainData <- read.table("./train/X_train.txt")
#dim(trainData) 
#head(trainData)
testData <- read.table("./test/X_test.txt")
#dim(testData) 

#Read the subject files.
trainSubject <- read.table("./train/subject_train.txt")
testSubject <- read.table("./test/subject_test.txt")

#Merge the train and the test datasets
joinData <- rbind(trainData, testData)
#dim(joinData)
joinLabel <- rbind(trainLabel, testLabel)
#dim(joinLabel) 
joinSubject <- rbind(trainSubject, testSubject)
#dim(joinSubject) 

#Question 2:Extracts only the measurements on the mean and standard deviation for each measurement.
features <- read.table("./features.txt")
dim(features)  # 561*2
meanStdIndices <- grep("mean\\(\\)|std\\(\\)", features[, 2])
length(meanStdIndices) # 66
joinData <- joinData[, meanStdIndices]
dim(joinData) # 10299*66
names(joinData) <- gsub("\\(\\)", "", features[meanStdIndices, 2]) # remove "()"
names(joinData) <- gsub("mean", "Mean", names(joinData)) # capitalize M
names(joinData) <- gsub("std", "Std", names(joinData)) # capitalize S
names(joinData) <- gsub("-", "", names(joinData)) # remove "-" in column names 


#Question 3: Uses descriptive activity names for activities in the data set 
activity <- read.table("./activity_labels.txt")
# remove underscoe from column names and captalizing U and D in walkingupstairs and walkingdownstairs
activity[, 2] <- tolower(gsub("_", "", activity[, 2])) 
substr(activity[2, 2], 8, 8) <- toupper(substr(activity[2, 2], 8, 8))
substr(activity[3, 2], 8, 8) <- toupper(substr(activity[3, 2], 8, 8))
activityLabel <- activity[joinLabel[, 1], 2]
joinLabel[, 1] <- activityLabel
names(joinLabel) <- "activity"

#Question 4: Appropriately labels the data set with descriptive activity names.
names(joinSubject) <- "subject"
cleanedData <- cbind(joinSubject, joinLabel, joinData)
#dim(cleanedData) 
write.table(cleanedData, "merged_data.txt") # write out the 1st dataset

#Question 5: Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
subjectLen <- length(table(joinSubject)) 
activityLen <- dim(activity)[1] 
columnLen <- dim(cleanedData)[2]
result <- matrix(NA, nrow=subjectLen*activityLen, ncol=columnLen) 
result <- as.data.frame(result)
colnames(result) <- colnames(cleanedData)
row <- 1
for(i in 1:subjectLen) {
        for(j in 1:activityLen) {
                result[row, 1] <- sort(unique(joinSubject)[, 1])[i]
                result[row, 2] <- activity[j, 2]
                bool1 <- i == cleanedData$subject
                bool2 <- activity[j, 2] == cleanedData$activity
                result[row, 3:columnLen] <- colMeans(cleanedData[bool1&bool2, 3:columnLen])
                row <- row + 1
        }
}
head(result)
write.table(result, "data_with_means.txt") # write out the 2nd dataset
