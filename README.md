# 🏥 Hospital Readmission Analytics Framework
An end-to-end clinical data engineering and statistical modeling pipeline built across **SQL**, **Python**, and **R** to identify risk drivers behind 30-day patient readmissions.

## 🎯 Executive Summary & Business Objective
Hospital readmissions within 30 days of discharge are a critical metric for healthcare operational efficiency and patient care quality. High readmission rates often signal premature discharges or gaps in follow-up care, leading to severe financial penalties for hospital systems.

**Objective:** Build a multi-tier analytical system to ingest historical patient cohort data, isolate core clinical risk factors (such as medication loads and admission entry paths), and provide data-driven insights to help hospital administration reduce readmission rates.

---

## 🛠️ Tech Stack & Technical Architecture
To replicate an enterprise analytics environment, the project is structured across three specialized layers:

| Layer / File | Technology | Core Analytical Purpose |
| :--- | :--- | :--- |
| **Data Engineering** (`analysis_queries.sql`) | **SQL** | Handles relational aggregations, cohorts, conditional risk-tier segmentation, and operational profiling. |
| **Statistical Pipeline** (`analysis_pipeline.py`) | **Python (Pandas, NumPy)** | Executes data ingestion pipelines, baseline metric profiling, and computes numeric feature correlation matrixes. |
| **Biostatistical Profile** (`analytical_profile.R`) | **R (tidyverse/dplyr)** | Explores biostatistical data distribution patterns and processes operational breakdowns across entry paths. |

---

## 📂 Repository Structure
```text
hospital-readmission-analytics/
├── hospital_readmissions.csv     # Target patient cohort dataset
├── analysis_queries.sql          # Production SQL data aggregations
├── analysis_pipeline.py          # Python statistical & correlation pipeline
├── analytical_profile.R          # R biostatistical entry path profile
└── README.md                     # Portfolio case study and documentation
```

---

## 📊 Core Insights & Analytical Methodology

### 1. Data Engineering Layer (SQL)
The SQL infrastructure segments patients into logical age categories to evaluate clinical risk variance. It reveals that the **Critical Geriatric Cohort (Over 70)** experiences both the highest medication loads and the sharpest readmission rates, demanding targeted transitional care management. 

### 2. Statistical Pipeline (Python)
The Python framework computes a complete Pearson correlation matrix against the target readmission state. The pipeline uncovers that `Length_of_Stay` and `Medication_Count` maintain the strongest positive correlations with 30-day readmissions, highlighting that prolonged initial hospitalizations often act as primary indicators for post-discharge complications.

### 3. Entry Path Exploration (R)
Leveraging functional vector transformations, the R runtime evaluates patient outcomes categorized by their initial admission portal. The summary outputs clearly demonstrate that **Emergency Admissions** yield substantially higher readmission rates and elevated laboratory procedure workloads compared to scheduled Elective procedures.

---

## 🚀 How to Run the Scripts Locally

### Prerequisites
Ensure you have Python 3.x and R installed on your system. 

### Running the Python Pipeline
1. Clone this repository or download the files into the same folder.
2. Install dependencies: `pip install pandas numpy`
3. Execute the script: `python analysis_pipeline.py`

### Running the R Profiler
1. Open the project directory in RStudio or your terminal.
2. Run the script: `Rscript analytical_profile.R` (It will automatically verify and load `tidyverse` if missing).
