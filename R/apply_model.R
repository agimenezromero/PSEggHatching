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
  data = read.csv2(input_filename)
  
  #Ensure proper type for dates
  data$MYDATE <- as.Date(strptime(data[[Date_column]], format=date_format))
  data$MYTEMPERATURE <- as.numeric(data[[T_column]])
  
  #Order properly
  data <- arrange(data, MYDATE)
  
  #Compute the contribution to the GDD of each hour
  data$GDD <- as.vector(sapply(data$MYTEMPERATURE, PS_GDD))
  
  #Compute the GDD
  df <- data %>% 
    group_by(MYDATE) %>% 
    summarize(GDD = mean(GDD))
  
  #Compute the accumulation of GDD from first to last day
  df$GDD_cum <- cumsum(df$GDD)
  
  #Compute the cummulative hatching probability
  df$Hatching_prob = PS_hatching_probability(df$GDD_cum)
  
  first_treatment_North <- df$MYDATE[which(df$Hatching_prob > 0.4)][1]
  second_treatment_North <- df$MYDATE[which(df$Hatching_prob > 0.9)][1]
  
  first_treatment_South <- df$MYDATE[which(df$Hatching_prob > 0.35)][1]
  second_treatment_South <- df$MYDATE[which(df$Hatching_prob > 0.8)][1]
  
  cat("\nDISCLAIMER: The results below depend on the oviposition date considered, which is assumed to be the first date on the input dataset. Our model suggests the use of 15/10 for Northern Spain (latitudes above 40º N) and 20/11 for Southern Spain (latitudes below 40º N). \n")
  
  cat("\n################### Northern Spain (latitudes > 40º N) ###################\n\n")
  
  if (is.na(first_treatment_North)){
    print("No treatments needed yet")
  } else {
    
    if (is.na(second_treatment_North)){
      cat(sprintf("\tFirst treatment should be applied on %s and second is still not needed", first_treatment_North))
    } else{
      
      cat(sprintf("\tFirst treatment should be applied on %s and second one on %s", first_treatment_North, second_treatment_North))
      
    }
      
  }
  
  cat("\n\n################### Southern Spain (latitudes < 40º N) ###################\n\n")
  
  if (is.na(first_treatment_South)){
    print("No treatments needed yet")
  } else {
    
    if (is.na(second_treatment_South)){
      cat(sprintf("\tFirst treatment should be applied on %s and second is still not needed", first_treatment_South))
    } else{
      
      cat(sprintf("\tFirst treatment should be applied on %s and second one on %s ", first_treatment_South, second_treatment_South))
      
    }
    
  }
  
  if (write_output==TRUE) {
    
    write.csv(df, output_filename)
    
  }
  
  return(df)
  
}