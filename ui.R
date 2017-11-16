#
# This ShinyApp shows how to evaluate and compare
# the quality of linear models.
#

# Use ShinyDashboard
library(shinydashboard)

ui <- dashboardPage(
  
  # Define Header and Sidebar
  dashboardHeader(title = "Linear Models"),
  
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
                              .estimation_button {background-color: #33CE67; width: 100%}
                              .estimation_button:hover {background-color: #1DAA4C}
                              '))),
    
    # Define content for each page
    tabItems(
      
      # Estimation Page
      tabItem(tabName = "estimation",
              fluidRow(
                
                # Add box for graph 
                box(
                  title = "Estimation Plot",
                  solidHeader = TRUE,
                  status = "primary",
                  width = 9,
                  plotOutput("plot")
                  ),
                
                # Add box for Accuracy
                valueBoxOutput("accuracy_box", width = 3),

                # Add box for estimation parameters
                box(
                  width = 3,
                  title = "Estimation Parameters",
                  status = "primary",
                  solidHeader = TRUE,
               
                  # Users can choose between each dataset expect for the x variable
                  selectInput("dataset", "Select a dataset", names(data[,-1])),

                  radioButtons("model", "Choose a function:",
                               c("Linear function" = "linear",
                                 "Quadratic function" = "quadratic",
                                  "Root function" = "root",
                                  "Polynomial 3rd degree" = "polynomial_3")),
                  
                  actionButton("trigger_estimation","Estimate",
                               icon("play"),
                               class="estimation_button"
                               )
                  )
                ),

              h3("Analysis of Residuals"),
              fluidRow(
                # Add box for residual plot 
                box(
                  title = "Residual Plot",
                  solidHeader = TRUE,
                  collapsible = TRUE,
                  status = "primary",
                  width = 12,
                  textOutput("residuals_mean"),
                  plotOutput("residual_plot")
                )),
                

                fluidRow(
                # Add box for residual histogram 
                box(
                  title = "Histogram of Residuals",
                  solidHeader = TRUE,
                  collapsible = TRUE,
                  status = "primary",
                  width = 12,
                  htmlOutput("residuals_minmax"),
                  plotOutput("residuals_histogram")
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
              includeHTML("about.html")
      )
    )
  )
)
