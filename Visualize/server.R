library(shiny)

shinyServer(function(input, output, session) {
  
  # Reactive linear model based on brushed data
  model1 <- reactive({
    brushed_data <- brushedPoints(trees, input$brush1, xvar = "Girth", yvar = "Volume")
    
    if (nrow(brushed_data) < 2) {
      return(NULL)
    }
    
    lm(Volume ~ Girth, data = brushed_data)
  })
  
  # Output: slope of the model (Girth coefficient)
  output$slopeOut <- renderText({
    if (is.null(model1())) {
      "No Model Found"
    } else {
      slope <- coef(model1())[2]
      paste("Slope (Girth coefficient):", round(slope, 3))
    }
  })
  
  # Output: scatterplot with optional model line
  output$plot1 <- renderPlot({
    plot(trees$Girth, trees$Volume,
         xlab = "Girth", ylab = "Volume",
         main = "Tree Measurements",
         cex = 1.5, pch = 16, bty = "n")
    
    if (!is.null(model1())) {
      abline(model1(), col = "blue", lwd = 2)
    }
  })
})
