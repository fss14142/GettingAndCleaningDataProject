## About this file##

This (`codebook.md`) is the (partial) codebook for the data set contained in the `tidyDataSet.txt` file, which is the output file of the  "Getting and Cleaning Data Course Project" in the
"Getting and Cleaning Data" course (April 2014 edition) of
the [Coursera Data Science Specialization](https://www.coursera.org/specialization/jhudatascience/1?utm_medium=listingPage).
The associated github repository is located at 
[https://github.com/fss14142/GettingAndCleaningDataProject](https://github.com/fss14142/GettingAndCleaningDataProject). For more information, please look at the `README.md` file in that repository, and the references therein. 

The 'Complete list of variables' section below contains all the variable names in the `tidyDataSet.txt` file, in the order in which they appear in the columns of that file. As mentioned in the `README.md` file, the original data file does not contain a complete codebook. Thus, the following list is only an attempt at a general description of the variables and their naming conventions.    

## Subject/Activity variables ##

The first three variables in this data set indicate the unique combination of subject and activity that was observed.  
  
* subjectId: Integer variable, with values from 1 to 30. 
* activityLabel: Character variable, with six possible values. 
* activityId: Integer variable, with values from 1 to 6.  

The relation between activityLabel and activityId is summarized in this table:

 	1  WALKING
	2 WALKING_UPSTAIRS
	3 WALKING_DOWNSTAIRS
	4 SITTING
	5 STANDING
	6 LAYING     

## Feature Average Variables ##

The following 66 variables correspond to the average of some feature variables in the original data set, for each activity and each subject (as required in the project). Only the variables in the original data set that contain the measurements on the mean and standard deviation for each measurement have been considered, when computing the said averages. More precisely, only those variables whose names contain either the string `mean()-` or the string `std()-` . 

Take into account that the values of the original variables are floating point values that have been "normalized and bounded within [-1,1]" (quoted from the `readme.txt` file of the original data set).  

In the naming conventions for the variables of the original data set, and with the exception of features 555 to 561, that correspond to angle measurements, the rest of the feature variable names begin either with a `t` (indicating time domain, for features 1 to 265), or an `f` (indicating frequency domain, for features 266 to 554). With the exception of the angular variables (555 to 561), the following part of the variable name indicates whether the measure corresponds to the Body, Gyroscope or  Gravity component. The third part indicates whether the Acceleration or Jerk (3rd derivative) is measured. The letters X, Y, Z indicate which combinations of spatial directions is considered. Please refer to the `README.txt` and `features_info.txt` files included in the original data set for further details.

We have used different, but related, naming conventions for the variables in the outout data set. For example, the average (for each activity and each subject) of a variable called `tBodyAcc-mean()-X` in the original data set, is called `tBodyAccMeanX` in `tidyDataSet.txt`. Please refer to the Step 15 in the Step by Step description of the analysis in `README.md`, to see the details of the transformation applied to the variable names. In brief, parenthesis and dashes are removed, and a sort of CamelCase formatting is applied. 

Given the initial amount of information about the meaning of the original variables, we have refrained from attempting to give seemingly more complete names to the variables.    
  
	     
## Complete list of variables in the `tidyDataSet.txt` file ##

And their relation to the variables in the original data set.   

  1. subjectId: Integer variable, with values from 1 to 30. It identifies the subject performing the activities.
  2. activityLabel: Character variable, with six possible values. The value is the name of the activity.
  3. activityId: Integer variable, with values from 1 to 6.  A numeric identifier for the activity.
  4. tBodyAccMeanX: average for the variable `tBodyAcc-mean()-X`.
  5. tBodyAccMeanY: average for the variable `tBodyAcc-mean()-Y`.
  6. tBodyAccMeanZ: average for the variable `tBodyAcc-mean()-Z`.
  7. tBodyAccStdX: average for the variable `tBodyAcc-std()-X`.
  8. tBodyAccStdY: average for the variable `tBodyAcc-std()-Y`.
  9. tBodyAccStdZ: average for the variable `tBodyAcc-std()-Z`.
  10. tGravityAccMeanX: average for the variable `tGravityAcc-mean()-X`.
  11. tGravityAccMeanY: average for the variable `tGravityAcc-mean()-Y`.
  12. tGravityAccMeanZ : average for the variable `tGravityAcc-mean()-Z`.
  13. tGravityAccStdX: average for the variable `tGravityAcc-std()-X`.
  14. tGravityAccStdY: average for the variable `tGravityAcc-std()-Y`.
  15. tGravityAccStdZ: average for the variable `tGravityAcc-std()-Z`.
  16. tBodyAccJerkMeanX: average for the variable `tBodyAccJerk-mean()-X`.
  17. tBodyAccJerkMeanY: average for the variable `tBodyAccJerk-mean()-Y`.
  18. tBodyAccJerkMeanZ: average for the variable `tBodyAccJerk-mean()-Z`.
  19. tBodyAccJerkStdX: average for the variable `tBodyAccJerk-std()-X`.
  20. tBodyAccJerkStdY: average for the variable `tBodyAccJerk-std()-Y`.
  21. tBodyAccJerkStdZ: average for the variable `tBodyAccJerk-std()-Z`.
  22. tBodyGyroMeanX: average for the variable `tBodyGyro-mean()-X`.
  23. tBodyGyroMeanY: average for the variable `tBodyGyro-mean()-Y`.
  24. tBodyGyroMeanZ: average for the variable `tBodyGyro-mean()-Z`.
  25. tBodyGyroStdX: average for the variable `tBodyGyro-std()-X`.
  26. tBodyGyroStdY: average for the variable `tBodyGyro-std()-Y`.
  27. tBodyGyroStdZ: average for the variable `tBodyGyro-std()-Z`.
  28. tBodyGyroJerkMeanX: average for the variable `tBodyGyroJerk-mean()-X`.
  29. tBodyGyroJerkMeanY: average for the variable `tBodyGyroJerk-mean()-Y`.
  30. tBodyGyroJerkMeanZ: average for the variable `tBodyGyroJerk-mean()-Z`.
  31. tBodyGyroJerkStdX: average for the variable `tBodyGyroJerk-std()-X`.
  32. tBodyGyroJerkStdY: average for the variable `tBodyGyroJerk-std()-Y`.
  33. tBodyGyroJerkStdZ: average for the variable `tBodyGyroJerk-std()-Z`.
  34. tBodyAccMagMean: average for the variable `tBodyAccMag-mean()`.
  35. tBodyAccMagStd: average for the variable `tBodyAccMag-std()`.
  36. tGravityAccMagMean: average for the variable `tGravityAccMag-mean()`.
  37. tGravityAccMagStd: average for the variable `tGravityAccMag-std()`.
  38. tBodyAccJerkMagMean: average for the variable `tBodyAccJerkMag-mean()`.
  39. tBodyAccJerkMagStd: average for the variable `tBodyAccJerkMag-std()`.
  40. tBodyGyroMagMean: average for the variable `tBodyGyroMag-mean()`.
  41. tBodyGyroMagStd: average for the variable `tBodyGyroMag-std()`.
  42. tBodyGyroJerkMagMean: average for the variable `tBodyGyroJerkMag-mean()`.
  43. tBodyGyroJerkMagStd: average for the variable `tBodyGyroJerkMag-std()`.
  44. fBodyAccMeanX: average for the variable `fBodyAcc-mean()-X`.
  45. fBodyAccMeanY: average for the variable `fBodyAcc-mean()-Y`.
  46. fBodyAccMeanZ: average for the variable `fBodyAcc-mean()-Z`.
  47. fBodyAccStdX: average for the variable `fBodyAcc-std()-X`.
  48. fBodyAccStdY: average for the variable `fBodyAcc-std()-Y`.
  49. fBodyAccStdZ: average for the variable `fBodyAcc-std()-Z`.
  50. fBodyAccJerkMeanX: average for the variable `fBodyAccJerk-mean()-X`.
  51. fBodyAccJerkMeanY: average for the variable `fBodyAccJerk-mean()-Y`.
  52. fBodyAccJerkMeanZ: average for the variable `fBodyAccJerk-mean()-Z`.
  53. fBodyAccJerkStdX: average for the variable `fBodyAccJerk-std()-X`.
  54. fBodyAccJerkStdY: average for the variable `fBodyAccJerk-std()-Y`.
  55. fBodyAccJerkStdZ: average for the variable `fBodyAccJerk-std()-Z`.
  56. fBodyGyroMeanX: average for the variable `fBodyGyro-mean()-X`.
  57. fBodyGyroMeanY: average for the variable `fBodyGyro-mean()-Y`.
  58. fBodyGyroMeanZ: average for the variable `fBodyGyro-mean()-Z`.
  59. fBodyGyroStdX: average for the variable `fBodyGyro-std()-X`.
  60. fBodyGyroStdY: average for the variable `fBodyGyro-std()-Y`.
  61. fBodyGyroStdZ: average for the variable `fBodyGyro-std()-Z`.
  62. fBodyAccMagMean: average for the variable `fBodyAccMag-mean()`.
  63. fBodyAccMagStd: average for the variable `fBodyAccMag-std()`.
  64. fBodyBodyAccJerkMagMean: average for the variable `fBodyBodyAccJerkMag-mean()`.
  65. fBodyBodyAccJerkMagStd: average for the variable `fBodyBodyAccJerkMag-std()`.
  66. fBodyBodyGyroMagMean: average for the variable `fBodyBodyGyroMag-mean()`.
  67. fBodyBodyGyroMagStd: average for the variable `fBodyBodyGyroMag-std()`.
  68. fBodyBodyGyroJerkMagMean: average for the variable `fBodyBodyGyroJerkMag-mean()`.
  69. fBodyBodyGyroJerkMagStd: average for the variable `fBodyBodyGyroJerkMag-std()`.  