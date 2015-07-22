# UCI HAR Project Code Book

Data are available from a "Human Activity Recognition" experiment, in which *n* = 30 subjects were studied while they wore smartphones on
their waists. The smartphones included inertial sensors capable of measuring 3-dimensional motion and related features.

For each subject, repeated measurements of many variables were taken across multiple time periods by the inertial sensors. The resulting measurement types ("features") will be described below. In addition, using manual inspection of video, each subject's "activity" 
was classified into one of six categories at each measured time. The six activity categories are:

1. WALKING
2. WALKING_UPSTAIRS
3. WALKING_DOWNSTAIRS
4. SITTING
5. STANDING
6. LAYING

On UC Irvine's website, the data are divided into "test" and "training" subsets for purposes of 
higher-level analysis. Also, the labels for the six activity types and the various features are 
stored in files separate from the data itself.

For the purposes of this project, I have written 
an R script, run_analysis.R, which merges, 
subsets, and then tidies up these data files per 
the project instructions. From the .zip file 
provided for the project, the following are 
required:

**features.txt** - lists the 561 available features.

**activity_labels.txt** - lists the 6 activity names.

**X_train.txt** - file within the train folder that 
houses the numerical data for the "training" 
subset.

**y_train.txt** - file within the train folder that 
indicates the activity associated with each 
measurement set (row) within X_train.

**subject_train.txt** - file within the train 
folder that indicates the subject (by number, 1-
30) associated with each measurement set (row) 
within X_train.

**X_test.txt** and **y_test.txt** and 
**subject_test.txt** - analogous files for the 
"test" subset, in the test folder. 

---

My R script concatenates the "test" and "training" subsets and applies the activity and feature labels. 
The resulting data frame has 10,299 rows. Each row corresponds to one subject during one time period spent
in the same activity (e.g., a time interval in which subject 14 was LAYING).  Since each subject was recorded
doing the same activity many times, there are several rows for each of the 30x6 = 180 Subject-Activity pairs.
The data frame also has 563 columns: two columns indicating the subject ID number (**SubjectID**) and the activity
type (**Activity**), and 561 that contain feature data. As an example, a "feature" might be the mean body acceleration
magnitude for that subject during the measured time interval.

Although 561 features are available, the project instructions were to extract only those which represent the
mean or standard deviation of a variable. There are 33 such variables, listed in the **features_info.txt** file that
accompanies the data:

* tBodyAcc-XYZ
* tGravityAcc-XYZ
* tBodyAccJerk-XYZ
* tBodyGyro-XYZ
* tBodyGyroJerk-XYZ
* tBodyAccMag
* tGravityAccMag
* tBodyAccJerkMag
* tBodyGyroMag
* tBodyGyroJerkMag
* fBodyAcc-XYZ
* fBodyAccJerk-XYZ
* fBodyGyro-XYZ
* fBodyAccMag
* fBodyAccJerkMag
* fBodyGyroMag
* fBodyGyroJerkMag

See the original data set's documentation for details on these variables. 

How does this constitute 33 variables? Any name ending in -XYZ is actually comprised of three variables corresponding
to three axial dimensions (X, Y, and Z).  

For each of these 33 variables, the mean and sd features were extracted by me using the *grep* function in R. 
This results in 2x33 = 66 extracted data columns, plus the two labeling columns. The researchers' naming conventions for 
the features is a bit squirrely. For a variable that does *not* have 3-axial components, the two extracted
items have names expressed in the format *variablename*-mean() and *variablename*-std().  So, for example, there
are columns labeled tBodyAccMag-mean() and tBodyAccMag-std(). For 3-axial variables, which recall are really three
variables, the dimension (X,Y,Z) is tagged *after* the name of the statistic. So, for example, there are features named
tBodyGyro-mean()-X, tBodyGyro-std()-X, tBodyGyro-mean()-Y, and so on.

At this point, the data frame has 68 columns as described immediately above, but still 10,299 rows. Again, each
subject was in each activity setting multiple times, and there is a row for each such time interval.  The final
step of the project was to create a "tidy" data set with just one row for each Subject-Activity pair by averaging
the features within each such pair.  I achieved this using the **melt** and **dcast** commands within the 
**reshape2** R package (see my R code for details).

---

The end result of my R script is an output file Tidy.Means.txt, a standard .txt file readble by R, with 180
rows and 68 columns. Again, the 180 rows are for the 30x6 Subject-Activity pairs, and the 68 columns are for
the two labels and the 66 now-averaged mean and sd measurements (averaged within a Subject-Activity pair). The
column headers, i.e. variable names, for the 66 averaged quantities have not been re-named; to access these
averages, use their original names (e.g., tBodyAccMag-std()) as described above.
