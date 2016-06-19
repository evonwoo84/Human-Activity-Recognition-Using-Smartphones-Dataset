
The purpose of this R script(run_analysis.R) is to clean and tidy the training and test data sets collected from experiments on 30 subjects. 
This experiments gather the activities information from smartphone wearable. There are six activities recorded.
70% of the volunteers contribute to the training data whilsts 30% contribute to the test data.

run_analysis.R does the following to produce the clean datasets:
1. Download the data from the url.
2. Read the data from features.txt as column names for the training/test data.
3. Read the data from activity_labels.txt as lookup to activities description.
4. Read training data sets by combining data from 3 files; X_train.txt, y_train.txt, subject_train.txt. Set the column names.
5. Read test data sets by combining data from 3 files; X_test.txt, y_test.txt, subject_test.txt. Set the column names.
6. Merge training and test data sets.
7. Extract the measurements on mean and standard deviation.
8. Replace the activity code to descriptive name by lookup to table from step 3.
9. Generate the final tidy data by computing the mean for each activity and subject.
10. Write the final tidy data from step 9 to a text file.


Variables:
myColNames - table storing column names
myActivityLabel - table storing activity description
myTrainDataSet - training data set
myTrainActivity - training data set corresponding activity
myTrainSubject - training data set corresponding subject
myTestDataSet - test data set
myTestActivity - test data set corresponding activity
myTestSubject - test data set corresponding subject
myMergeDataSet - merged training and test data set 
myMergeDataSet2 - tidy data