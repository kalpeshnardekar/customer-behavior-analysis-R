# 🛍️ Customer Behavior Analysis in R
R project analyzing customer purchase behavior across online and in-store channels.

A data analysis project to study **customer purchase behavior** using R.  
The dataset (~100K rows) contains retail transactions from both **online** and **in-store** channels.

---

## 📘 Dataset Overview

| Column | Type | Description |
|--------|------|-------------|
| Customer_ID | chr | Unique customer identifier |
| Gender | chr | Gender of the customer |
| Location | chr | City or region |
| Channel | chr | Purchase channel ("Online"/"In-Store") |
| Product_Category | chr | Product category |
| Product_ID | chr | Product identifier |
| Age | dbl | Customer age |
| Quantity | dbl | Quantity purchased |
| Purchase_Amount | dbl | Total value of purchase |
| Date_of_Purchase | date | Transaction date |

---

## ⚙️ Steps

1. **Import & Inspect Data**  
   - Load CSV using `readr::read_csv()`  
   - Check structure, data types, and missing values  

2. **Analyze**  
   - Average purchase by channel  
   - Top product categories by revenue  

3. **Visualize**  
   - Histogram of purchase amounts  
   - Boxplot by channel  
   - Revenue by product category (bar chart)

---

## 🧰 Tools Used

- **R**  
- **dplyr**, **readr**, **ggplot2**

---

## 🚀 Run the Script

```r
install.packages(c("readr", "dplyr", "ggplot2"))
source("customer_behavior_analysis.R")


💡 Insights

Online purchases show higher average value.

Electronics & Clothing dominate total revenue.

Spending patterns vary by channel and location.


👨‍💻 Author

Kalpesh Nardekar
Data Analyst | BI Developer
📧 [kalpeshnardekar@outlook.com]
