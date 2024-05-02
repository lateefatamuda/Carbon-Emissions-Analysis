#Loading the needed Libraries
library(tidyverse)
library(readxl)
library(corrplot)
library(gridExtra)
library(GGally)
library(knitr)
library(moments)
library(ggplot2)
library(qqplotr)
library(Hmisc)
library(car)
library(TTR)
library(forecast)


#Loading the data
co2_dataset <- read.csv("Carbon_emission_data.csv", header= TRUE)


#Exploring the data set
str(co2_dataset)
names(co2_dataset) #We can see that there are 29 columns
dim(co2_dataset)
head(co2_dataset)
summary(co2_dataset)


#Code to count the missing values in each column
print("Count of missing values by column wise----")
sapply(co2_dataset, function(x) sum(is.na(x)))

#Removing the rows that contain missing values
co2_dataset <- na.omit(co2_dataset)
print("Count of missing values by column wise----")
sapply(co2_dataset, function(x) sum(is.na(x)))


# Separating the data based on whether the countries are Developed or Developing
head(co2_dataset)
co2_developed <- filter(co2_dataset, Category == 'Developed')
co2_developing <- filter(co2_dataset, Category == 'Developing')
head(co2_developed)
head(co2_developing)


#Extracting Numerical variables from the data set and store them in a new data set
co2_data_reduced <- co2_dataset[,-c(1,2,4)]
head(co2_data_reduced)

#Developed
co2_developed_reduced <- co2_developed[,-c(1,2,4)]
head(co2_developed_reduced)

#Developing
co2_developing_reduced <- co2_developing[,-c(1,2,4)]
head(co2_developing_reduced)



##QUESTION1 - To obtain a comprehensive statistical analysis 

#Developed countries data
#To determine the Mean and Median of the data
apply(co2_developed_reduced, 2, mean)
apply(co2_developed_reduced, 2, median)

#To determine the Standard deviation, Skewness and Kurtosis of the data set
#Standard Deviation
sapply(co2_developed_reduced, sd)

#Skewness
skewness(co2_developed_reduced)

#Kurtosis
kurtosis(co2_developed_reduced)


#Developing countries data
#Mean of the data
apply(co2_developing_reduced, 2, mean)

#Median of the data
apply(co2_developing_reduced, 2, median)

#Standard Deviation
sapply(co2_developing_reduced, sd)

#Skewness
skewness(co2_developing_reduced)

#Kurtosis
kurtosis(co2_developing_reduced)



## QUESTION 2 - Correlation analysis for the indicators and evaluate the results

#Correlation Matrix between all variables
cor(co2_data_reduced)
round(cor(co2_data_reduced), digits = 2)

#Visualize the Correlation Matrix
corrplot(cor(co2_data_reduced), method="number", type="upper")
corrplot(cor(co2_developed_reduced), method="number", type="upper")
corrplot(cor(co2_developing_reduced), method="number", type="upper")



## QUESTION 3 - Regression analysis

##Multiple Linear Regression(MLR)
##1 => To determine how total energy consumption is affected by the liquid fuel and transport CO2 emissions 
model_1 <-lm(Total.energy.consumption ~ EN.ATM.CO2E.LF.ZS + EN.CO2.TRAN.ZS, co2_data_reduced)
summary.lm(model_1)


##2 => To determine how total energy consumption is affected by the liquid fuel,
#transport, and manufacturing & construction industries CO2 emissions
model_2 <-lm(Total.energy.consumption ~ EN.ATM.CO2E.LF.ZS + EN.CO2.TRAN.ZS + EN.CO2.MANF.ZS, co2_data_reduced)
summary.lm(model_2)


#Making sure the fitted model meets MLR assumptions
#Linearity: To draw the scatter plot matrix. Find the indices for the 4 variables to select the columns 
data.frame(colnames(co2_data_reduced))
pairs(co2_data_reduced[,c(18,8,13,9)], lower.panel = NULL, pch = 19,cex = 0.2)
#Check the first row it seems all Independent Variables have a linear relation with the Total.energy.consumption

#Residuals’ Independence
plot(model_2, 1)

#Normality of residuals 
plot(model_2, 2)

#Equal variances of the residuals (Homoscedasticity)
plot(model_2, 3)

#No multicollinearity
#Using the Car package to see the variance inflation factor (VIF) measures
vif(model_2)




