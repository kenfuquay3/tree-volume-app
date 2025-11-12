library(shiny)

shinyUI(fluidPage(
  
  # App title
  titlePanel("Predict Horsepower from MPG"),
  
  # Layout with sidebar and main panel
  sidebarLayout(
    
    # Sidebar: user inputs
    sidebarPanel(
      sliderInput("sliderMPG",
                  "What is the MPG of the car?",
                  min = 10, max = 35, value = 20),
      
      checkboxInput("showModel1", "Show Model 1", value = TRUE),
      checkboxInput("showModel2", "Show Model 2", value = TRUE),
      submitButton("Submit")
    ),
    
    # Main panel: outputs
    mainPanel(
      plotOutput("distPlot"),  # <-- fixed name to match server.R
      h3("Predicted Horsepower from Model 1:"),
      textOutput("pred1"),
      h3("Predicted Horsepower from Model 2:"),
      textOutput("pred2")
    )
  )
))
