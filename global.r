# Import data
data <- read.csv("data.csv", sep=";", dec=",")

# Compute square values of x variable for lm estimation
data$x2 <- (data$x)^2