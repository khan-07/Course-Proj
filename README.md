
##Script

Working of the run_analysis.R script is explained.

1-The *activity_labels* file was read to find the name of the activities.

2-*features.txt* was read and indices of all the features that were either "mean()" or "std()"" measurements were extracted from the feature vector. This was done according to the original dataset as it was explicitly specified in the *features_info.txt*. Other features like meanFreq() and angle(tBodyAccMean,gravity) were not considered for the dataset because even though the contain Mean in there name they specify different measurements.

3-*X_train* was read according to the features extracted from the above step.

4-First train data was read from the UCI HAR Dataset. *X_train*, *subject_train* and *y_train* were all binded to form a single dataset.

5-*X_train* was read according to the features extracted from 2nd step.

6-Then all the test data was read from the UCI HAR Dataset. *X_train*, *subject_train* and *y_train* were all binded to form a single dataset.

7-Test dataframes and train dataframes were then binded to form one complete data.

8-Variable were given the same names that were contained in the *features.txt*. Only special character like _"-"_ and _"()"_ were changed to _"."_ because they are by default allowed in R. If they were not changed, R would automatically coersce all special characters to _"."_ which would result in discrepancy between the variable names defined in the codebook.md and actual names.

9-This resulted in first tidy dataset. Its dimensions were 10229 * 68.

10-Then a second Tidy dataset was formed by taking average of each activity for each subject.This resulted in a dataset whose dimension was 180* 68.

*_Note:_*

Code in the run_analysis.R function is thoroughly commented that describes each step in detail.