# Import data
data <- read.csv("data.csv", sep=";", dec=",")

# Compute more values from x variable for lm estimations
data$sqrt_x <- sqrt(data$x)
data$x2 <- (data$x)^2
data$x3 <- (data$x)^3