## README

The dataset includes the following files:
=========================================

- 'README.md' : this file

- 'run_analysis.R': R script for Getting and Cleaning Data Course Project

- 'run.txt': tidy dataset generated after R script


How to execute R script in run_analysis.R:
==========================================

Step1.  It uses dplyr package. s
> library(dplyr)

Stpe2. load the source code
> source("run_analysis.R")

Step3. just call a 'do_all()' function. it returns tidy data for instruction 5.
> df_tidydata <- do_all()

Step4. You can check the new dataset.
> dim(df_tidydata)
[1] 180  68







