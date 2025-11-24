# Policy Evaluation Assignment 7: Instrumental Variables and Regression Discontinuity

## Overview
This folder contains all materials required for Assignment 7. It includes:
- **PDF report** with analytical answers and all required figures/tables
- **Stata do-files** used for replication of figures and tables
- **Dataset** (`assignment7.dta`) required to run the code

## Folder Structure
```
assignment7_folder/
├── EconometricsHW7.pdf
├── assignment7_q1.do
├── assignment7_q2.do
├── assignment7_q3.do
├── assignment7.dta
└── README.md
```

## Team Members
Joshua Castillo,
Nikoloz Darsalia, 
Corneel Moons 

## Questions Covered
- **Question 1**: Replication of Figures 4 and 6 from Oreopoulos (2006)
- **Question 2**: Replication of Table 1 for Great Britain
- **Question 3**: RD-IV Estimation (Table 2 for Great Britain)

---

## Question 1: Replication of Figures 4 and 6

### Requirements
- Stata 17 or later
- Dataset: `assignment7.dta`

### How to Run the Code
1. Open Stata
2. Set the working directory to the project folder
3. Run the do-file: `assignment7_q1.do`

The script will automatically:
- Load the dataset `assignment7.dta`
- Filter data for Great Britain only (`nireland == 0`)
- Collapse data to calculate mean education attainment and earnings by year aged 14
- Estimate quartic polynomial fits with post-1947 indicators
- Generate **Figure 4**: Average age left full-time education by year aged 14
- Generate **Figure 6**: Average log annual earnings by year aged 14
- Save figures as `figure4.png` and `figure6.png`

### Expected Output
- `figure4.png`: Shows clear discontinuity in education attainment at 1947
- `figure6.png`: Shows corresponding discontinuity in log earnings at 1947

### Notes
- The code uses probability weights (`wght`) for accurate population estimates
- Figures show both local averages (scatter points) and polynomial fits (lines)
- The vertical line at 1947 indicates when the minimum school-leaving age increased from 14 to 15
- Ensure that `assignment7.dta` is located in the same folder as the do-file

---

## Question 2: Replication of Table 1

## Question 3: RD-IV Estimation (Table 2)

