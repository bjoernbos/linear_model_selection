#
# This ShinyApp shows primarily how to improve the UI
# and UX of ShinyApps in general.
#
# Technically, it can be used to estimate a quadratic function.
# 

library(shiny)


shinyServer(function(input, output) {
  
  # Reactive value that triggers plot update and stores fitted values
  v <- reactiveValues(doPlot = FALSE,
                      fitted_values = NULL,
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
        estimation <- lm(data[, input$dataset] ~ data$x + data$x2)
      }
      else if (input$model == "root"){
        estimation <- lm(data[, input$dataset] ~ data$sqrt_x)
      }
      else {
        estimation <- lm(data[, input$dataset] ~ data$x + data$x2 + data$x3)
      }
      
      # Increase progress bar to 0.8  
      incProgress(0.8, detail="Store results")
      
      v$fitted_values <- estimation$fitted.values
      v$residuals <- estimation$residuals
      v$adjr2 <- round(summary(estimation)$adj.r.squared,4)*100
      
      # Increase progress bar to 1
      incProgress(1, detail="Finish")
      
      # Trigger plot update
      v$doPlot <- input$trigger_estimation
      
    
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
  
  # Residual plot
  output$residual_plot <- renderPlot({
    
    plot(data$x, v$residuals,
         main = "Residuals",
         xlab = "x variable",
         ylab = "residuals")
  })  
  
  # Residual histogram
  output$residuals_histogram <- renderPlot({
    
    hist(v$residuals,
         main = "Histogram of Residuals",
         xlab = "x variable",
         ylab = "y variable")
  })
  

  # Show Data Table
  output$data_table <- renderDataTable(data)

})