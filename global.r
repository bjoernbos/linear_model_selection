#Import data
data <- read.csv("data.csv", sep=";", dec=",")

# Compute more values from x variable in a helper dataframe
data_helper <- NULL
data_helper$sqrt_x <- sqrt(data$x)
data_helper$x2 <- (data$x)^2
data_helper$x3 <- (data$x)^3