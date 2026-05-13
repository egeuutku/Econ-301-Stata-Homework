cls
clear all
set more off
import excel "Econ301 Homework Dataset (1)", firstrow clear
describe
summarize y x1 x2 x3 x4 x5 x6
correlate y x1 x2 x3 x4 x5 x6
regress y x1 x2 x3 x4 x5 x6
*Multicollinearity
vif
test x4 x5
regress y x1 x2 x3 x6
vif
*Heteroscedasticity
predict yhat_r
predict ehat_r, resid
scatter ehat_r yhat_r, yline(0) name(g1, replace)
scatter ehat_r x1, yline(0) name(g2, replace)
scatter ehat_r x2, yline(0) name(g3, replace)
scatter ehat_r x3, yline(0) name(g4, replace)
scatter ehat_r x6, yline(0) name(g5, replace)
graph combine g1 g2 g3 g4 g5, cols(2) name(graph1)
hettest
ssc install whitetst, replace
whitetst
*Origin of the Heteroscedasticity
gen ehat2_r = ehat_r^2
scatter ehat2_r x1, name(s1, replace)
scatter ehat2_r x2, name(s2, replace)
scatter ehat2_r x3, name(s3, replace)
scatter ehat2_r x6, name(s4, replace)
graph combine s1 s2 s3 s4, cols(2) name(graph2)
regress ehat2_r x1 x2 x3 x6
*WLS
gen ystar = y / x3
gen x1star = x1 / x3
gen x2star = x2 / x3
gen x6star = x6 / x3
gen constantstar = 1 / x3
gen x3term = 1
regress ystar x1star x2star x6star constantstar x3term, noconstant
predict wyhat
predict wehat, resid
scatter wehat wyhat, yline(0) name(wg1, replace)
graph combine g1 wg1, cols(2) name(graph3, replace)
