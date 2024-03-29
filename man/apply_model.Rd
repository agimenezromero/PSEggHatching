% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/apply_model.R
\name{apply_model}
\alias{apply_model}
\title{Growing Degree Days for Philaenus spumarius eggs}
\usage{
apply_model(
  input_filename,
  output_filename,
  T_column,
  Date_column,
  date_format,
  write_output = TRUE
)
}
\arguments{
\item{input_filename}{The filename of a csv file containing Dates and hourly Temperatures.}

\item{output_filename}{The filename for the output csv (if write_output=TRUE)}

\item{T_column}{The name of the column of the input csv file containing temperatures}

\item{Date_column}{The name of the column of the input csv file containing Dates}

\item{date_format}{The format of the dates in the csv input file (e.g. "\%d/\%m/\%Y")}
}
\description{
This function returns a DataFrame containing GDD, cummulative GDD and Hatching Probabilities from a csv file of Dates and hourly Temperatures.
}
\examples{
apply_model("temperatures.csv", "results.csv", "T", "Date", "\%d/\%m/\%Y")set
}
\keyword{model}
