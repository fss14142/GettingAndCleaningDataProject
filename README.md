## About this file and the accompanying `run_analysis.R` script. ##

This is the `README.md` markdown file required for the
"Getting and Cleaning Data Course Project" in the
"Getting and Cleaning Data" course (April 2014 edition) of
the [Coursera Data Science Specialization](https://www.coursera.org/specialization/jhudatascience/1?utm_medium=listingPage).
The associated github repository is located at 
[https://github.com/fss14142/GettingAndCleaningDataProject](https://github.com/fss14142/GettingAndCleaningDataProject).


The `run_analysis.R` in this repository is written in the [R programming language](http://www.r-project.org/). You should read this file before running the `run_analysis.R` script. In particular, the *Requirements* section below describes the conditions that must be met for a succesful completion of the analysis. The *Input Data Description* section describes the folder structure, content and variable naming conventions used in the input files. The section entitled *Step by Step Description of the Analysis* contains a detailed description of the analyis, as performed by the `run_analysis.R` script.  The *Output file* section describes the file obtained as a result of the execution of `run_analysis.R`.  

The script has been tested in Windows 7 (both 32 and 64 bit versions), and in Linux Ubuntu 12.04, using R version 3.1.0 in all cases. 


## About the Getting and Cleaning Data Project. ##

The following paragraphs are quoted for reference from the project description in the course webpage:
  
> The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:*
> 
> [http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)
> 
> Here are the data for the project:
> [https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip ](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip )
> You should create one R script called run_analysis.R that does the following.
>   
> 1. Merges the training and the test sets to create one data set.
> 2. Extracts only the measurements on the mean and standard deviation for each measurement.
> 3. Uses descriptive activity names to name the activities in the data set.
> 4. Appropriately labels the data set with descriptive activity names.
> 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

### Data download information. ###

The `run_analysis.R` script in this repository was tested against data downloaded on (16:27 CET)April 26th 2014. The MD5 checksum for the zip file at that moment was:
d29710c9530a31f303801b6bc34bd895.
In case of doubt, use this checksum to verify if the zip file has changed.   

### Comments about the source code. ###
The ["Google's R Style Guide"](https://google-styleguide.googlecode.com/svn/trunk/Rguide.xml#comments) has been followed in the `run_analysis.R` script, with a few exceptions.
- When a data file is read into a `data.frame` R object, the name of the data frame is equal to the name of the data file, for ease of reference. 
- True comment lines begin with two \#\#. A commented line of code begins with a single \#. 

## Requirements (before running the analysis). 

**Please read the following thoroughly before attempting to execute the analysis script for the first time.**

- It is recommended to run the analysis in a new R session. 
- **It is required** that the `getdata-projectfiles-UCI HAR Dataset.zip`, containing the project data (see above), has been downloaded and decompresssed in the Working Directory. The decompression results in a folder called `UCI HAR Dataset` (and subfolders) being created in the Working Directory. This analysis assumes that none of the files in that folder have been modified after decompression.
- If, however, you want the `run_analysis.R` script to download and decompress the zip file by itself, the first section of the script contains some commented lines that can be uncommented to achieve this goal (this, of course, requires an active internet connection when executing the script).
- **Finally, it is also required** that the R library `data.table` (version 1.9.2 or higher) and its dependencies are already installed. As before, if you wish the script to download and install the library by itself, the script contains some commented lines for this purpose (again, an internet connection is required).
- It is also assumed that the `run_analysis.R` script is placed in you R Working Directory when it is executed. You can check this with the R function `getwd()`. The result should be the folder where `run_analysis.R` is placed. This is not a critical requirement, as long as the remaining requirements are met. If you run the script from a different folder, a warning will be issued.          


## Input Data Description. ##

### Input files. ###

The assumed folder/file structure of the UCI HAR Dataset folder is described in the following tree diagram. Folders are enclosed within brackets [ ].  

	[UCI HAR Dataset]
	|
	· - [test]
	|   |
	|	· - [Inertial Signals] (this folder contains additional files, not used in this analysis)
	|   |
	|	· - subject_test.txt
	|   |
	|	· - X_test.txt
	|   |
	|	· - y_test.txt
	|   
	· - [train]
	|   |
	|	· - [Inertial Signals] (this folder contains additional files, not used in this analysis)
	|   |
	|	· - subject_train.txt
	|   |
	|	· - X_train.txt
	|   |
	|	· - y_train.txt
	|
	· - activity_labels.txt
	|
	· - features.txt
	|
	· - features_info.txt
	|
	· - README.txt 
 
The `README.txt` file, located in the `UCI HAR Dataset` folder describes the experiment which originated the data, and the contents of the above files. In particular, the following research paper is provided as a reference:
> [1] *Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz*. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

We assume that the reader is familiar with the contents of that `README.txt` file. In what follows we will provide some additional and complementary information about those files, which is relevant for the purposes of this analysis:  

- For the purposes of this analysis, and taking into account the instructions provided in the Getting and Cleaning Data Project description, only the data in the txt files placed directly in the folders named `test` and `train` has been considered. In particular, we have not used in the analysis the files located in the `Inertial Signals` subfolders of the `test` and `train` folders. In taking this decission, we have    
- The `X_test.txt` file (in the `test` subfolder) contains a table with 2947 rows and 561 columns, with each row corresponding to an observation of 561 variables (collectively referred to as *'features'* by the experimenters). The file has no header line, and spaces (sometimes more than one) are used as separators.    
- The names of the 561 feature variables are contained in the `features.txt` file, located in the `UCI HAR Dataset` folder. This file contains a (561 rows by 2 columns) table. The first column is simply formed by the numbers from        
1 to 561, that serve as identifiers of the corresponding feature variable. The second column contains the name of the corresponding feature variable. For a description of the variable naming used by the experimenters, we refer to the `feature_info.txt`, located in the `UCI HAR Dataset` folder. This file cannot be considered a complete codebook.
- The `y_test.txt` file (in the `test` subfolder) contains a single column, with 2947 rows. Each row contains a number from 1 to 6. The number indicates the activity (1 = 'WALKING', 2 = 'WALKING_UPSTAIRS', etc.; see the `activity_labels.txt` file), for the corresponding row of the `X_test.txt` file. The correspondence between the labels from 1 to 6 and the activity names is described in the `activity_labels.txt` file, located in the `UCI HAR Dataset` folder.    
- Similarly, the `subject_test.txt` file  (in the `test` subfolder) contains a single column with 2947 rows. Each row contains a number between 1 and 30. The number indicates the subject that performed the activity, for the corresponding row of the `X_test.txt` file.         
- The `X_train.txt` (7352 rows, 561 columns), `y_train.txt` (7352 rows, 1 column) and `subject_train.txt` (7352 rows, 1 column), of the `train` subfolder play a similar role, in this case for the training group. 
- The `activity_labels.txt` in the `UCI HAR Dataset` folder has 6 rows and 2 columns. It is used to link the activity labels with the activity names.  


### Variables in the original data set.  ###

The experimenters have not included a file containing a standalone codebook for the variables in their data set. The information regarding the variable meaning and naming conventions is split between the `README.txt` and `feature_info.txt` files of the `UCI HAR Dataset` folder. And none of these files contains a list with the meaning of all the individual variables in the data set.  

We refer to the `codebook.md` in this repository for additional comments on these variables, and their relation with the variables in the output data file of the analyisis. 


## How does the run_analysis.R script work? Step by step description. ##
 
**Important remarks**: 


1. I have combined the "merging" and "extracting" phases of the project description (see the project description numbers 1 and 2, quoted in the *About the Getting and Cleaning Data Project* section above). The rationale for this is that only a small fraction of the columns in the (large) `X_test.txt` and `X_train.txt` files will be used in the rest of the analysis (66 out of 561 feature columns). It seems reasonable, therefore, to avoid reading those columns that will not be used. This makes the analysis more efficient, and allows for the consideration of even larger data sets, in less powerful computers (following the spirit, if maybe not strictly the letter of the project). Below we provide the detailed description for the implementation of this approach.
2. For the purposes of this analysis, only those feature names containing the string `-mean()` or the string `-std()` are considered, in my interpretation of the sentence 'measurements on the mean and standard deviation for each measurement' in the project desccription. This includes 66 feature names, such as `tBodyAcc-mean()-X` and `fBodyAccJerk-mean()-Y`, but excludes others such as `fBodyAcc-meanFreq()-X`, which also include the string 'mean'.   
The `features.txt` provided with the data describes this as *'Weighted average of the frequency components to obtain a mean frequency'*. Thus, I decided not to put these features in the same category as those that are directly computed as means. Similar considerations apply to other feature names, such as the angular features (ids 555 to 561). 	    

In what follows I describe the workflow of the `run_analysis.R` script. The description closely follows the comments included in the script.

#### Reading files in the `UCI HAR Dataset` folder. ###
- Step 1: The features.txt file (561 rows, 2 columns) is read into a data.frame called `features`. Its second column, containing the feature names, is read as as a character vector (not a factor). The first column is called `id`, the second is called `name`. The data frame is checked for missing values and for duplicate variable names. If any of these is found, a warning message is issued. At this step, the existence of duplicated feature names does not constitute a critical problem for the analysis. **Warning:** the 'features.txt' does, in fact, contain repeated feature names. Rows 303 and 317 contain the first 2 repetitions, but there are many more (they can be located with the command `duplicated(features$name)`). Thus, a warning is to be expected in this step.        
- Step 2: As I said before, only a small fraction of the features are used in the analysis.To locate them, we look for those feature names containing the string `-mean()` or the string `-std()` In this step, we use the `grep` function, with the string `-mean[\\(][\\)]|-std[\\(][\\)]` as selection pattern, to get the positions where those features are located.  The result is assigned to the `positionsToSelect` vector.  
If duplicate feature names are present in the selected positions for this step, then the final data set will include duplicate variable names (and therefore, it wouldn't be tidy). This does not cause the script execution to be stopped, but a warning is issued.  
Also in this step, the vector `positionsNotSelected` with the remaining, non selected positions is constructed. These vectors are used to create a character vector, `columnClasses`. The non-selected positions of this vector contain `NULL`, and will be used to tell the `read.table` function not to read those columns of the `X_test.txt` and `X_train.txt` data files.   
- Step 3: The `activity_labels.txt` file (6 rows, 2 columns) is read into the `activity_labels` data frame. The 2 columns of this data frame  are labelled `id` and `name`.  
Again, in this step, duplicate activity ids or names may appear. This does not cause execution to be stopped, but the resulting data set would not be tidy. A warning is issued in such case.  
Also in this step, the `activity_labels$name` vector is recoded as a factor where the levels correspond to the order indicated by the activity id.

### Reading the data from the `test` subfolder. ###
 
- Step 4: The `subject_test.txt` (2947 rows, 1 column) file is read into a data.frame called `subject_test`. The column is called `subjId`. If the  data frame contains missing values, a warning is issued. 
- Step 5: The `X_test.txt` (2947 rows, 561 columns) file is read into a data.frame called `X_test`, with column names automatically determined by R. The columnClasses vector created in Step 2 is used to read only the columns that we will use in the analysis. This is accomplished by using the optional `colClasses` argument of the `read.table` function. The result is that the `X_test` data frame has 2947 rows, but only 66 variables (corresponding to the selected positions; these will be called `V1`,`V2`, with the number indicating their original  position in the `X_test.txt` file).  
If the `subject_test` data frame contains missing values, a warning is issued.  
- Step 6: The `y_test.txt` file (2947 rows, 1 column) is read into a data frame called `y_test`. If the  data frame contains missing values, a warning is issued.
- Step 7: Pairing `y_test` with `activity_labels$name`. In this step, for each number in a row of `y_test`, we use that numbers to get the corresponding element of `activity_labels$name`. The resulting `activityLabelTest` factor has 2947 elements.
- Step 8: Putting together the pieces from the test group. With this, we are ready to bind the three vectors `subject_test$subjId`, `activityLabelTest`, `y_test$actId` with the `X_test`data frame, to create a new data frame called `testData` (2947 rows, 69 columns), with all the information from the test group. Recall that only the selected 66 columns of `X_test` are included in this data frame. Besides, this data frame will later be merged with a similar one from the training group. Therefore, we select the names of the first three columns, so that they will be the same in both groups (the rest will automatically be equal).              

### Reading the data from the `train` subfolder. ###

- Steps 9, 10, 11, 12 and 13. We repeat the above steps with the corresponding files in the `train` subfolder , making the necessary changes. These files have a common size of 7352 rows, where the `test` files had 2947. Other than that, the steps are identical, resulting in a `trainData` data frame with 7352 rows and 69 columns. As a result of their construction, the variable names in the `testData` and `trainData` data frames are identical: the first 3 columns correspond to variables called  `subjectId`, `activityLabel` and `activityId`, respectively.      

### Bringing the `test` and `train` data together. ###

- Step 14: The training and test data are merged into a single data frame. This is just a simple application of `rbind` to merge this two data frames.
- Step 15: Tidying the remaining variable names. The first three columns of totalData have already been given descriptive names. The rest need to be tidyed. We take as starting point the subset of selected positions of the `features$name` vector. We use camelCase notation for the variables names, and with successive applications of `gsub`, we remove dashes and parentheses from the feature names. Finally, `names(TotalData)` is assigned to the result of this tidying operation. The resulting `TotalData` data frame has the same first 3 variable names, but the rest look like `tBodyAccMeanX`, `tBodyAccMeanY`, ...,`fBodyBodyGyroJerkMagStd`.  

### Creating the output tidy data set ###

- Step 16: To create a tidy data set with the average of the feature variables, we will use the `data.table` library. We start by converting the `totalData` data frame to a data.table, called `totalDataDT`. The `data.table` library allows for an easy, one line application of the `mean` function, using a predetermined set of columns as grouping columns (that define the observational units), with the help of the `.SD` construction, and the notion of 'dynamic column names'. An easy reference for this is the example that can be found in this [Stack Overflow post](http://stackoverflow.com/questions/14937165/using-dynamic-column-names-in-data-table). For a detailed description, see the documentation for `data.table` [package help file](http://cran.r-project.org/web/packages/data.table/data.table.pdf). After defining the first 2 columns to be the grouping columns with:  
	`groupingColumnNames <- (names(totalData)[1:2])`  
we simply execute:  
```averagesDT <- totalDataDT[ , lapply(.SD, mean), by = groupingColumnNames, .SDcols=3:ncol(totalDataDT)]```  
The second argument `lapply(.SD, mean)` is an 'expression' (this was covered in lecture 1-9 of the Getting and Cleaning Data Course). Here, the `.SD` argument indicates the columns for which we wish to apply the mean function. The grouping columns are passed to the `by` argument. The resulting `averagesDT` is a `data.table` (180 rows, 69 columns), with the desired tidy data set. We will describe this result in detail below.  
Following this, we for visualization purposes, we sort the the `averagesDT` data.table with respect to the observational units, and we use `write.table` to write it to a text file, called `tidyDataSet.txt`.   


### Summary ###

Steps 1 to 14 above carry out the tasks described in points 1 to 4 of the Course Project Description. And the final two steps 15 and 16 carry out the task in point 5.

## Output file with the resulting tidy data set ##

The output of the `run_analysis.R` script is text file called `tidyDataSet.txt` in the R Working Directory (the one containing the `UCI HAR Dataset` folder). This text file has 180 rows and 69 columns. The items in a row are separated by commas. 

This file contains a tidy data set, in the sense of the ['Tidy Data' paper by Hadley Wickham](http://vita.had.co.nz/papers/tidy-data.pdf). The observational units are unique combinations of 'subject + activity' of which there are (30 subjects * 6 activities) 180 possible values. For each ot these observational units, the data set contains a row with the values of 69 variables. Each column corresponds to a variable, as expected in a tidy data set.    

### Codebook ###

The repository contains a file called `codebook.md`, with additional information about the variables in the output data set.