#setwd("UCI HAR Dataset")
library(data.table)
read_tables = function (files, cn) {
  data.table(rbindlist(lapply(files, read.table, col.names=cn)))
}
read_RDSes = function(files) {
  rbindlist(lapply(files, readRDS))
}
ty = read_tables(c("train/y_train.txt", "test/y_test.txt"), c("activity_id"))
ts = read_tables(c("train/subject_train.txt", "test/subject_test.txt"), c("subject_id"))
al = read_tables("activity_labels.txt", c("activity_id", "activity_name"))
f = fread("features.txt")
mean_std_cols = f[,grep("mean\\(\\)|std\\(\\)", V2)]

#tX = read_RDSes(c("trX.rds","teX.rds"))[,mean_std_cols,with=FALSE]
#setNames(tX, f[mean_std_cols, V2])
tX = read_tables(c("train/X_train.txt","test/X_test.txt"), f$V2)[,mean_std_cols,with=FALSE]
DF = cbind(tX, ty, ts)
DF = merge(DF, al, by="activity_id")[,lapply(.SD,mean),by=c("subject_id", "activity_name")]
