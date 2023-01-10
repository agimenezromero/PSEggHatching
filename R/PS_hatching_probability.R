#' Hatching probability for Philaenus spumarius eggs based on GDDs
#'
#' This function allows to compute the Philaenus spumarius eggs hatching probabilities.
#' @param GDD Growing Degree Days for Philaenus spumarius. No default.
#' @keywords GDD, Probabilities
#' @export
#' @examples
#' PS_hatching_probability(280)

PS_hatching_probability <- function(GDD){
  
  l=164.86
  k=4.34
  
  return(1-exp(-(GDD/l)^k))
  
}