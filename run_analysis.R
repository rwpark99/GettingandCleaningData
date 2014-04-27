#########################################################
#03 week 1 assignment
# April 26. 2014, Rae Woong Park
#########################################################

library(data.table)
#setwd("C:/Users/Administrator/Documents/GitHub/GettingandCleaningData/")
#setwd("C:/Users/Administrator/Documents/data/UCI HAR Dataset/")
# 1. Merges the training and the test sets to create one data set.
# & 3. Uses descriptive activity names to name the activities in the data set
# $ 4. Appropriately labels the data set with descriptive activity names.

# 3. Uses descriptive activity names to name the activities in the data set
activity_labels <- fread("activity_labels.TXT",  sep="auto", header=FALSE)
trainYData <- fread("./train/y_train.txt",  sep="auto", header=FALSE)
testYData <- fread("./test/y_test.txt",  sep="auto", header=FALSE)
setkey(trainYData, V1)
setkey(testYData, V1)

trainYData <- trainYData[activity_labels]
testYData <- testYData[activity_labels]
setnames(trainYData, "V2", "activity")
setnames(testYData, "V2", "activity")

col.names = read.table("features.TXT")
col.namesModified <- gsub("[()]","_", col.names$V2) # replace "(", ")", "-" into "_"
#col.namesModified <- gsub("-","", col.names$V2) # replace "(", ")", "-" into "_"


trainSubjectData  <- read.table("./train/subject_train.txt", col.names="subject", sep="", header=FALSE)
trainXData         <- read.table("./train/X_train.txt", sep="", col.names=col.namesModified, header=FALSE)
# 4. Appropriately labels the data set with descriptive activity names.
trainData <- cbind(trainSubjectData, trainYData[,2,with=FALSE], trainXData)

testSubjectData  <- read.table("./test/subject_test.txt", col.names="subject", sep="", header=FALSE)
testXData         <- read.table("./test/X_test.txt", sep="", col.names=col.namesModified, header=FALSE)
# 4. Appropriately labels the data set with descriptive activity names.
testData <- cbind(testSubjectData, testYData[,2,with=FALSE], testXData)

# 1. Merges the training and the test sets to create one data set.
mergedData <-rbind(trainData, testData)
write.table(mergedData, file = "mergedData.txt", append = FALSE, quote = FALSE, sep = "\t", row.names = FALSE, col.names = TRUE)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
meanStdData <- data.table(mergedData[, grep("subject|activity|mean__|std__", colnames(mergedData), value=TRUE, ignore.case = FALSE)])

# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
setkey(meanStdData, subject, activity)
summaryDataWrite <- meanStdData[, lapply(.SD, mean()), by="subject,activity"]
write.table(summaryDataWrite, file="tidyData.txt", sep="\t", row.names=FALSE, col.names=TRUE)

#########################################################
# End of Assignment
#########################################################