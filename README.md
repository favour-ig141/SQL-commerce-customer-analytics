 # E-commerce Customer Revenue & Churn Analysis (SQL Server)

## 📌 Project Overview

This project analyzes customer purchasing behavior using SQL Server Management Studio (SSMS).  

The objective was to simulate a real-world business scenario where management requires insights into:

- Top revenue-generating customers
- Revenue contribution percentage
- Customer segmentation by spending behavior
- Churn risk detection (90+ days inactive)
- Revenue validation and financial data integrity checks

This project demonstrates strong SQL fundamentals combined with business-focused analytical thinking.

---

## 🛠 Tools & Technologies Used

- SQL Server
- SQL Server Management Studio (SSMS)
- T-SQL
- Window Functions (RANK, SUM OVER)
- CTEs (Common Table Expressions)
- Views
  
 ---

### 2️⃣ Customer Revenue Ranking

Ranked customers by total revenue using SQL Window Functions to identify high-value customers driving business growth.
---

### 3️⃣ Top 10 Customers

Identified the top 10 customers contributing the highest revenue using SQL Server's TOP clause.
---

### 4️⃣ Customer Segmentation

Segmented customers into:
- High Value
- Medium Value
- Low Value

Based on total spending behavior to support targeted marketing strategies.
 ---

### 5️⃣ Churn Risk Detection (90+ Days Inactive)

Identified customers who have not made a purchase in the last 90 days

---

🧠 Key SQL Concepts Demonstrated
INNER JOIN
- GROUP BY
- HAVING
- Aggregate Calculations
- Window Functions
- RANK()
- CTE (Common Table Expression)
- Views for reusable reporting
- Data Validation Techniques
- Date-based churn logic

---
📈 Example Insights Generated
- Top 10 customers contributed a significant percentage of total revenue.
- A portion of customers were identified as high churn risk (90+ days inactive).
- Revenue discrepancies were detected and validated to ensure reporting accuracy.
- Customer revenue distribution showed revenue concentration among high-value segments.

![Dashboard Preview](greenlife_inventory_dashboard.PNG)
