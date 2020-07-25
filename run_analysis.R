library(dplyr)

# Merges the training and the test sets to create one data set.

subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
Y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")

subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
Y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")

subject_total <- rbind(subject_test, subject_train)
X_total <- rbind(X_train, X_test)
Y_total <- rbind(Y_test, Y_train)

features_names <- read.table("./UCI HAR Dataset/features.txt")
activity_label <- read.table("./UCI HAR Dataset/activity_labels.txt")

selected_feat <- features_names[grep("mean\\(\\)|std\\(\\)", features_names[,2]),]
X_total <- X_total[, selected_feat[,1]]

colnames(Y_total) <- "activity"
colnames(subject_total) <- "subject"
colnames(X_total) <- t(selected_feat[,2])

Y_total$activitylabel <- factor(Y_total$activity, labels = as.character(activity_label[,2]))
activitylabel <- Y_total[,-1]

full_data <- cbind(X_total, activitylabel, subject_total)
Average_data <- full_data %>% group_by(activitylabel, subject) %>% summarize_each(list(mean))
write.table(Average_data, file="./UCI HAR Dataset/tidydata.txt", row.names = FALSE, col.names = TRUE)




