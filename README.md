# PSEggHatching
R minimal package to predict Philaenus spumarius egg hatching in Spain

# Installation

```r

library(devtools)

install_github("agimenezromero/PSEggHatching")

```

# Usage

The package implements three functions: 

`PS_GDD(T)`: This function allows to compute the Growing Degree Days for the latter computation of Philaenus spumarius hatching probabilities. Input: vector of hourly temperatures. Output: Hourly contribution to the GDD for each item.

`PS_hatching_probability(GDD)`: This function allows to compute the Philaenus spumarius eggs hatching probabilities. Input: accumulated GDD values (scalar or vector). Output: Cumulative probability of hatching for each value of accumulated GDD.

`apply_model(input_filename, output_filename, T_column, Date_column, date_format)`: This function returns a DataFrame containing GDD, cummulative GDD and Hatching Probabilities from a csv file of Dates and hourly Temperatures.

# Example

```
library(PSEggHatching)

input = "temperature_data.csv" #Name of the csv file containing hourly temperature data (with a column for temperature and a column for dates)

output = "results.csv" #Name of the output csv that will be written

T_col_name = "Temperature" #Name of the column of the input csv containing temperature data

Dates_col_name = "Date" #Name of the column of the input csv containing dates

date_format = "%d/%m/%Y" #Format of the dates in the csv

results_df = apply_model(input, output, T_col_name, Dates_col_name, date_format)

```
