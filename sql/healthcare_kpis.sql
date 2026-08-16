/* ============================================================
   Healthcare Analytics Dashboard — SQL KPI Queries
   Table: healthcare_cleaned  (from data/cleaned/healthcare_dataset_cleaned.csv)
   Compatible with: PostgreSQL / MySQL / SQLite (minor syntax tweaks noted)
   ============================================================ */

-- --------------------------------------------------------------
-- 0. TABLE CREATION (adjust types per your RDBMS)
-- --------------------------------------------------------------
CREATE TABLE IF NOT EXISTS healthcare_cleaned (
    name                VARCHAR(100),
    age                 INT,
    gender              VARCHAR(10),
    blood_type          VARCHAR(5),
    medical_condition   VARCHAR(50),
    date_of_admission   DATE,
    doctor              VARCHAR(100),
    hospital            VARCHAR(150),
    insurance_provider  VARCHAR(50),
    billing_amount      DECIMAL(12,2),
    room_number         INT,
    admission_type      VARCHAR(20),
    discharge_date      DATE,
    medication          VARCHAR(50),
    test_results        VARCHAR(20),
    length_of_stay_days INT,
    admission_year      INT,
    admission_month     INT,
    admission_month_name VARCHAR(10),
    age_group           VARCHAR(10)
);

-- Load data (example for PostgreSQL; use LOAD DATA INFILE for MySQL,
-- or .import for SQLite)
-- COPY healthcare_cleaned FROM 'healthcare_dataset_cleaned.csv' DELIMITER ',' CSV HEADER;


-- --------------------------------------------------------------
-- 1. TOP-LINE KPIs
-- --------------------------------------------------------------
SELECT
    COUNT(*)                           AS total_patients,
    ROUND(SUM(billing_amount), 2)      AS total_revenue,
    ROUND(AVG(billing_amount), 2)      AS avg_billing_per_patient,
    ROUND(AVG(length_of_stay_days), 2) AS avg_length_of_stay,
    COUNT(DISTINCT hospital)           AS total_hospitals,
    COUNT(DISTINCT doctor)             AS total_doctors
FROM healthcare_cleaned;


-- --------------------------------------------------------------
-- 2. PATIENTS & BILLING BY MEDICAL CONDITION
-- --------------------------------------------------------------
SELECT
    medical_condition,
    COUNT(*)                            AS patient_count,
    ROUND(AVG(billing_amount), 2)       AS avg_billing,
    ROUND(SUM(billing_amount), 2)       AS total_billing,
    ROUND(AVG(length_of_stay_days), 2)  AS avg_length_of_stay
FROM healthcare_cleaned
GROUP BY medical_condition
ORDER BY patient_count DESC;


-- --------------------------------------------------------------
-- 3. ADMISSION TYPE DISTRIBUTION
-- --------------------------------------------------------------
SELECT
    admission_type,
    COUNT(*) AS patient_count,
    ROUND(100.0 * COUNT(*) / (SELECT COUNT(*) FROM healthcare_cleaned), 2) AS pct_of_total
FROM healthcare_cleaned
GROUP BY admission_type
ORDER BY patient_count DESC;


-- --------------------------------------------------------------
-- 4. REVENUE BY INSURANCE PROVIDER
-- --------------------------------------------------------------
SELECT
    insurance_provider,
    COUNT(*)                      AS patient_count,
    ROUND(SUM(billing_amount), 2) AS total_revenue,
    ROUND(AVG(billing_amount), 2) AS avg_billing_per_patient
FROM healthcare_cleaned
GROUP BY insurance_provider
ORDER BY total_revenue DESC;


-- --------------------------------------------------------------
-- 5. PATIENT DEMOGRAPHICS (AGE GROUP x GENDER)
-- --------------------------------------------------------------
SELECT
    age_group,
    gender,
    COUNT(*) AS patient_count
FROM healthcare_cleaned
GROUP BY age_group, gender
ORDER BY age_group, gender;


-- --------------------------------------------------------------
-- 6. YEARLY ADMISSIONS & REVENUE TREND
-- --------------------------------------------------------------
SELECT
    admission_year,
    COUNT(*)                      AS patient_count,
    ROUND(SUM(billing_amount), 2) AS total_revenue
FROM healthcare_cleaned
GROUP BY admission_year
ORDER BY admission_year;


-- --------------------------------------------------------------
-- 7. MONTHLY TREND (for time-series chart in dashboard)
-- --------------------------------------------------------------
SELECT
    admission_year,
    admission_month,
    admission_month_name,
    COUNT(*)                      AS patient_count,
    ROUND(SUM(billing_amount), 2) AS total_revenue
FROM healthcare_cleaned
GROUP BY admission_year, admission_month, admission_month_name
ORDER BY admission_year, admission_month;


-- --------------------------------------------------------------
-- 8. LENGTH OF STAY OUTLIERS (long-stay patients, > 25 days)
--    Useful for a "flagged patients" table in the dashboard
-- --------------------------------------------------------------
SELECT
    name,
    medical_condition,
    hospital,
    doctor,
    length_of_stay_days,
    billing_amount
FROM healthcare_cleaned
WHERE length_of_stay_days > 25
ORDER BY length_of_stay_days DESC;


-- --------------------------------------------------------------
-- 9. TOP 10 DOCTORS BY PATIENT VOLUME
-- --------------------------------------------------------------
SELECT
    doctor,
    COUNT(*) AS patients_treated,
    ROUND(AVG(billing_amount), 2) AS avg_billing
FROM healthcare_cleaned
GROUP BY doctor
ORDER BY patients_treated DESC
LIMIT 10;


-- --------------------------------------------------------------
-- 10. TEST RESULTS BREAKDOWN BY MEDICAL CONDITION
-- --------------------------------------------------------------
SELECT
    medical_condition,
    test_results,
    COUNT(*) AS patient_count
FROM healthcare_cleaned
GROUP BY medical_condition, test_results
ORDER BY medical_condition, test_results;
