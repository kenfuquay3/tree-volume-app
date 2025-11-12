library(shiny)

shinyUI(fluidPage(
  
  # App Title
  titlePanel("Tree Volume Estimator"),
  
  # Layout with sidebar and main panel
  sidebarLayout(
    
    # Sidebar with input widgets
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
    
    # Main panel for plot and output
    mainPanel(
      plotOutput("treePlot"),
      h4("Predicted Tree Volume:"),
      textOutput("volumeOut")
    )
  )
))
