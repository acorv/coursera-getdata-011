# Course Project for Getting and Cleaning Data 
# February 2015

This repo contains files for the Course Project of Getting and Cleaning Data.
Files included:
- **run_analysis.R** *(R script for processing the Samsung Data Set)*
- **codebook.md** *(Code book for the tidy output data set)*
    

## run_analysis.R

The script must be run with the working directory set to the root of the UCI HAR Dataset. 
Upon completion, it will leave a data.frame called *tidy* in the environment, containing the tidy data.

Brief rundown of the script:
- Takes feature names from features.txt, and filters those only containing 'mean()' and 'std()' in their names. These are the features that will be exported.
- Joins the subject, activity and value data in both test and train data sets
- Replaces the activity numbers with proper names (taken from activity_labels.txt)
- Appends train and test data sets into one.
- Outputs the means for the selected features, grouped by activity and subject.

## codebook.md

This file contains the data dictionary for the tidy data set ouput by run_analysis.R. 

