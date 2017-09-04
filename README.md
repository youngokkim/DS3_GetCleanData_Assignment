## README

The dataset includes the following files:
=========================================

- 'README.md' : this file

- 'run_analysis.R': R script for Getting and Cleaning Data Course Project

- 'run.txt': tidy dataset generated after R script


How to execute R script in run_analysis.R:
==========================================

Step1. downloading and unzipping file in working directory.

Step2.  It uses dplyr package. So you shoud load the dplyr package
> library(dplyr)

Stpe3. load the source code
> source("run_analysis.R")

Step4. just call a 'do_all()' function. It writes a tidy data to 'run.txt' file for instruction 5th.
> df_tidydata <- do_all()

Step4. You can check the new dataset.
> dim(df_tidydata)
> [1] 180  68
