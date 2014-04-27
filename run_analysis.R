## The Github repository associated with this file is:
## https://github.com/fss14142/GettingAndCleaningDataProject
## For futher details, see the README.md file in that 
## repository.

## This is the run_analysis.R script required for the 
## "Getting and Cleaning Data Course Project" in the 
## "Getting and Cleaning Data" course (April 2014 ) of 
## the Coursera Data Science Specialization.

## We start checking if the Working Directory is correct.
## If it is not, execution stops.
if(!file.exists("run_analysis.R")){
  warning("Make sure your Working Directory contains this run_analysis script")
}

## It is assumed that the `getdata-projectfiles-UCI HAR Dataset.zip`, 
## containing the project data, has been downloaded and decompresssed in 
## the Working Directory. If you want this script to download and decompress 
## the zip file by itself, uncomment the following lines of code 
## (this requires an active internet connection).

# dataFileName <- "getdata-projectfiles-UCI HAR Dataset.zip"
# if(!file.exists(dataFileName)){
#   dataUrl <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"    
#   download.file(url=dataUrl, destfile=dataFileName)
# }
# if(!file.exists("UCI HAR Dataset")){
#   unzip(dataFileName)    
# }


## It is also assumed that the data.table library and its dependencies are 
## already installed. If you wish the script to download and install the
## library by itself, uncomment the following lines of code 
## (this requires an active internet connection).

# if(("data.table" %in% installed.packages()) == FALSE){
#    install.packages("data.table")
#    }

## The required library is loaded.
library(data.table)

## ---------------
## ANALYSIS BEGINS
## ---------------

## Reading files in the 'UCI HAR Dataset' folder. 
##-------------------------------------------

## Step 1: The features.txt file.

  ## The file is read into a data.frame called features. 
  ## Notice the as.is argument, that forces the second column to be 
  ## read as a character vector.

  features <- read.table("./UCI HAR Dataset/features.txt", 
                         col.names=c("id","name"), as.is=c(2))
  ## The data frame is checked for missing and duplicated values.
  if(sum(complete.cases(features)) < nrow(features) ){
    warning("Missing values in features.txt")
  }
  if(sum(duplicated(features$name))>0){
    warning("Duplicated feature names in feature.txt")
  }

## Step 2: Feature selection. 

  ## Only the feature names containg the string "-mean()" or "-std()"
  ## will be included in the analysis. This step also serves to determine which
  ## columns will actually be read from the larger data files.  Refer to the 
  ## README.md file for further details. 

  ## We use grep with a selection pattern to get the
  ## positions where those features are located.
  selectPattern <- "-mean[\\(][\\)]|-std[\\(][\\)]"
  positionsToSelect <- grep(selectPattern, features$name)

  ## We check for duplicated values. 
  if(sum(duplicated(features$name[positionsToSelect])) > 0 ){
    warning("Duplicated variable names will appear in the final data set")
  }

  ## The remaining positions correspond to non-selected columns,
  ## that we will avoid reading from the larger data files.
  positionsNotSelected <- (1:nrow(features))[-positionsToSelect]
  # length(positionsNotSelected)  ## Uncomment these 2 lines to check coherence.
  # length(positionsNotSelected)+length(positionsToSelect)-nrow(features)

  ## Now we create a character vector, columnClasses. The non-selected positions
  ## of this vector contain NULL, and willl be used to tell the read.table
  ## function not to read those columns of the larger data files.
  columnClasses <- character(nrow(features))
  columnClasses[positionsNotSelected] <- "NULL"
  columnClasses[positionsToSelect] <- "numeric"


## Step 3: The activity_labels.txt file. 

  ## The file is read into a data.frame called activity_labels.
  activity_labels <- 
    read.table("./UCI HAR Dataset/activity_labels.txt", col.names=c("id", "name"))
  ## Uncomment these lines to check for NA and duplicated values.
  # nrow(activity_labels)
  # sum(complete.cases(activity_labels))
  checkDuplicatedActivtyIds = sum(duplicated(activity_labels$id))
  checkDuplicatedActivtyNames = sum(duplicated(activity_labels$name))
  if((checkDuplicatedActivtyIds > 0) | (checkDuplicatedActivtyNames > 0)){
    warning("Duplicated activity identifiers in data set")
  }

  ## The activity_labels$name vector is recoded as a factor where the levels 
  ## correspond to the order indicated by the activity id. 
  activity_labels$name <- factor(activity_labels$name, levels=activity_labels$name)


## Reading the data from the test folder. 
##-------------------------------------------

## Step 4: The subject_test.txt file

  ## The subject_test.txt file is read into a data.frame called subject_test.
  subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", col.names="subjId")
  ## Check the file for possible NAs.
  if(sum(!complete.cases(subject_test)) > 0){
    warning("The subject_test.txt file contains missing cases.")
  }

## Step 5: The X_test.txt file

  ## The X_test.txt file is read into a data.frame called X_test.
  ## The columnClasses vector created in Step 2 is used to read only
  ## the columns that we will use in the analysis.
  X_test <- read.table("./UCI HAR Dataset/test/X_test.txt", colClasses=columnClasses)
  ## Check the file for possible NAs.
  if(sum(!complete.cases(X_test)) > 0){
    warning("The X_test.txt file contains missing cases.")
  }

