# 🏥 Healthcare Analytics Dashboard

**Data Analytics Internship — Capstone Project**
**Author:** Meghana H Huvanur
**Organization:** Kinetrexa Software Private Limited

## Overview

An end-to-end analytics project analyzing 54,966 hospital patient records to uncover operational and financial insights — patient demographics, medical conditions, admission patterns, length of stay, and billing/insurance trends — presented through an interactive Power BI dashboard.

> **Dataset note:** This project uses a publicly available *synthetic* healthcare dataset (patient, doctor, hospital, billing, and admission records). Field values are randomly generated for privacy-safe practice, so relationships between variables should be read as a demonstration of analytical methodology rather than real clinical findings.

## 🎯 Objectives

- Clean and preprocess raw patient records
- Engineer KPIs: length of stay, age groups, admission trends
- Perform SQL-based and Python-based exploratory analysis
- Build an interactive Power BI dashboard for hospital stakeholders
- Communicate findings through a business insights report

## 🗂️ Repository Structure

```
healthcare-analytics-dashboard/
├── data/
│   ├── raw/healthcare_dataset_raw.csv          # Original dataset
│   └── cleaned/healthcare_dataset_cleaned.csv  # Cleaned, feature-engineered dataset
├── notebooks/
│   └── Healthcare_Analytics_Dashboard.ipynb    # Full EDA + KPI analysis (executed, with charts)
├── sql/
│   └── healthcare_kpis.sql                     # KPI queries (schema + 10 analysis queries)
├── reports/
│   ├── Business_Insights_Report.pdf            # Executive summary + recommendations
│   └── charts/                                 # Chart images used in the report
└── README.md
```

## 🧹 Data Cleaning

- Removed 534 duplicate records
- Standardized name/doctor/hospital text casing
- Parsed admission & discharge dates
- Engineered: `Length of Stay`, `Age Group`, `Admission Year/Month`
- Validated no missing or negative values

## 📊 Key KPIs

| Metric | Value |
|---|---|
| Total Patients | 54,966 |
| Total Billing Revenue | $1.40B |
| Avg. Billing per Patient | $25,544 |
| Avg. Length of Stay | 15.5 days |
| Hospitals Represented | 39,876 |
| Doctors Represented | 40,341 |

## 🛠️ Tools Used

- **Python** (Pandas, Matplotlib, Seaborn) — data cleaning & EDA
- **SQL** — KPI queries
- **Power BI** — interactive dashboard
- **ReportLab** — PDF business report generation

## 📈 Dashboard

The Power BI dashboard (`.pbix`, linked separately) includes:
- KPI cards (patients, revenue, avg. billing, avg. LOS)
- Patient volume & billing by medical condition
- Admission type breakdown
- Revenue by insurance provider
- Yearly/monthly admission trends
- Age & gender demographics
- Filters: Year, Medical Condition, Admission Type, Insurance Provider

*(Screenshot / live link to be added after publishing the dashboard.)*

## 💡 Key Insights

1. Patient volume is evenly spread across all six tracked medical conditions (~15–17% each).
2. Admission types (Elective/Urgent/Emergency) are nearly balanced (~33% each).
3. Average length of stay is 15.5 days, with meaningful outliers beyond 25 days worth flagging.
4. Insurance providers contribute similar revenue shares ($276M–$284M each).
5. The 65+ age group is the largest patient segment (29%), relevant for geriatric care planning.

Full analysis and recommendations: [`reports/Business_Insights_Report.pdf`](reports/Business_Insights_Report.pdf)

## 🚀 How to Run

```bash
# Clone the repo
git clone <repo-url>
cd healthcare-analytics-dashboard

# Install dependencies
pip install pandas matplotlib seaborn jupyter

# Run the notebook
jupyter notebook notebooks/Healthcare_Analytics_Dashboard.ipynb
```

For SQL: load `data/cleaned/healthcare_dataset_cleaned.csv` into your database and run `sql/healthcare_kpis.sql`.

## 📄 License

Dataset used for educational/portfolio purposes only. Synthetic data — no real patient information.
