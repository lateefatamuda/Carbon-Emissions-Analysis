# Carbon Emissions Data Analysis
## Project Description
This project was carried out as part of the requirement for the completion of my Master's degree program in <b>Data Science</b> at the [University of Salford](https://www.salford.ac.uk/science-engineering-and-environment).

Carbon emissions and carbon footprint are terms increasingly being used in association with climate change, as they help people get a better understanding of how some of their activities may affect and damage the environment. Carbon emissions measure the amount of carbon dioxide that can be released from human activities. While, Carbon footprint measures the total carbon emissions induced by an individual, household, company or nation, over a period of time.

Different studies show that renewable energy produces zero waste, leading to reductions in carbon emissions, whereas fossil fuel consumption produces a large amount of carbon dioxide, causing an increase in carbon emissions. 


## Project Objective

The objective of this research is to compare the carbon emissions and energy consumption in developing countries with developed countries, as well as the effect of the emission damage on the adjusted net savings.

In this project, we:
* Produced a single-screen interactive dashboard which shows the current carbon emissions and energy consumptions across different countries and also provides insights into the effect of these emissions on the countries’ Gross National Income (GNI).
* Compared the total carbon emissions from different sources and the energy consumption over the years.


### Technologies and Tools Used

* R
* R-Studio
* PowerBI

## Dataset Description
### Carbon emissions dataset

The dataset was downloaded from the [World Data Indicators](https://databank.worldbank.org/source/world-development-indicators).

Each row on the dataset corresponds to a unique combination of country and year.
Different Series, Time and Country indicators were selected for the dataset. The dataset shows a summary of Carbon emissions, Energy 
consumption and the effect of emissions on the countries’ Gross National Income (GNI), from the year 2000 to 2015. 

The countries selected are Canada, Denmark, Estonia, Germany, China, Spain, United States, United Kingdom, Egypt, South Africa, and Peru.
Below are the column codes and the corresponding names:

| Column Name     |  Column Code   | 
|---------|-----------------|
| Renewable energy consumption (% of total final energy consumption) | EG.FEC.RNEW.ZS |
| Alternative and nuclear energy (% of total energy use) | EG.USE.COMM.CL.ZS |
| Fossil fuel energy consumption (% of total) | EG.USE.COMM.FO.ZS |
| CO2 emissions from gaseous fuel consumption (% of total) | EN.ATM.CO2E.GF.ZS |
| CO2 emissions from liquid fuel consumption (% of total) | EN.ATM.CO2E.LF.ZS |
| CO2 emissions from solid fuel consumption (% of total) | EN.ATM.CO2E.SF.ZS |
| CO2 emissions from residential buildings and commercial and public services (% of total fuel combustion) | EN.CO2.BLDG.ZS |
| CO2 emissions from electricity and heat production, total (% of total fuel combustion) | EN.CO2.ETOT.ZS |
| CO2 emissions from manufacturing industries and construction (% of total fuel combustion) | EN.CO2.MANF.ZS |
| CO2 emissions from other sectors, excluding residential buildings and commercial and public services (% of total fuel combustion) | EN.CO2.OTHX.ZS |
| CO2 emissions from transport (% of total fuel combustion) | EN.CO2.TRAN.ZS |
| Combustible renewables and waste (% of total energy) | EG.USE.CRNW.ZS |
| Electricity production from renewable sources, excluding hydroelectric (% of total) | EG.ELC.RNWX.ZS |
| Adjusted savings: energy depletion (% of GNI) | NY.ADJ.DNGY.GN.ZS |
| Adjusted savings: particulate emission damage (% of GNI) | NY.ADJ.DPEM.GN.ZS |
| Adjusted net savings, including particulate emission damage (% of GNI) | NY.ADJ.SVNG.GN.ZS |
| Adjusted net savings, excluding particulate emission damage (% of GNI) | NY.ADJ.SVNX.GN.ZS |


## Tasks Performed

- Data exploration
- Data processing/cleaning
- Data visualization
- Descriptive statistical analysis
- Correlation analysis
- Regression analysis
- Time series analysis and predictions
- Hypothesis testing
- Write up/reporting


## Result of the Analysis

There were two files produced from this analysis.
* PowerBI file: this contains the interactive dashboard. It is named `carbon_emissions_dashboard.pbix`.
* R file: this contains R code for the statistical analysis. It is named `carbon_emissions_analysis.R`.
* Report: this is a compressed/zipped PDF file that fully explains the processes, including the exploratory data analysis, data preparation and cleaning, the algorithms used and the evaluation of the results. It is named `report.pdf.zip`.


## Recommended Improvements
--


## Author
Lateefat Amuda