## Step 6: The y_test.txt file.  

  ## The y_test.txt file is read into a data frame called y_test.
  y_test <- read.table("./UCI HAR Dataset/test/y_test.txt", col.names="actId")
  ## Check the file for possible NAs.
  if(sum(!complete.cases(y_test)) > 0){
    warning("The y_test.txt file contains missing cases.")
  }

## Step 7: Pairing y_test with activity_labels$name.  

  ## Next, we obtain a vector with the activity name corresponding to each 
  ## value of actId in the y_test data frame.
  activityLabelTest <- activity_labels$name[y_test$actId] 
  
## Step 8: Putting together the pieces from the test group.  

  ## The vectors subject_test$subjId, activityLabelTest,  
  ## y_test$actId and the data frame X_test are bound into a data.frame 
  ## with the data from the test group. We set the names of the first 
  ## three columns to match the corresponding ones from the training group.

  testData <- data.frame(subjectId=subject_test$subjId, activityLabel=activityLabelTest,
                      activityId=y_test$actId, X_test)

## Reading the data from the train folder. 
## -------------------------------------------

## We repeat the above for the train firectory, making the necessary changes. 

## Step 9:  The subject_train.txt file

  ## The subject_train.txt file is read into a data.frame called subject_train. 
  subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", col.names="subjId")
  ## Check the file for possible NAs.
  if(sum(!complete.cases(subject_train)) > 0){
    warning("The X_train.txt file contains missing cases.")
  }

## Step 10:  The X_train.txt file

  ## The X_train.txt file is read into a data.frame called X_train.
  ## The columnClasses vector is used again to read only the desired columns.
  X_train <- read.table("./UCI HAR Dataset/train/X_train.txt", colClasses=columnClasses)
  ## Check the file for possible NAs.
  if(sum(!complete.cases(X_train)) > 0){
    warning("The X_train.txt file contains missing cases.")
  }

## Step 11: The y_train.txt file.  

  ## The y_train.txt file is read into a data frame called y_train.
  y_train <- read.table("./UCI HAR Dataset/train/y_train.txt", col.names="actId")
  ## Check the file for possible NAs.
  if(sum(!complete.cases(y_train)) > 0){
    warning("The y_train.txt file contains missing cases.")
  }

## Step 12: Pairing y_train with activity_labels$name.  

  ## The vector of activity names corresponding to each value of actId in the 
  ## y_train data frame is obtained as before.
  activityLabelTrain <- activity_labels$name[y_train$actId] 

## Step 13: Putting together the pieces from the training group.  

  ## The trainData data frame is created, as we did with the testData. The 
  ## column names in these two data frames should be equal.
  trainData <- data.frame(subjectId=subject_train$subjId, activityLabel=activityLabelTrain,
                      activityId=y_train$actId, X_train)

## Bringing the `test` and `train` data together.
##------------------------------------------------

## Step 14: The training and test data are merged into a single data frame.

  # This is really simple now.
  totalData <- rbind(trainData, testData)

## Step 15: Tidying the remaining variable names.

  ## The first three columns of totalData have already been given descriptive 
  ## names. The rest need to be tidyed. We take as starting point the 
  ## subset of selected positions of the features$name vector.
  namesTotalData <- features$name[positionsToSelect] 
  ##  We use camelCase notation for the variables names.
  namesTotalData <- gsub("mean", replacement="Mean", namesTotalData)
  namesTotalData <- gsub("std", replacement="Std", namesTotalData)
  ## and we remove the parenthesis and dashes.
  namesTotalData <- gsub("\\(\\)", replacement="", namesTotalData)
  namesTotalData <- gsub("-",replacement="", namesTotalData)
  
  ## The resulting list of names is used for the totalData data frame.
  names(totalData) <- c((names(totalData))[1:3], namesTotalData)

### Creating the output tidy data set ###
##---------------------------------------

## Step 16: Creating a tidy data set with the average of the feature variables.
  
  ## We will use the data.table library for this task. 
  ## We start by converting the totalData data.frame to a data.table.
  totalDataDT <- data.table(totalData)

  ## We will get the average for each unique combination of activity and 
  ## subject. Thus, we use columns 1 and 2 as grouping columns.
  groupingColumnNames <- (names(totalData)[1:2])
  
  ## We obtain the averages for columns corresponding to the selected features.
  ## The result 
  averagesDT <- totalDataDT[ , lapply(.SD, mean), by = groupingColumnNames, 
                         .SDcols=3:ncol(totalDataDT)]
  
  ## And, for visualization purposes, we sort the resulting data.table with 
  ## respect to the observational units. 
  averagesDT <- averagesDT[order(averagesDT$subjectId, averagesDT$activityId), ]

  ## Finally, the resulting tidy data set is written to a txt file.  
  write.table(averagesDT, file="tidyDataSet.txt",sep=",", row.names=FALSE)

## ---------------
## END OF ANALYSIS 
## ---------------

## End of the script

