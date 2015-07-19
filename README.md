# module3project

This repo contains two files related to the Coursera Data Science Module 3 Project:
- An R script, run_analysis.R
- A code book, CodeBook.md
 
The R script is meant to be applied to the UC Irvine Human Activity Recognition data file, available in .zip format from the Coursera project page. You first need to dowload that file and unzip it.  The R script assumes that your working directory is the "UCI HAR Dataset" folder, within which are some files such as "activity_levels.txt" and two sub-folders called "test" and "train".

Once you have set this working directory, run the script. It will take a few seconds (but hopefully not too long) to read in the two large files containing the primary data. The script first concatenates the two data files, applies labels, and strips out the variables requested in the project assignment. Next, the script finds the mean of each variable and outputs a file, called "Tidy_Means.txt", that gives the mean value at every Subject-Activity-Variable triplet.

Please consult the code book for further information, including identification of the variables.

NOTE: The output .txt file is a "long-and-skinny" tidy data file. Each row corresponds to a single Subject-Activity-Variable triplet, and the only other column is the mean for that triplet. (This is one acceptable tidy data format, the other being a file with one row for each Subject-Activity pair and many columns for the many variables. I have chosen not to use this option.)
