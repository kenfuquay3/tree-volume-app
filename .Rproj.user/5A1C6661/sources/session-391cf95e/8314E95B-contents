library(shiny)

# Define server logic
shinyServer(function(input, output) {
  
  # Fit the linear model using the trees dataset
  model <- lm(Volume ~ Girth, data = trees)
  
  # Reactive expression to compute predicted volume based on input
  predictedVolume <- reactive({
    predict(model, newdata = data.frame(Girth = input$girthInput))
  })
  
  # Render the plot with optional regression line
  output$treePlot <- renderPlot({
    plot(trees$Girth, trees$Volume,
         xlab = "Girth (inches)", ylab = "Volume (cubic feet)",
         main = "Tree Volume vs Girth",
         pch = 19, col = "forestgreen", cex = 1.3)
    
    # Show regression line if checkbox is selected
    if (input$showModel) {
      abline(model, col = "blue", lwd = 2)
    }
    
    # Add the predicted point
    points(input$girthInput, predictedVolume(), col = "red", pch = 19, cex = 2)
  })
  
  # Render the predicted volume as text
  output$volumeOut <- renderText({
    paste("Predicted Volume:", round(predictedVolume(), 2), "cubic feet")
  })
})
