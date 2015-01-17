 ## Features
 ### Signals
 -tBodyAcc-XYZ
 -tGravityAcc-XYZ
 -tBodyAccJerk-XYZ
 -tBodyGyro-XYZ
 -tBodyGyroJerk-XYZ
 -tBodyAccMag
 -tGravityAccMag
 -tBodyAccJerkMag
 -tBodyGyroMag
 -tBodyGyroJerkMag
 -fBodyAcc-XYZ
 -fBodyAccJerk-XYZ
 -fBodyGyro-XYZ
 -fBodyAccMag
 -fBodyAccJerkMag
 -fBodyGyroMag
 -fBodyGyroJerkMag
 ### Estimations chosen
 -mean: Mean value
 -std: Standard deviation
 ### Vatiable calculation
 For each activity label and each subject, the mean values of the above estimations of the signals are calculated.
 ## Variables in the tidy data frame
 - label                    : factor w/ 6 levels. Activity labels. Numbers in the original data are substituted by its corresponding descriptive names as listed below. 
      1 WALKING
      2 WALKING_UPSTAIRS
      3 WALKING_DOWNSTAIRS
      4 SITTING
      5 STANDING
      6 LAYING
 - subject                  : num. Subject ID. Ranging from 1 to 30.
 - tBodyAcc.mean.X          : num. Average mean of body acceleration in the X direction.
 - tBodyAcc.mean.Y          : num. Average mean of body acceleration in the Y direction.
 - tBodyAcc.mean.Z          : num. Average mean of body acceleration in the Z direction.
 - tBodyAcc.std.X           : num. Average std of body acceleration in the X direction.
 - tBodyAcc.std.Y           : num. Average std of body acceleration in the Y direction.
 - tBodyAcc.std.Z           : num. Average std of body acceleration in the Z direction.
 - tGravityAcc.mean.X       : num. Average mean of gravity acceleration in the X direction.
 - tGravityAcc.mean.Y       : num. Average mean of gravity acceleration in the Y direction.
 - tGravityAcc.mean.Z       : num. Average mean of gravity acceleration in the Z direction.
 - tGravityAcc.std.X        : num. Average std of gravity acceleration in the X direction.
 - tGravityAcc.std.Y        : num. Average std of gravity acceleration in the Y direction.
 - tGravityAcc.std.Z        : num. Average std of gravity acceleration in the Z direction.
 - tBodyAccJerk.mean.X      : num. Average mean of body linear acceleration for Jerk signals in the X direction.
 - tBodyAccJerk.mean.Y      : num. Average mean of body linear acceleration for Jerk signals in the Y direction.
 - tBodyAccJerk.mean.Z      : num. Average mean of body linear acceleration for Jerk signals in the Z direction.
 - tBodyAccJerk.std.X       : num. Average std of body linear acceleration for Jerk signals in the X direction.
 - tBodyAccJerk.std.Y       : num. Average std of body linear acceleration for Jerk signals in the Y direction.
 - tBodyAccJerk.std.Z       : num. Average std of body linear acceleration for Jerk signals in the Z direction.
 - tBodyGyro.mean.X         : num. Average mean of body angular velocity in the X direction.
 - tBodyGyro.mean.Y         : num. Average mean of body angular velocity in the Y direction.
 - tBodyGyro.mean.Z         : num. Average mean of body angular velocity in the Z direction.
 - tBodyGyro.std.X          : num. Average std of body angular velocity in the X direction.
 - tBodyGyro.std.Y          : num. Average std of body angular velocity in the Y direction.
 - tBodyGyro.std.Z          : num. Average std of body angular velocity in the Z direction.
 - tBodyGyroJerk.mean.X     : num. Average mean of body angular velocity for Jerk signals in the X direction.
 - tBodyGyroJerk.mean.Y     : num. Average mean of body angular velocity for Jerk signals in the Y direction.
 - tBodyGyroJerk.mean.Z     : num. Average mean of body angular velocity for Jerk signals in the Z direction.
 - tBodyGyroJerk.std.X      : num. Average std of body angular velocity for Jerk signals in the X direction.
 - tBodyGyroJerk.std.Y      : num. Average std of body angular velocity for Jerk signals in the Y direction.
 - tBodyGyroJerk.std.Z      : num. Average std of body angular velocity for Jerk signals in the Z direction.
 - tBodyAccMag.mean         : num. Average mean of body linear acceleration magnitude.
 - tBodyAccMag.std          : num. Average std of body linear acceleration magnitude.
 - tGravityAccMag.mean      : num. Average mean of gravity acceleration magnitude.
 - tGravityAccMag.std       : num. Average std of gravity acceleration magnitude.
 - tBodyAccJerkMag.mean     : num. Average mean of body linear acceleration magnitude for Jerk signals.
 - tBodyAccJerkMag.std      : num. Average std of body linear acceleration magnitude for Jerk signals.
 - tBodyGyroMag.mean        : num. Average mean of body angular velocity magnitude.
 - tBodyGyroMag.std         : num. Average std of body angular velocity magnitude.
 - tBodyGyroJerkMag.mean    : num. Average mean of body angular velocity magnitude for Jerk signals.
 - tBodyGyroJerkMag.std     : num. Average std of body angular velocity magnitude for Jerk signals.
 - fBodyAcc.mean.X          : num. Average mean of FFT transformed body acceleration in the X direction.
 - fBodyAcc.mean.Y          : num. Average mean of FFT transformed body acceleration in the Y direction.
 - fBodyAcc.mean.Z          : num. Average mean of FFT transformed body acceleration in the Z direction.
 - fBodyAcc.std.X           : num. Average std of FFT transformed body acceleration in the X direction.
 - fBodyAcc.std.Y           : num. Average std of FFT transformed body acceleration in the Y direction.
 - fBodyAcc.std.Z           : num. Average std of FFT transformed body acceleration in the Z direction.
 - fBodyAccJerk.mean.X      : num. Average mean of FFT transformed body acceleration for Jerk signals in the X direction.
 - fBodyAccJerk.mean.Y      : num. Average mean of FFT transformed body acceleration for Jerk signals in the Y direction.
 - fBodyAccJerk.mean.Z      : num. Average mean of FFT transformed body acceleration for Jerk signals in the Z direction.
 - fBodyAccJerk.std.X       : num. Average std of FFT transformed body acceleration for Jerk signals in the X direction.
 - fBodyAccJerk.std.Y       : num. Average std of FFT transformed body acceleration for Jerk signals in the Y direction.
 - fBodyAccJerk.std.Z       : num. Average std of FFT transformed body acceleration for Jerk signals in the Z direction.
 - fBodyGyro.mean.X         : num. Average mean of FFT transformed body angular velocity in the X direction.
 - fBodyGyro.mean.Y         : num. Average mean of FFT transformed body angular velocity in the Y direction.
 - fBodyGyro.mean.Z         : num. Average mean of FFT transformed body angular velocity in the Z direction.
 - fBodyGyro.std.X          : num. Average std of FFT transformed body angular velocity in the X direction.
 - fBodyGyro.std.Y          : num. Average std of FFT transformed body angular velocity in the Y direction.
 - fBodyGyro.std.Z          : num. Average std of FFT transformed body angular velocity in the Z direction.
 - fBodyAccMag.mean         : num. Average mean of FFT transformed body linear acceleration magnitude.
 - fBodyAccMag.std          : num. Average std of FFT transformed body linear acceleration magnitude.
 - fBodyBodyAccJerkMag.mean : num. Average mean of FFT transformed body linear acceleration magnitude for Jerk signals.
 - fBodyBodyAccJerkMag.std  : num. Average std of FFT transformed body linear acceleration magnitude for Jerk signals.
 - fBodyBodyGyroMag.mean    : num. Average mean of FFT transformed body angular velociy magnitude.
 - fBodyBodyGyroMag.std     : num. Average std of FFT transformed body angular velociy magnitude.
 - fBodyBodyGyroJerkMag.mean: num. Average mean of FFT transformed body angular velociy magnitude for Jerk signals.
 - fBodyBodyGyroJerkMag.std : num. Average std of FFT transformed body angular velociy magnitude for Jerk signals.
