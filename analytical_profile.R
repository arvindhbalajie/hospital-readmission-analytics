# ====================================================================
# BIOSTATISTICAL READMISSION PROFILE
# Purpose: Deep tidyverse slicing of admission paths and data distribution
# ====================================================================

# Load required analysis packages safely
if (!require("tidyverse", quietly = TRUE)) install.packages("tidyverse")
library(dplyr)

run_biostat_profile <- function(data_path = "hospital_readmissions.csv") {
  message("🏁 Launching R Biostatistical Profile...")
  
  if (!file.exists(data_path)) {
    stop(paste("Could not locate file at:", data_path))
  }
  
  # 1. Ingest clinical data
  patient_data <- read.csv(data_path, stringsAsFactors = FALSE)
  
  # 2. Mutate operational character vectors into clean analytical categories
  refined_data <- patient_data %>%
    mutate(
      Readmitted_Factor = factor(toupper(trimws(Readmitted)), levels = c("NO", "YES")),
      Admission_Type = factor(Admission_Type)
    )
  
  # 3. Profile Readmission Behaviors across Admission Portals (Emergency vs Elective)
  message("\n🏥 --- Operational Breakdown by Admission Entry Path ---")
  admission_summary <- refined_data %>%
    group_by(Admission_Type) %>%
    summarise(
      Total_Admissions = n(),
      Avg_Stay_Duration = round(mean(Length_of_Stay, na.rm = TRUE), 1),
      Avg_Lab_Workload  = round(mean(Num_Lab_Procedures, na.rm = TRUE), 1),
      Readmit_Count     = sum(Readmitted_Factor == "YES", na.rm = TRUE),
      .groups = 'drop'
    ) %>%
    mutate(
      Admission_Path_Readmit_Rate = round((Readmit_Count / Total_Admissions) * 100, 2)
    ) %>%
    arrange(desc(Admission_Path_Readmit_Rate))
  
  print(as.data.frame(admission_summary))
  
  message("\n✅ R script profiling complete.")
}

# Run profile automatically
run_biostat_profile()
