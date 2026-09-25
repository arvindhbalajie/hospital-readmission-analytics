-- ====================================================================
-- HEALTHCARE LOGISTICS & READMISSION METRICS
-- Purpose: Aggregations, cohorts, and operational segment profiling.
-- ====================================================================

-- 1. Readmission Rates and Operational Stay Metrics by Primary Diagnosis
SELECT 
    Primary_Diagnosis,
    COUNT(*) AS Total_Patients,
    ROUND(AVG(Length_of_Stay), 2) AS Avg_Days_In_Hospital,
    ROUND(AVG(Medication_Count), 1) AS Avg_Medications_Prescribed,
    SUM(CASE WHEN UPPER(TRIM(Readmitted)) = 'YES' THEN 1 ELSE 0 END) AS Total_Readmissions,
    ROUND(
        (SUM(CASE WHEN UPPER(TRIM(Readmitted)) = 'YES' THEN 1 ELSE 0 END) * 100.0) / COUNT(*), 
        2
    ) AS Readmission_Rate_Percentage
FROM hospital_readmissions
GROUP BY Primary_Diagnosis
ORDER BY Readmission_Rate_Percentage DESC;


-- 2. Demographic Risk Profiling: Age Tiers vs Clinical Complexity
SELECT 
    CASE 
        WHEN Age < 30 THEN 'Under 30 (Low Baseline Risk)'
        WHEN Age BETWEEN 30 AND 50 THEN '30-50 (Moderate Risk)'
        WHEN Age BETWEEN 51 AND 70 THEN '51-70 (High Risk)'
        ELSE 'Over 70 (Critical Geriatric Cohort)'
    END AS Patient_Age_Tier,
    COUNT(*) AS Total_Cohort_Size,
    ROUND(AVG(Num_Lab_Procedures), 2) AS Avg_Laboratory_Procedures,
    ROUND(AVG(Medication_Count), 2) AS Avg_Medication_Load,
    ROUND(
        (SUM(CASE WHEN UPPER(TRIM(Readmitted)) = 'YES' THEN 1 ELSE 0 END) * 100.0) / COUNT(*), 
        2
    ) AS Tier_Readmission_Rate
FROM hospital_readmissions
GROUP BY 
    CASE 
        WHEN Age < 30 THEN 'Under 30 (Low Baseline Risk)'
        WHEN Age BETWEEN 30 AND 50 THEN '30-50 (Moderate Risk)'
        WHEN Age BETWEEN 51 AND 70 THEN '51-70 (High Risk)'
        ELSE 'Over 70 (Critical Geriatric Cohort)'
    END
ORDER BY Tier_Readmission_Rate DESC;
