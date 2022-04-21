#' Growing Degree Days for Philaenus spumarius eggs
#'
#' This function allows to compute the Growing Degree Days for the latter computation of Philaenus spumarius hatching probabilities.
#' @param T Temperature in Celsius. No default.
#' @keywords GDD, Temperature
#' @export
#' @examples
#' PS_GDD(14.5)

PS_GDD <- function(T){
  
  T_base=9.2
  T_opt=24.1
  T_max=35.9
  
  m = - (T_opt - T_base) / (T_max - T_opt)
  n = -m * T_max
  
  if (T > T_base && T <= T_opt){ 
    return(T-T_base)
  } else if (T > T_opt && T <= T_max){
    return(m*T+n)
  } else {return(0.0)}
}