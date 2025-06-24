# Auto-Sales-Customer-Acquisition-Analysis

## Overview of the project 

This project analyzes customer acquisition and revenue trends using a Kaggle automotive sales dataset. Using SQL queries, Python analysis, and interactive visualizations, conducted a analysis that reveals the complete story behind declining customer acquisition metrics. This project demonstrates how deep data investigation can uncover hidden business success where surface-level metrics suggest failure.

## Table of Contents 
* [Problem Statement](#Problem-Statement)
* [Dataset](#Dataset)
* [Tech Stack](#Tech-Stack)
* [Project Structure](#Project-Structure)
* [Installation & Setup](#How-to-run)
* [Key Findings](#Key-Findings)
* [License](#License)
* [Contact](#Contact)

## Problem Statement 

Between 2018 and 2019, A hypothetical multinational automobile company experienced a significant drop in customer acquisition, with the average number of new customers per month declining by 46%—from 5.2 to 2.8. This downward trend raised concerns about a potential loss of market share and emerging risks to overall business growth.

* Market Share Loss: Potential erosion of competitive position
* Revenue Risk: Threat to sustainable business growth
* Operational Efficiency: Questions about marketing and sales effectiveness
* Strategic Direction: Need to understand root causes and business impact

## Dataset

* Source: Kaggle - [Auto Sales Dataset](https://www.kaggle.com/datasets/ddosad/auto-sales-data/data?select=Auto+Sales+data.csv)
* Scenario Adaptation: Transformed public dataset into realistic business case study
* Time Period: 2018-2020 (3-year analysis window)
* Records: 2000+ records

### Key Features:

* Customer table
* Revenue and pricing data
* Products Table
* Geographic information

**Data Quality:** Preprocessed and enhanced dataset with comprehensive data validation

## Tech Stack
 * **Database**: SQL server
 * **Data Analytics**: Python 3.8+ (pandas, numpy, plotly, sqlalchemy)
 * **Dashboard**: PowerBI
 * **Development Enviroment**: Mysql Workbench, VS code

## Project Structure
```
   Auto-Sales-Customer-Acquisition-Analysis/
   |__ Data/
   |   |____customer.csv
   |   |____orders.csv
   |   |____products.csv
   |
   |__ notebooks/
   |    |____data_analysis_workbook.ipynb
   |
   |__ reports/
   |    |____business_analysis_report.md
   |
   |__ sql/
   |   |____customer_acquisition.sql  
   |   |____customer_behaviour_analysis.sql
   |   |____data_exploration.sql
   |   |____database_setup.sql
   |   |____geographic_market_analysis.sql
   |   |____revenue_transformation_analysis.sql
   |
   |__visualizations/
   |   |____Customer Acquisition Countrywise.html
   |   |____Loss,Gain in sales from 2018 to 2019.html
   |   |____Month over Month Growth Rate.html
   |   |____Monthly order sales and quantity trends.html
   |   |____Montlhy new and cumulative acquisition.html
   |   |____Sales comparison by country.html
   |   |____Yearly order trends.html
   |   |____customer_acquisition_dashboard.pbix
   |
   |__Readme.md

```

## Installation & Setup
### Prerequisites

* Python 3.8 or higher
* SQL Server/PostgreSQL access
* Tableau/Power BI (for dashboard viewing)

### Installation Steps

* Clone the repository
  ```
  git clone https://github.com/PriyamG2508/Auto-Sales-Customer-Acquisition-Analysis.git
  cd Auto-Sales-Customer-Acquisition-Analysis
  ```
* Create virtual Enviroment
  ```
  python -m venv venv
  source venv/bin/activate  # On Windows: venv\Scripts\activate
  ```
* Install dependencies
  ```
  pip install -r requirements.txt
  ```
## Key Findings

This investigation reveals a compelling business transformation story where declining customer acquisition metrics masked a highly successful premium market positioning strategy. The $789,951 revenue increase demonstrates that the organization's evolving customer base represents a sustainable competitive advantage.

The analysis showcases the importance of comprehensive data investigation and the danger of making strategic decisions based on isolated metrics. What initially appeared to be a business crisis was actually a market evolution that positioned the company for premium growth.

### Strategic Insights

* The business successfully transitioned from volume-based to value-based customer acquisition
* Premium customer focus yielded higher profitability despite lower volume
* Marketing efficiency improvements reduced waste and improved ROI

## Future Improvements 

* Predictive Modeling: Implement machine learning for customer acquisition forecasting
* Real-time Dashboard: Connect to live data sources for real-time monitoring
* Advanced Segmentation: Develop more sophisticated customer clustering
* Competitive Analysis: Integrate market benchmark data
* Automated Reporting: Schedule regular executive summary generation

## License
This project is licensed under the MIT License - see the [LICENSE]() file for details.

## Contact

* **Author** : Priyam Gupta
* **Email**: priyamgupta2508@gmail.com
* **LinkedIn** : [Priyam Gupta](https://www.linkedin.com/in/priyamg2508/)
* **GitHub** : [PriyamG2508](https://github.com/PriyamG2508/)
