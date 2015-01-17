
######################### RETRIEVE DATA #############################
# download file
setwd("./run_analysis")
url <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, "./dataset.zip", quiet = T, method = "curl")

# unzip file
unzip("dataset.zip")
setwd("./UCI HAR Dataset")

# get directory of components in the unzipped file,
# (dir1 for test data, dir2 for training data)
dir1 <- list.files("./test",full.names = T)
dir2 <- list.files("./train",full.names = T)


################### PERSONALIZED FUNCTIONS ##########################
# create a function that extracts character strings after a space (" ")
afterspace <- function(x){
  temp <- strsplit(x,split = " ")
  output <- sapply(temp,function(x){x[2]})
  output
}

# create a function (myread) that reads the contents 
# in a directory (with the same structure as the "test"
# and "train" folder) seperately and returns a dataframe
myread <- function(dir) {
  subject <- read.table(dir[2], header = F, sep = "") # read in subject_test.txt / subject_train.txt
  data <- read.table(dir[3], header = F, sep = "") # read in X_test.txt / X_train.txt
  label <- read.table(dir[4], header = F, sep = "") # read in y_test.txt / y_train.txt
  df <- cbind(data, label, subject)
  df
}


################# OBJECTIVE 1: MERGE DATA SETS ######################
# read the test and training data sets
test <- myread(dir1)
train <- myread(dir2)

# merge test and training data 
data <- rbind(train, test)


################## OBJECTIVE 4: LABEL DATA SET ######################
# get feature names (i.e. column names in the dataset)
header <- afterspace(readLines("./features.txt"))

# remove parentheses in feature names
header <- gsub("\\(\\)","",name)

# rename columns
names(data)[1:561] <- header
names(data)[562:563] <- c("label","subject")


############### OBJECTIVE 2: EXTRACT MEAN & STD #####################
data <- data[,grep("(.mean.[^Freq])|.std.|label|subject", names(data))]


################# OBJECTIVE 3: NAME ACTIVITIES ######################
#rename the contents in "label" column using descriptive activity names 
activity <- afterspace(readLines("./activity_labels.txt"))
for (i in 1:6){
  temp <- gsub(i,activity[i],data$label[which(data$label==i)])
  data$label[which(data$label==i)] <- temp
}


################### OBJECTIVE 5: TIDY DATA SET ######################
# merge the two variables "label" and "subject" into new variable "labsub"
library(dplyr)
data <- mutate(data, labsub = paste0(label,".",subject))

# split data set by "labsub"
s <- split(data, data$labsub)

# calculate the average of each measurement in the splitted data set
mean <- sapply(s, function(x) {colMeans(x[1:(dim(x)[2]-3)])})

# transpose the new data set and change into data frame
tidy <- data.frame(t(mean))
tidy$labsub <- dimnames(mean)[[2]]

# separate the "labsub" variable back to "label" and "subject"
library(tidyr)
tidy <- separate(tidy, labsub, c("label","subject"), sep = "\\.")

# change order of variables and data arrangement
tidy <- tidy[,c(67:68,1:66)]
tidy$subject <- as.numeric(tidy$subject)
tidy <- arrange(tidy,label, subject)