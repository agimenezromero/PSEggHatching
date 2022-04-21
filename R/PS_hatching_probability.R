#' Hatching probability for Philaenus spumarius eggs based on GDDs
#'
#' This function allows to compute the Philaenus spumarius eggs hatching probabilities.
#' @param GDD Growing Degree Days for Philaenus spumarius. No default.
#' @keywords GDD, Probabilities
#' @export
#' @examples
#' PS_hatching_probability(280)

PS_hatching_probability <- function(GDD){
  
  C=249.55
  k=0.0256
  
  return(1/(1+exp(-k*(GDD-C))))
  
}