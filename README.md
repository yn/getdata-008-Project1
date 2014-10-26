# Script description

The run_analysis.R script creates the tidy dataset for the assignment from the UCI HAR Dataset via the following steps:

1. Load the train and test labels IDs using `read.table` and `data.table`, stitch them together using `rbindlist`, and set the column name to `"activity_id"`.
2. Load the train and test subject IDs using `read.table` and `data.table`, stitch them together using `rbindlist`, and set the column name to `"subject_id"`.
3. Load the file that maps activity IDs to text names, and set the column names to `"activity_id"`, and `"activity_name"`.
4. Load the feature names into a `data.table`.
5. Identify feature names that contain `mean()` or `std()` as a substring.
6. Load the train and test feature measurements, stitch them together, and set the column names to feature measurements.
7. Subset the feature measurements by feature names from Step 5.
8. Stitch together the feature measurements, subject IDs, and activity names using `cbind` and `merge`
9. Generate a separate tidy dataset that takes the mean for every feature measurement, grouped by `subject_id` and `activity_name`.
10. Write the tidy dataset to `tidy.txt`

# Viewing the data

To view the data, in RStudio execute the following:

```
data = read.table(file_path, header = TRUE)   
View(data)
```