## QUESTION 4 - Time Series Analysis
#Group by Year for the analysis
co2_data_grouped = aggregate(Total.energy.consumption ~ Year, data=co2_data_reduced, FUN = mean, na.rm = TRUE)
head(co2_data_grouped)

#Determine and Plot the Time Series
Total.energy.consumption_timeseries <- ts(co2_data_grouped$Total.energy.consumption, start = c(2000))
Total.energy.consumption_timeseries
plot.ts(Total.energy.consumption_timeseries)


#Decomposing the timeseries data
Total.energy.consumption_timeseries_SMA3 <- SMA(Total.energy.consumption_timeseries, n=3)
plot.ts(Total.energy.consumption_timeseries_SMA3)


#Forecasts using Exponential Smoothing
total.energy.consumption_series_forecasts <- HoltWinters(Total.energy.consumption_timeseries, gamma=FALSE)
total.energy.consumption_series_forecasts

#Plotting the original time series against the forecasts
plot(total.energy.consumption_series_forecasts)


#Sum-of-squared-errors(SSE)
#Calculating the Sum of squared errors (SSE) for the in-sample forecast errors
total.energy.consumption_series_forecasts$SSE


#To make forecasts with the initial value of the level set to 1.010369(first value in the data)
#b.start = second value -first value of the series
HoltWinters(Total.energy.consumption_timeseries, gamma = FALSE, l.start=1.010369, b.start=0.003809)


#To make a forecast of total.energy.consumption from the years 2015-2024 (10 more years) using forecast()
total.energy.consumption_series_forecasts2 <- forecast(total.energy.consumption_series_forecasts, h=10)
total.energy.consumption_series_forecasts2

#To plot the predictions made
plot(total.energy.consumption_series_forecasts2)


#To calculate a correlogram of the in-sample forecast errors for the data for lags 1-20
acf(total.energy.consumption_series_forecasts2$residuals, lag.max = 20, na.action = na.pass)

Box.test(total.energy.consumption_series_forecasts2$residuals, lag=10, type="Ljung-Box")

#To check that the forecast errors have constant variance over time,
plot.ts(total.energy.consumption_series_forecasts2$residuals)

plotForecastErrors <- function(forecasterrors)
{
  # make a histogram of the forecast errors:
  mybinsize <- IQR(forecasterrors)/4
  mysd <- sd(forecasterrors)
  mymin <- min(forecasterrors) - mysd*5
  mymax <- max(forecasterrors) + mysd*3
  # generate normally distributed data with mean 0 and standard deviation mysd
  mynorm <- rnorm(10000, mean=0, sd=mysd)
  mymin2 <- min(mynorm)
  mymax2 <- max(mynorm)
  if (mymin2 < mymin) { mymin <- mymin2 }
  if (mymax2 > mymax) { mymax <- mymax2 }
  # make a red histogram of the forecast errors, with the normally distributed data overlaid:
  mybins <- seq(mymin, mymax, mybinsize)
  hist(forecasterrors, col="red", freq=FALSE, breaks=mybins)
  # freq=FALSE ensures the area under the histogram = 1
  # generate normally distributed data with mean 0 and standard deviation mysd
  myhist <- hist(mynorm, plot=FALSE, breaks=mybins)
  # plot the normal curve as a blue line on top of the histogram of forecast errors:
  points(myhist$mids, myhist$density, type="l", col="blue", lwd=2)
}

total.energy.consumption_series_forecasts2$residuals <-
  total.energy.consumption_series_forecasts2$residuals[!is.na(total.energy.consumption_series_forecasts2$residuals)]
plotForecastErrors(total.energy.consumption_series_forecasts2$residuals)




## QUESTION 5 - Hypothesis testing

#Assessing the Normality of Data
head(co2_dataset)

ggplot(mapping = aes(sample=co2_dataset$Total.energy.consumption)) +
  stat_qq_point(size = 2,color = "blue") +
  stat_qq_line(color="orange") +
  xlab("Theoretical") + ylab("Sample")


#Box plot to show the dispersion of the observations based on the Category column
boxplot(Total.energy.consumption ~ Category , data=co2_dataset, names=c("Developed", "Developing"),
        xlab="Category", ylab="Total energy consumption",
        main="Total energy consumption Developed and Developing countries")


#Testing the hypothesis
##1 => Bartlett test of homogeneity of variances
bartlett.test(log1p(Total.energy.consumption) ~ Category, data = co2_dataset)


##2 => Independent Two Sample t-test
t.test(log1p(Total.energy.consumption) ~ Category, data = co2_dataset, var.equal = TRUE)


