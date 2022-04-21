#' Growing Degree Days for Philaenus spumarius eggs
#'
#' This function returns a DataFrame containing GDD, cummulative GDD and Hatching Probabilities from a csv file of Dates and hourly Temperatures.
#' @param input_filename The filename of a csv file containing Dates and hourly Temperatures.
#' @param output_filename The filename for the output csv (if write_output=TRUE)
#' @param T_column The name of the column of the input csv file containing temperatures
#' @param Date_column The name of the column of the input csv file containing Dates
#' @param date_format The format of the dates in the csv input file (e.g. "%d/%m/%Y")
#' @keywords model
#' @export
#' @examples
#' apply_model("temperatures.csv", "results.csv", "T", "Date", "%d/%m/%Y")set

apply_model <- function(input_filename, output_filename, T_column, Date_column, date_format, write_output=TRUE){
  
  library(dplyr)
  
  #Load data
  data = read.csv(input_filename)
  
  #Ensure proper type for dates
  data$Date <- as.Date(strptime(data[[Date_column]], format=date_format))
  
  #Order properly
  data <- arrange(data, Date)
  
  #Compute the contribution to the GDD of each hour
  data$GDD <- as.vector(sapply(data[[T_column]], PS_GDD))
  
  #Compute the GDD
  df <- data %>% 
    group_by(Date) %>% 
    summarize(GDD = mean(GDD))
  
  #Compute the accumulation of GDD from first to last day
  df$GDD_cum <- cumsum(df$GDD)
  
  #Compute the cummulative hatching probability
  df$Hatching_prob = PS_hatching_probability(df$GDD_cum)
  
  if (write_output==TRUE) {
    
    write.csv(df, output_filename)
    
  }
  
  return(df)
  
}