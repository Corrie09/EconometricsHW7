// * Load data -- make sure your directory is set at the place where your data is
// use "assignment7.dta", clear
//
// * Keep Great Britain only
// keep if nireland == 0
//
// * Create birth cohort variable
// gen cohort = yobirth
//
// * Weight = survey-provided
// svyset cohort, weight(wght)
//
// * First-stage regression (col 1)
// reg agelfted drop15 c.yobirth##c.yobirth##c.yobirth##c.yobirth [pweight=wght], cluster(cohort)
//
// * First-stage with age polynomial (col 2)
// reg agelfted drop15 c.yobirth##c.yobirth##c.yobirth##c.yobirth ///
//     c.age##c.age##c.age##c.age [pweight=wght], cluster(cohort)
//
// * First-stage with age FE (col 3)
// reg agelfted drop15 c.yobirth##c.yobirth##c.yobirth##c.yobirth ///
//     i.age [pweight=wght], cluster(cohort)
//
// * Reduced form: log earnings (col 4)
// reg learn drop15 c.yobirth##c.yobirth##c.yobirth##c.yobirth [pweight=wght], cluster(cohort)
//
// * Reduced form with age polynomial (col 5)
// reg learn drop15 c.yobirth##c.yobirth##c.yobirth##c.yobirth ///
//     c.age##c.age##c.age##c.age [pweight=wght], cluster(cohort)
//
// * Reduced form with age FE (col 6)
// reg learn drop15 c.yobirth##c.yobirth##c.yobirth##c.yobirth ///
//     i.age [pweight=wght], cluster(cohort)
//



******************************************************
*  Replication: Table 1 — Oreopoulos (2006)
*  Great Britain Only
*  Using working regression syntax
******************************************************

clear all
set more off

*-----------------------------------------------------
* 1. Load data
*-----------------------------------------------------
use "assignment7.dta", clear

*-----------------------------------------------------
* 2. Restrict to Great Britain only
*-----------------------------------------------------
keep if nireland == 0

*-----------------------------------------------------
* 3. Create birth cohort variable
*-----------------------------------------------------
gen cohort = yobirth

*-----------------------------------------------------
* 4. Install estout if needed
*-----------------------------------------------------
capture which esttab
if _rc {
    ssc install estout, replace
}

*-----------------------------------------------------
* 5. Run regressions and store them
*-----------------------------------------------------
eststo clear

*--- Column 1: First stage, YOB quartic ---*
eststo col1: reg agelfted drop15 c.yobirth##c.yobirth##c.yobirth##c.yobirth ///
    [pweight=wght], cluster(cohort)

*--- Column 2: First stage + age quartic ---*
eststo col2: reg agelfted drop15 c.yobirth##c.yobirth##c.yobirth##c.yobirth ///
    c.age##c.age##c.age##c.age [pweight=wght], cluster(cohort)

*--- Column 3: First stage + age FE ---*
eststo col3: reg agelfted drop15 c.yobirth##c.yobirth##c.yobirth##c.yobirth ///
    i.age [pweight=wght], cluster(cohort)

*--- Column 4: Reduced form, YOB quartic ---*
eststo col4: reg learn drop15 c.yobirth##c.yobirth##c.yobirth##c.yobirth ///
    [pweight=wght], cluster(cohort)

*--- Column 5: Reduced form + age quartic ---*
eststo col5: reg learn drop15 c.yobirth##c.yobirth##c.yobirth##c.yobirth ///
    c.age##c.age##c.age##c.age [pweight=wght], cluster(cohort)

*--- Column 6: Reduced form + age FE ---*
eststo col6: reg learn drop15 c.yobirth##c.yobirth##c.yobirth##c.yobirth ///
    i.age [pweight=wght], cluster(cohort)

*-----------------------------------------------------
* 6. Export Table 1 (text format)
*-----------------------------------------------------
esttab col1 col2 col3 col4 col5 col6 using table1.txt, ///
    se star(* 0.10 ** 0.05 *** 0.01) ///
    replace label ///
    b(3) se(3) ///
    keep(drop15) ///
    title("Table 1. Effect of Compulsory Schooling Laws (Great Britain)") ///
    mtitles("FS: YOB poly" ///
            "FS: +Age poly" ///
            "FS: Age FE"  ///
            "RF: YOB poly" ///
            "RF: +Age poly" ///
            "RF: Age FE")

