pollutantmean <- function(directory, pollutant, id = 1:332) {
  
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'pollutant' is a character vector of length 1 indicating
  ## the name of the pollutant for which we will calculate the
  ## mean; either "sulfate" or "nitrate".
  
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  
  ## Return the mean of the pollutant across all monitors list
  ## in the 'id' vector (ignoring NA values)
  
  pollutants <- function(id) {
    path <- file.path(directory, paste(sprintf("%03d", as.numeric(id)), ".csv", sep=""))
    curr_file <- read.csv(path, header = TRUE)
    pollutantData <- curr_file[[pollutant]]
    pollutantData[!is.na(pollutantData)]
  }
  
  pollutantLists <- sapply(id, pollutants)
  final_list <- unlist(pollutantLists)
  round(mean(final_list), digits = 3)
}