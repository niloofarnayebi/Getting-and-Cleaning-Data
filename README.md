# Getting-and-Cleaning-Data
## Project
run_analysis.R is the main script for this project. The script will automatically download and unzip data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

 
1. type source("run_analysis.R") in RStudio. 
2. you will get two new data set in UCI HAR Dataset folder. (merged_data.txt, data_with_means.txt)
3. you can read the final qustion dataset by following command: data <- read.table("data_with_means.txt")
