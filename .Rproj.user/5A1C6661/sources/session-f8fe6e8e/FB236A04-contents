library(shiny)

shinyUI(fluidPage(
  
  # App title
  titlePanel("Tree Volume Estimator"),
  
  # Sidebar layout
  sidebarLayout(
    
    # Sidebar panel for inputs
    sidebarPanel(
      sliderInput("girthInput",
                  label = "Select Tree Girth (inches):",
                  min = min(trees$Girth),
                  max = max(trees$Girth),
                  value = median(trees$Girth),
                  step = 0.5),
      
      checkboxInput("showModel",
                    label = "Show Regression Line",
                    value = TRUE)
    ),
    
    # Main panel for outputs
    mainPanel(
      plotOutput("treePlot"),
      h4("Predicted Tree Volume (cubic feet):"),
      textOutput("volumeOut")
    )
  )
))
