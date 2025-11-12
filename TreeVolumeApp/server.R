library(shiny)

shinyServer(function(input, output) {
  
  # Fit a linear regression model once (not reactive)
  model <- lm(Volume ~ Girth, data = trees)
  
  # Predict tree volume based on user-selected girth
  predictedVolume <- reactive({
    predict(model, newdata = data.frame(Girth = input$girthInput))
  })
  
  # Render the scatterplot + optional regression line + predicted point
  output$treePlot <- renderPlot({
    plot(trees$Girth, trees$Volume,
         xlab = "Girth (inches)",
         ylab = "Volume (cubic feet)",
         main = "Tree Volume vs Girth",
         pch = 19, col = "forestgreen", cex = 1.3)
    
    # Add regression line if checked
    if (input$showModel) {
      abline(model, col = "blue", lwd = 2)
    }
    
    # Highlight the predicted point in red
    points(input$girthInput, predictedVolume(),
           col = "red", pch = 19, cex = 2)
  })
  
  # Display predicted volume as text
  output$volumeOut <- renderText({
    paste("Predicted Volume:", round(predictedVolume(), 2), "cubic feet")
  })
})
