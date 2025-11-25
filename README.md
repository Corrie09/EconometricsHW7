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
├── assignment7_q3.ipynb
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

### Requirements

- Python 3.9 or later
- Required packages:
  - `pandas>=2.3.3`
  - `numpy>=2.3.5`
  - `linearmodels>=7.0`
  - `statsmodels>=0.14.5`

Alternatively, run `uv sync` to install dependencies.

### Dataset

`assignment7.dta`

### How to Run the Code

1. Open `assignment7_q3.ipynb` Jupyter Notebook file
2. Ensure the dataset and Notebook file are in the same folder

### What the Script Does

#### 1. Loads the Dataset
Reads `assignment7.dta` using `pandas.read_stata`

#### 2. Restricts the Sample
Filters data to:
- Great Britain only (`nireland == 0`)
- Ages 25–64
- Birth cohorts aged 14 in years 1935–1965

#### 3. Drops Missing Observations
Removes observations with missing:
- log earnings (`learn`)
- age left full-time education (`agelfted`)
- instrument (`drop15`)

#### 4. Constructs the RD Specification

The code generates:

**Cohort polynomial (quartic) centered at the mean:**
- `cc`, `cc2`, `cc3`, `cc4`

**Age polynomial or age dummies depending on the Table 2 column:**
- **Column (4):** no age controls
- **Column (5):** quartic age polynomial
- **Column (6):** full set of age dummies

These match the structure of Table 2 in Oreopoulos (2006).

#### 5. Runs IV Regressions (2SLS)

Each regression estimates:

```
learn = β · agelfted + f(cohort) + controls
```

Where:
- **Endogenous regressor:** `agelfted`
- **Instrument:** `drop15` (indicator for exposure to the post-1947 reform)
- **Weights:** probability weights `wght`
- **Clustered standard errors:** clustered at the cohort level

The script uses `from linearmodels.iv import IV2SLS` to estimate the 2SLS regressions with cluster-robust inference.

#### 6. Produces Outputs for Table 2

The script prints three model summaries:

##### Table 2, Column (4):
- Quartic cohort controls
- No age controls

##### Table 2, Column (5):
- Quartic cohort controls
- Quartic age controls

##### Table 2, Column (6):
- Quartic cohort controls
- Full set of age dummies

Each output includes:
- Coefficient estimates
- Standard errors (clustered)
- t-statistics, p-values
- Number of clusters
- First-stage summary

This mirrors the structure of the published table.