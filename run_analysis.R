# This script takes in the files provided for the Coursera
# Data Science Module 3 Project. The script should be placed in
# the top level of the unzipped files for the assignment, so
# that "activity_levels.txt" and so on are in the same folder,
# with the "test" and "train" folders one level below.
# 
# For details on how to use the script, what it does, and what
# the variables mean, please consult the associated ReadMe.md
# on GitHub and the Codebook.md on the same GitHub repo.

# Read in 561 labels, extract names only
features <- read.table("features.txt",stringsAsFactors=F)[[2]]

# Read in 6 activity names, extact names only
activities <- read.table("activity_labels.txt",stringsAsFactors=F)[[2]]

# Read in training data & convert to a single data frame
X_train <- read.table("./train/X_train.txt")
y_train <- read.table("./train/y_train.txt")
subject_train <- read.table("./train/subject_train.txt")
TRAIN <- cbind(subject_train,y_train,X_train)
rm("X_train")  # Remove large file from memory

# Read in test data & convert to a single data frame
X_test <- read.table("./test/X_test.txt")
y_test <- read.table("./test/y_test.txt")
subject_test <- read.table("./test/subject_test.txt")
TEST <- cbind(subject_test,y_test,X_test)
rm("X_test")  # Remove large file from memory

# Now, merge the two files into one massive file
data <- rbind(TRAIN,TEST)
rm("TRAIN","TEST") # Again, remove large files

# Give the columns nice labels
names(data) <- c("SubjectID","Activity",features)

# Link activity names to activity numbers
data$Activity <- factor(data$Activity,levels=1:6,
                        labels=activities)

# At this point, we have 
# 1. Merged the training and test data sets.
# 3. Descriptive activity names for the activities.
# 4. Labels data set with descriptive variable names.
# I'm assuming that SubjectID, Activity, and the actual
# names of the 561 features is acceptable.

# Next task: Extract only the mean and sd columns.
# NOTE: There are 33 of each.
# To do this, I'm going to use the grep command.

means <- grep("-mean()",names(data),fixed=T)
sds <- grep("-std()",names(data),fixed=T)

#Now, grab those *plus* the person and activity labels

data2 <- data[,c(1,2,means,sds)]

#As a check: data2 is 10299x68, which is right: 10299 rows (all),
#2 label columns, 33 "mean" cols, 33 "std" cols.

# At this point, we have
# 2. Extracted just the columns with means and sds.

# Final task: create a tidy data set with the "grand means"
# of all 66 variables for each Subject-Activity pair.

library(reshape2)

melt1 <- melt(data2,id.vars = c("SubjectID","Activity"),
              measure.vars = names(data2)[3:68])

Tidy.Means <- dcast(melt1, SubjectID + Activity ~ variable, mean)

write.table(Tidy.Means,"Tidy.Means.txt",row.names=F)

# Okay, let's clean up all files other than the Tidy.Means file

rm(list = ls()[ls()!="Tidy.Means"])