*-----------------------------------------------------
* 7. Export Table 1 (LaTeX format)
*-----------------------------------------------------
esttab col1 col2 col3 col4 col5 col6 using table1.tex, ///
    se star(* 0.10 ** 0.05 *** 0.01) ///
    replace label ///
    b(3) se(3) ///
    keep(drop15) ///
    title("Table 1. Effect of Compulsory Schooling Laws (Great Britain)") ///
    mtitles("FS: YOB poly" ///
            "FS: +Age poly" ///
            "FS: Age FE"  ///
            "RF: YOB poly" ///
            "RF: +Age poly" ///
            "RF: Age FE")

display "-------------------------------------------"
display " Table 1 saved to table1.txt and table1.tex"
display "-------------------------------------------"




******************************************************
*  Replication: Table 1 — Oreopoulos (2006)
*  Great Britain Only
*  Using working regression syntax with mean-centering
******************************************************

clear all
set more off

*-----------------------------------------------------
* 1. Load data
*-----------------------------------------------------
use "assignment7.dta", clear

*-----------------------------------------------------
* 2. Restrict to Great Britain only
*-----------------------------------------------------
keep if nireland == 0

*-----------------------------------------------------
* 3. Create birth cohort variable
*-----------------------------------------------------
gen cohort = yobirth

*-----------------------------------------------------
* 4. Compute mean-centered variables
*-----------------------------------------------------
sum yobirth
local mean_yob = r(mean)
gen yob_c = yobirth - `mean_yob'

sum age
local mean_age = r(mean)
gen age_c = age - `mean_age'

*-----------------------------------------------------
* 5. Install estout if needed
*-----------------------------------------------------
capture which esttab
if _rc {
    ssc install estout, replace
}

*-----------------------------------------------------
* 6. Run regressions and store them
*-----------------------------------------------------
eststo clear

*--- Column 1: First stage, YOB quartic ---*
eststo col1: reg agelfted drop15 c.yob_c##c.yob_c##c.yob_c##c.yob_c ///
    [pweight=wght], cluster(cohort)

*--- Column 2: First stage + age quartic ---*
eststo col2: reg agelfted drop15 c.yob_c##c.yob_c##c.yob_c##c.yob_c ///
    c.age_c##c.age_c##c.age_c##c.age_c [pweight=wght], cluster(cohort)

*--- Column 3: First stage + age FE ---*
eststo col3: reg agelfted drop15 c.yob_c##c.yob_c##c.yob_c##c.yob_c ///
    i.age [pweight=wght], cluster(cohort)

*--- Column 4: Reduced form, YOB quartic ---*
eststo col4: reg learn drop15 c.yob_c##c.yob_c##c.yob_c##c.yob_c ///
    [pweight=wght], cluster(cohort)

*--- Column 5: Reduced form + age quartic ---*
eststo col5: reg learn drop15 c.yob_c##c.yob_c##c.yob_c##c.yob_c ///
    c.age_c##c.age_c##c.age_c##c.age_c [pweight=wght], cluster(cohort)

*--- Column 6: Reduced form + age FE ---*
eststo col6: reg learn drop15 c.yob_c##c.yob_c##c.yob_c##c.yob_c ///
    i.age [pweight=wght], cluster(cohort)

*-----------------------------------------------------
* 7. Export Table 1 (text format)
*-----------------------------------------------------
esttab col1 col2 col3 col4 col5 col6 using table1_centered.txt, ///
    se star(* 0.10 ** 0.05 *** 0.01) ///
    replace label ///
    b(3) se(3) ///
    keep(drop15) ///
    title("Table 1. Effect of Compulsory Schooling Laws (Great Britain, Mean-Centered)") ///
    mtitles("FS: YOB poly" ///
            "FS: +Age poly" ///
            "FS: Age FE"  ///
            "RF: YOB poly" ///
            "RF: +Age poly" ///
            "RF: Age FE")

*-----------------------------------------------------
* 8. Export Table 1 (LaTeX format)
*-----------------------------------------------------
esttab col1 col2 col3 col4 col5 col6 using table1_centered.tex, ///
    se star(* 0.10 ** 0.05 *** 0.01) ///
    replace label ///
    b(3) se(3) ///
    keep(drop15) ///
    title("Table 1. Effect of Compulsory Schooling Laws (Great Britain, Mean-Centered)") ///
    mtitles("FS: YOB poly" ///
            "FS: +Age poly" ///
            "FS: Age FE"  ///
            "RF: YOB poly" ///
            "RF: +Age poly" ///
            "RF: Age FE")

display "-------------------------------------------"
display " Table 1 (mean-centered) saved to table1_centered.txt and table1_centered.tex"
display "-------------------------------------------"

