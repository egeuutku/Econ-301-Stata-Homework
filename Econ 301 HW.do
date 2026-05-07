clear all
set more off

import excel "Econ301 Homework Dataset (1)", firstrow clear

describe

ssc install estout, replace

summarize y x1 x2 x3 x4 x5 x6

estpost summarize y x1 x2 x3 x4 x5 x6

esttab using "C:\Users\user\Desktop\table1_summary_statistics.rtf", ///
replace ///
cells("count(fmt(0)) mean(fmt(3)) sd(fmt(3)) min(fmt(3)) max(fmt(3))") ///
nomtitle nonumber

correlate y x1 x2 x3 x4 x5 x6

matrix C = r(C)

esttab matrix(C, fmt(3)) using "C:\Users\user\Desktop\table2_correlation_matrix.rtf", ///
replace

eststo clear

eststo M1: regress y x1 x2 x3 x4 x5 x6

esttab M1 using "C:\Users\user\Desktop\table3_full_model.rtf", ///
replace ///
cells("b(fmt(3)) se(fmt(3)) t(fmt(2)) p(fmt(3))") ///
stats(N r2 r2_a F, fmt(0 3 3 2) ///
labels("Observations" "R-squared" "Adjusted R-squared" "F-statistic")) ///
nomtitle nonumber

vif

matrix VIF = (8.72, 0.114670 \ ///
              8.05, 0.124152 \ ///
              5.64, 0.177313 \ ///
              1.09, 0.917692 \ ///
              1.06, 0.942181 \ ///
              1.03, 0.967137 \ ///
              4.27, .)

matrix rownames VIF = x1 x2 x5 x6 x4 x3 Mean_VIF
matrix colnames VIF = VIF Tolerance

esttab matrix(VIF, fmt(3)) using "C:\Users\user\Desktop\table4_vif.rtf", ///
replace

test x4 x5
matrix JointTest = (1.52, 0.2213)

matrix rownames JointTest = B4_equals_B5_equals_0
matrix colnames JointTest = F_statistic p_value

esttab matrix(JointTest, fmt(4)) using "C:\Users\user\Desktop\table5_joint_test.rtf", replace

regress y x1 x2 x3 x6