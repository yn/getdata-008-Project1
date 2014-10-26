#setwd("UCI HAR Dataset")
library(data.table)
read_tables = function (files, cn) {
  DF = data.table(rbindlist(lapply(files, read.table)))
  setnames(DF, cn)
  DF
}
ty = read_tables(c("train/y_train.txt", "test/y_test.txt"), c("activity_id"))
ts = read_tables(c("train/subject_train.txt", "test/subject_test.txt"), c("subject_id"))
al = read_tables("activity_labels.txt", c("activity_id", "activity_name"))
f = fread("features.txt")
mean_std_cols = f[,grep("mean\\(\\)|std\\(\\)", V2)]
tX = read_tables(c("train/X_train.txt","test/X_test.txt"), f$V2)[,mean_std_cols,with=FALSE]
DF = merge(cbind(tX, ty, ts), al, by="activity_id")
TD = DF[,lapply(.SD,mean),by=c("subject_id", "activity_name")]
write.table(TD, "tidy.txt", row.names = FALSE)