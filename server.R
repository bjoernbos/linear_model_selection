#
# This ShinyApp shows how to evaluate and compare
# the quality of linear models.
#

library(shiny)

shinyServer(function(input, output) {
  
  # Reactive value that triggers plot update and stores fitted values
  v <- reactiveValues(fitted_values = NULL,
                      r2 = NULL)

  # When action button was triggered...
  observeEvent(input$trigger_estimation, {
    # Add progress bar
    withProgress(message = 'Please wait',
                 detail = 'Run estimation...', value = 0.6,
    {
      # Run estimation depending on the model specification
      if (input$model == "linear"){
        estimation <- lm(data[, input$dataset] ~ data$x)
      }
      else if (input$model == "quadratic"){
        estimation <- lm(data[, input$dataset] ~ data$x + data_helper$x2)
      }
      else if (input$model == "root"){
        estimation <- lm(data[, input$dataset] ~ data_helper$sqrt_x)
      }
      else {
        estimation <- lm(data[, input$dataset] ~ data$x + data_helper$x2 + data_helper$x3)
      }
      
      # Increase progress bar to 0.8  
      incProgress(0.8, detail="Store results")
      
      v$fitted_values <- estimation$fitted.values
      v$residuals <- estimation$residuals
      v$adjr2 <- round(summary(estimation)$adj.r.squared,4)*100
      
      # Increase progress bar to 1
      incProgress(1, detail="Finish")
    })
  })
  
  # Estimation Results
  output$estimation_results <- renderText(
    v$adjr2
  )
  
  # Accuracy Box
  output$accuracy_box <- renderValueBox({
    valueBox(
      paste0(v$adjr2, "%"), "Accuracy (Adj. R2)", icon = icon("tachometer"),
      color = "light-blue"
      )	
    })
  
  # Overview Plot
  output$plot <- renderPlot({
      plot(data$x, data[, input$dataset],
           main = "Estimation of random points",
           xlab = "x variable",
           ylab = "y variable")
      lines(v$fitted_values,
            col ="red",
            lwd = 3
            )
    
  })
  
  # Residual Summary
  output$residuals_mean <- renderText(
    if (is.null(v$fitted_values)) "No estimation has been computed, yet"
    else paste("Mean:", round(mean(v$residuals),4))
  )
  
  output$residuals_minmax <- renderUI(
    if (is.null(v$fitted_values)) "No estimation has been computed, yet"
    else {
      str1 <- paste("Min value:", round(min(v$residuals),4))
      str2 <- paste("Max value:", round(max(v$residuals),4))
      HTML(paste(str1, str2, sep = '<br/>'))
    }
  )
  
  # Residual plot
  output$residual_plot <- renderPlot(
    if (is.null(v$fitted_values)) return()
    else {
      plot(data$x, v$residuals,
           xlab = "x variable",
           ylab = "Residuals")
      abline(h=0,
             col="red")
    }
  )  
  
  # Residual histogram
  output$residuals_histogram <- renderPlot(
    if (is.null(v$fitted_values)) return()
    else {
      hist(v$residuals,
           breaks = 20,
           main = "",
           xlab = "Residuals",
           ylab = "Frequency")
      abline(v=0,
             col="red")
    }
  )

  # Show Data Table
  output$data_table <- renderDataTable(data)

})