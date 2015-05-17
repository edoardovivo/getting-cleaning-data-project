tidyDataSamsung <- function() {
        
        library(dplyr)
        
        #Extract names and types of the columns to read
        fname <- "UCI HAR Dataset/features.txt"
        features <- read.table(fname, header=F, stringsAsFactors=F)
        columnsToRead <- rep("NULL", dim(features)[1])
        indexes <- grep("mean|std", features[,2])
        columnsToRead[indexes] <- "numeric"
        names <- features[indexes, 2]
        
        #Extract labels names
        fname <- "UCI HAR Dataset/activity_labels.txt"
        labels_names <- read.table(fname, stringsAsFactors=F, header=F)
        names(labels_names) <- c("ActivityLabels", "Activity")
        
        
        #Read the train set - only the mean and std variables
        fname <- "UCI HAR Dataset/train/X_train.txt"
        data_train <- read.table(fname, stringsAsFactors=F, header=F, colClasses=columnsToRead)
        names(data_train) <- names
        #Read activity labels for the train set
        fname <- "UCI HAR Dataset/train/y_train.txt"
        labels_train <- read.table(fname, stringsAsFactors=F, header=F)
        #Add column to the data set
        data_train$ActivityLabels <- labels_train[,1]
        
        #Read subject IDs
        fname <- "UCI HAR Dataset/train/subject_train.txt"
        data_train$Subject <- read.table(fname, stringsAsFactors=F, header=F)[,1]
        
        
        
        #Read the test set - only the mean and std variables
        fname <- "UCI HAR Dataset/test/X_test.txt"
        data_test <- read.table(fname, stringsAsFactors=F, header=F, colClasses=columnsToRead)
        names(data_test) <- names
        
        #Read activity labels for the test set
        fname <- "UCI HAR Dataset/test/y_test.txt"
        labels_test <- read.table(fname, stringsAsFactors=F, header=F)
        #Add column to the data set
        data_test$ActivityLabels <- labels_test[,1]
        
        #Read subject IDs
        fname <- "UCI HAR Dataset/test/subject_test.txt"
        data_test$Subject <- read.table(fname, stringsAsFactors=F, header=F)[,1]
        
        #Merge the data sets with the labels_name dataset
        data_test <- merge(data_test, labels_names, by="ActivityLabels")
        data_train <- merge(data_train, labels_names, by="ActivityLabels")
        
        #Merge the train and test data set, and do some reordering and sorting by Subject
        dataAll <- rbind(data_train, data_test)
        dataAll <- subset(dataAll, select=-c(ActivityLabels)) %>% select(Subject, Activity, everything()) %>%
                arrange(Subject)
        
        tidyDataSamsung <- dataAll %>% group_by(Subject, Activity) %>% summarise_each(funs(mean))
        tidyDataSamsung
        
}






