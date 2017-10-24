#
# This ShinyApp shows primarily how to improve the UI
# and UX of ShinyApps in general.
#
# Technically, it can be used to estimate a quadratic function.
# 

# Use ShinyDashboard
library(shinydashboard)

ui <- dashboardPage(
  
  # Define Header and Sidebar
  dashboardHeader(title = "Estimation"),
  
  dashboardSidebar(
    sidebarMenu(
      menuItem("Estimation", tabName = "estimation", icon = icon("bar-chart")),
      menuItem("Data", tabName = "data", icon = icon("database")),
      menuItem("About", tabName = "about", icon = icon("info-circle"))
    )
  ),
  

  dashboardBody(
    
    # Define CSS style for the estimation button
    tags$head(tags$style(HTML('
                              .estimation_button {background-color: #ffab00; width: 100%}
                              .estimation_button:hover {background-color: #ff8f00}
                              '))),
    
    # Define content for each page
    tabItems(
      
      # Estimation Page
      tabItem(tabName = "estimation",
              fluidRow(
                
                # Add box for graph 
                box(
                  status = "primary",
                  width = 9,
                  plotOutput("plot")
                  ),
                
                # Add box for Accuracy
                valueBoxOutput("accuracy_box", width = 3),
                
                # # Add box for Accuracy
                # infoBox(
                #   width = 3,
                #   "Accuracy", textOutput("estimation_results"),
                #   icon = icon("tachometer")),
                
                # Add box for estimation parameters
                box(
                  width = 3,
                  title = "Estimation Parameters",
                  status = "primary",
                  solidHeader = TRUE,
                  
                  radioButtons("model", "Choose a function:",
                               c("Linear function" = "linear",
                                 "Quadratic function" = "quadratic")),
                  
                  actionButton("trigger_estimation","Start estimation",
                               icon("play"),
                               class="estimation_button"
                               )
                  )
                )
              ),

      # Data Page
      tabItem(tabName = "data",
              h2("Data"),
              dataTableOutput("data_table")
      ),
      
      # About Page
      tabItem(tabName = "about",
              h2("About this App"),
              p("More is comming soon")
      )
    )
  )
)