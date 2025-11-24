* Load the data    <-- make sure you're directory is set at the place where youre data is
use "assignment7.dta", clear  

tab yearat14
summarize agelfted learn

* Figure 4
preserve
keep if nireland == 0

collapse (mean) agelfted [pw=wght], by(yearat14)

gen yearat14_sq = yearat14^2
gen yearat14_3 = yearat14^3
gen yearat14_4 = yearat14^4

gen post1947 = (yearat14 >= 47)

reg agelfted yearat14 yearat14_sq yearat14_3 yearat14_4 post1947

predict agelfted_fit

twoway (scatter agelfted yearat14, mcolor(black) msize(medium)) ///
       (line agelfted_fit yearat14, lcolor(black) lwidth(medium)), ///
       xline(47, lpattern(solid) lcolor(black)) ///
       xlabel(35(5)65) ylabel(14(1)17) ///
       xtitle("Year Aged 14") ytitle("Avg. Age Left Full-Time Education") ///
       legend(order(1 "Local Average" 2 "Polynomial Fit")) ///
       title("Figure 4: Average Age Left Full-Time Education by Year Aged 14" "(Great Britain)")

graph export "figure4.png", replace

restore

* Figure 6
use "assignment7.dta", clear
keep if nireland == 0 & !missing(learn)

collapse (mean) learn [pw=wght], by(yearat14)

gen yearat14_sq = yearat14^2
gen yearat14_3 = yearat14^3
gen yearat14_4 = yearat14^4

gen post1947 = (yearat14 >= 47)

reg learn yearat14 yearat14_sq yearat14_3 yearat14_4 post1947

predict learn_fit

twoway (scatter learn yearat14, mcolor(black) msize(medium)) ///
       (line learn_fit yearat14, lcolor(black) lwidth(medium)), ///
       xline(47, lpattern(solid) lcolor(black)) ///
       xlabel(35(5)65) ylabel(8.6(.2)9.4) ///
       xtitle("Year Aged 14") ///
       ytitle("Log of Annual Earnings (1998 UK Pounds)") ///
       legend(order(1 "Local Average" 2 "Polynomial Fit")) ///
       title("Figure 6: Average Annual Log Earnings by Year Aged 14" "(Great Britain)")

graph export "figure6.png"