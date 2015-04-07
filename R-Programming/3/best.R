library(dplyr)

best <- function(state, outcome) {
  
  findBest <- function(outcome, col, state){
    sub <- outcome %>% filter(State == state)
    sub[which(sub[,col]== min(sub[,col], na.rm = T)),2]
  }
  
  ## Read outcome data
  ## Check that state and outcome are valid
  ## Return hospital name in that state with lowest 30-day death
  ## rate
  
  data <- read.csv("outcome-of-care-measures.csv", colClasses="character")
  # change data type from character to numeric
  data[, 11] <- as.numeric(data[, 11]) # heart attack
  data[, 17] <- as.numeric(data[, 17]) # heart failure
  data[, 23] <- as.numeric(data[, 23]) # pneumonia
  valid_outcomes <- c("heart attack", "heart failure", "pneumonia")
  if (!state %in% data$State) {
    stop("invalid state")
  } else if(!outcome %in% valid_outcomes) {
    stop("invalid outcome")
  } else {
    if(outcome == "heart attack") {
      hosp_name <- findBest(data, 11, state)
    } else if(outcome == "heart failure") {
      hosp_name <- findBest(data, 17, state)
    } else {
      hosp_name <- findBest(data, 23, state)
    }
    return(hosp_name)
  }
}