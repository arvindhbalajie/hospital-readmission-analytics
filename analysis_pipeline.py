import pandas as pd
import numpy as np

def run_analysis_pipeline(file_path="hospital_readmissions.csv"):
    print("🚀 Initializing Healthcare Data Analysis Pipeline...\n")
    
    # 1. Load Dataset
    try:
        df = pd.read_csv(file_path)
        print(f"✅ Data loaded successfully. Shape: {df.shape[0]} rows, {df.shape[1]} columns.\n")
    except FileNotFoundError:
        print(f"❌ Error: Could not find '{file_path}'. Make sure it's in the same folder.")
        return

    # 2. Basic Data Profiling & Cleaning
    # Check for missing values
    missing_vals = df.isnull().sum().sum()
    print(f"🔹 Total missing values detected: {missing_vals}")
    
    # Standardize column strings to avoid casing issues
    if 'Readmitted' in df.columns:
        df['Readmitted'] = df['Readmitted'].astype(str).str.strip().str.upper()
        # Convert to binary numeric (1 for YES, 0 for NO) for statistical tracking
        df['Readmitted_Numeric'] = np.where(df['Readmitted'] == 'YES', 1, 0)

    # 3. Exploratory Data Metrics
    print("\n📊 --- Baseline Clinical Metrics ---")
    
    # Calculate overall readmission rate
    if 'Readmitted_Numeric' in df.columns:
        readmit_rate = df['Readmitted_Numeric'].mean() * 100
        print(f"Overall 30-Day Readmission Rate: {readmit_rate:.2f}%")
        
    # Average Length of Stay and Medication Count
    avg_stay = df['Length_of_Stay'].mean() if 'Length_of_Stay' in df.columns else "N/A"
    avg_meds = df['Medication_Count'].mean() if 'Medication_Count' in df.columns else "N/A"
    print(f"Average Length of Stay: {avg_stay:.1f} days")
    print(f"Average Number of Medications Prescribed: {avg_meds:.1f}")

    # 4. Statistical Correlation Matrix
    print("\n🔢 --- Feature Correlation with Readmission ---")
    numeric_cols = df.select_dtypes(include=[np.number])
    if 'Readmitted_Numeric' in numeric_cols.columns:
        correlations = numeric_cols.corr()['Readmitted_Numeric'].sort_values(ascending=False)
        print("Correlation coefficients relative to Readmission Status:")
        print(correlations.drop('Readmitted_Numeric'))
    else:
        print("Skipping correlation: Binary target translation failed.")

    print("\n✅ Pipeline execution complete. Ready for visualization mapping.")

if __name__ == "__main__":
    run_analysis_pipeline()
