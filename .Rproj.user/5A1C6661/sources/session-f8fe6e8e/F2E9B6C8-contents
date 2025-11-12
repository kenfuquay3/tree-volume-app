library(shiny)

shinyServer(function(input, output) {
  
  # Add mpgsp column
  mtcars$mpgsp <- ifelse(mtcars$mpg - 20 > 0, mtcars$mpg - 20, 0)
  
  # Fit models correctly
  model1 <- lm(hp ~ mpg, data = mtcars)
  model2 <- lm(hp ~ mpgsp + mpg, data = mtcars)
  
  # Reactive predictions
  model1pred <- reactive({
    mpgInput <- input$sliderMPG
    predict(model1, newdata = data.frame(mpg = mpgInput))
  })
  
  model2pred <- reactive({
    mpgInput <- input$sliderMPG
    mpgsp <- ifelse(mpgInput - 20 > 0, mpgInput - 20, 0)
    predict(model2, newdata = data.frame(mpg = mpgInput, mpgsp = mpgsp))
  })
  
  output$distPlot <- renderPlot({
    mpgInput <- input$sliderMPG
    
    plot(mtcars$mpg, mtcars$hp,
         xlab = "Miles Per Gallon",
         ylab = "Horsepower",
         bty = "n", pch = 16,
         xlim = c(10, 35), ylim = c(50, 350))
    
    # Add Model 1 line
    if (input$showModel1) {
      abline(model1, col = "red", lwd = 2)
    }
    
    # Add Model 2 line
    if (input$showModel2) {
      mpgVals <- 10:35
      mpgspVals <- ifelse(mpgVals - 20 > 0, mpgVals - 20, 0)
      model2lines <- predict(model2, newdata = data.frame(mpg = mpgVals, mpgsp = mpgspVals))
      lines(mpgVals, model2lines, col = "blue", lwd = 2)
    }
    
    # Add legend and prediction points
    legend(25, 250, c("Model 1 Prediction", "Model 2 Prediction"), pch = 16,
           col = c("red", "blue"), bty = "n", cex = 1.2)
    points(mpgInput, model1pred(), col = "red", pch = 16, cex = 2)
    points(mpgInput, model2pred(), col = "blue", pch = 16, cex = 2)
  })
  
  output$pred1 <- renderText({
    paste("Model 1 Prediction:", round(model1pred(), 2))
  })
  
  output$pred2 <- renderText({
    paste("Model 2 Prediction:", round(model2pred(), 2))
  })
})
