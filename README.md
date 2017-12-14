# ShinyApp to figure out the best univariate linear model
<img src="https://img.shields.io/badge/build-passing-green.svg">

This repository contains the ShinyApp of my Medium article on ["How to select the best performing linear regression for univariate models"](https://medium.freecodecamp.org/learn-how-to-select-the-best-performing-linear-regression-for-univariate-models-e9d429c40581).

![screencast](https://github.com/bjoernhartmann/linear_model_selection/blob/master/Screencast.gif)

[Live Version](https://bjoernhartmann.shinyapps.io/linear_model_selection/)

## How to use it
Use this app as a companion to my article on ["How to select the best performing linear regression for univariate models"](https://medium.freecodecamp.org/learn-how-to-select-the-best-performing-linear-regression-for-univariate-models-e9d429c40581). In addition, you can use it as a framework to evaluate your own dataset or models.

## Features
Different performance indicator indicate how well your model performs. I personally use the following for univariate models:

### Adjusted R2
The adjusted R2 indicate, how much variation is explained by your model. Instead of the simple R2, the adjusted R2 takes the number of input factors into consideration. It penalises too many input factors in order to favor parsimonious models.

### Residuals
The residuals should be equally distributed around zero. Otherwise, the model has an upward or downward bias in certain areas. Use them also to examine whether your dataset exhibits heteroscedacity.
Finally, the residuals indicate the bandwidth in which your model errors are.

## Build With
* [R Shiny](https://shiny.rstudio.com)

## Author
* Björn Hartmann - [Twitter](https://twitter.com/bjoernhartmann_) | [Medium](https://medium.com/@B..Hartmann)
