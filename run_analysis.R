## usage: run_analysis("UCI HAR Dataset")
##
## The data should be available in the directory "UCI HAR Dataset" in current working directory
run_analysis <- function(datasetPath)
{
  ## find indexes of features pertaining to mean() and std()
  feature_names <- read.table(paste(datasetPath, "/features.txt", sep = ""), stringsAsFactors = F)
  features <- grep("*mean()*|*std()*", feature_names$V2)
  
  ## read and merge activities
  test.activity <- read.table(paste(datasetPath, "/test/y_test.txt", sep = ""), stringsAsFactors = F)
  train.activity <- read.table(paste(datasetPath, "/train/y_train.txt", sep = ""), stringsAsFactors = F)
  activity_id <- rbind2(test.activity, train.activity)
  
  ## read activity names
  activity_names <- read.table(paste(datasetPath, "/activity_labels.txt", sep = ""), stringsAsFactors = F)
  activity <- unlist(lapply(activity_id, function(x)(activity_names[as.numeric(x),2])))
  
  ## read and merge subjects
  test.subject <- read.table(paste(datasetPath, "/test/subject_test.txt", sep = ""), stringsAsFactors = F)
  train.subject <- read.table(paste(datasetPath, "/train/subject_train.txt", sep = ""), stringsAsFactors = F)
  subject <- rbind2(test.subject, train.subject)

  ## read read and merge X
  test.X <- select(read.table(paste(datasetPath, "/test/X_test.txt", sep = ""), stringsAsFactors = F), features)
  train.X <- select(read.table(paste(datasetPath, "/train/X_train.txt", sep = ""), stringsAsFactors = F), features)
  X <- rbind2(test.X, train.X)
  
  ## create and decorate df
  df <- data.frame(activity)
  df <- cbind(df, subject)
  df <- cbind(df, X)
  colnames(df) <- c(c("Activity", "Subject ID"), feature_names$V2[features])
  df[,1] <- as.character(df[,1])

  ## create and decorate tidy_df, our final tidy dataset
  tidy_df <- expand.grid(as.character(activity_names[,2]), c(1:30), feature_names$V2[features])
  tidy_df <- cbind2(tidy_df, rep(0.0, nrow(tidy_df)))
  tidy_df[,1] <- as.character(tidy_df[,1])
  tidy_df[,3] <- as.character(tidy_df[,3])
  for(i in 1:nrow(tidy_df))
  {
    tidy_df[i,4] <- mean(df[df$Activity == tidy_df[i,1] & df$`Subject ID` == tidy_df[i,2], tidy_df[i,3]])
  }
  colnames(tidy_df) <- c("Activity", "Subject ID", "Feature", "Average")
  tidy_df
}