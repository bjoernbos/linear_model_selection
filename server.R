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
      # Run estimation for linear or quadratic function
      if (input$model == "linear"){
        estimation <- lm(data$y ~ data$x)
      }
      else {
        estimation <- lm(data$y ~ data$x + data$x2)
      }
      
      # Increase progress bar to 0.8  
      incProgress(0.8, detail="Store results")
      
      v$fitted_values <- estimation$fitted.values
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
  
  # Estimation Accuracy
  output$accuracy_box <- renderValueBox({
    valueBox(
      paste0(v$adjr2, "%"), "Accuracy", icon = icon("tachometer"),
      color = "light-blue"
      )	
    })
  
  # Overview Plot
  output$plot <- renderPlot({
    
      plot(data$x, data$y,
           main = "Estimation of random points",
           xlab = "x variable",
           ylab = "y variable")
      lines(v$fitted_values,
            col ="red",
            lwd = 3
            )
    
  })

  # Show Data Table
  output$data_table <- renderDataTable(data)

})