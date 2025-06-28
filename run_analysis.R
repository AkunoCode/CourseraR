# Load or install required packages
required_pkgs <- c("data.table", "reshape2")
lapply(required_pkgs, function(pkg) {
  if (!require(pkg, character.only = TRUE)) install.packages(pkg)
  library(pkg, character.only = TRUE)
})

# Set up working directory and download data
path <- getwd()
zip_file <- file.path(path, "dataFiles.zip")
dataset_folder <- file.path(path, "UCI HAR Dataset")

if (!file.exists(dataset_folder)) {
  url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(url, zip_file, mode = "wb")
  unzip(zipfile = zip_file)
}

# Load activity labels and features
activityLabels <- fread(file.path(dataset_folder, "activity_labels.txt"),
                        col.names = c("classLabels", "activityName"))
features <- fread(file.path(dataset_folder, "features.txt"),
                  col.names = c("index", "featureNames"))

# Extract mean and std features
featuresWanted <- grep("(mean|std)\\(\\)", features$featureNames)
measurements <- gsub("[()]", "", features$featureNames[featuresWanted])

# Load and process dataset helper function
load_dataset <- function(type) {
  x <- fread(file.path(dataset_folder, type, paste0("X_", type, ".txt")))[, featuresWanted, with = FALSE]
  setnames(x, measurements)
  
  y <- fread(file.path(dataset_folder, type, paste0("Y_", type, ".txt")), col.names = "Activity")
  subject <- fread(file.path(dataset_folder, type, paste0("subject_", type, ".txt")), col.names = "SubjectNum")
  
  cbind(subject, y, x)
}

# Load train and test datasets
train <- load_dataset("train")
test <- load_dataset("test")

# Combine train and test data
combined <- rbind(train, test)

# Apply activity labels and factor subject
combined$Activity <- factor(combined$Activity,
                            levels = activityLabels$classLabels,
                            labels = activityLabels$activityName)
combined$SubjectNum <- as.factor(combined$SubjectNum)

# Melt and cast for tidy data
tidyData <- dcast(melt(combined, id.vars = c("SubjectNum", "Activity")),
                  SubjectNum + Activity ~ variable, mean)

# Write tidy dataset to file
fwrite(tidyData, "tidyData.txt", quote = FALSE)
