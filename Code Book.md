#### This is a description the variables, the data, and any transformations. 

# Code Book

### The data for this project was obtained form: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip


1.	Read training data set
Read X_train.txt, y_train.txt and subject_train.txt from the train folder into trainData,trainLabel and trainSubject.

2.	Read test data set
Read X_test.txt, y_test.txt and subject_test.txt from the test folder into testData, testLabeland testsubject.

3.	Merging two data sets
Concatenate testData to trainData to generate joinData, the merged data frame; redoing the previous step for Label and Subject to create joinLabel and joinSubject.

4.	Read features file
Read the features.txt into features variable. Keeping the subset of joinData which contains the measurements on the mean and standard deviation.

5.	Clean the column names of the subset
Remove the "()" and "-" symbols in the column names, and capitalizing m and s in mean std.

6.	Read the activity_labels
Read the activity_labels.txt into activity.

7.	Clean the activity names in the second column of activity
Make all name lower cases and removing underscore and capitalizing the letter after underscore.

8.	Transform the values of joinLabel
Transform the values of joinLabel according to the activity data frame.

9.	Combine the joinSubject, joinLabel and joinData
Combine the joinSubject, joinLabel and joinData by column to get a new cleaned data frame,cleanedData. (you can run summary(cleanedData) and str(cleanedData) to get more information about this data set.)


10.	Write tidy dataset
Write the cleanedData out to "merged_data.txt".

11.	Generate a second data set
Generate a second independent tidy data set with the average of each measurement for each activity and each subject.

12.	Write the result out to "data_with_means.txt"
Write the result out to "data_with_means.txt".
