#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)
library(dplyr)
library(tidyr)
library(ggplot2)

        # server.R — MPG Estimator
        sds <- sapply(scale_df[cols], attr, which = "scaled:scale")
        
        
        spec_scaled <- (c(wt = spec$wt, hp = spec$hp, cyl = spec$cyl, am = spec$am) - means) / sds
        
        
        dists <- scale_df |>
          mutate(dist = sqrt((wt - spec_scaled["wt"])^2 +
                               (hp - spec_scaled["hp"])^2 +
                               (cyl - spec_scaled["cyl"])^2 +
                               (am - spec_scaled["am"])^2)) |>
          arrange(dist)
        
        
        dists |> select(name, mpg, wt, hp, cyl, am) |> head(k)
        }


shinyServer(function(input, output, session) {
  # bundle inputs into a reactive list triggered by button
  spec <- eventReactive(input$go, {
    list(
      cyl = as.integer(input$cyl),
      am = as.integer(input$am),
      hp = as.numeric(input$hp),
      wt = as.numeric(input$wt)
    )
  }, ignoreInit = TRUE)
  
  
  # prediction reactive
  pred <- reactive({
    req(spec())
    newdata <- data.frame(
      wt = spec()$wt,
      hp = spec()$hp,
      cyl = factor(spec()$cyl, levels = c(4, 6, 8)),
      am = factor(spec()$am, levels = c(0, 1))
    )
    as.data.frame(predict(mpg_model, newdata = newdata, interval = "prediction"))
  })
  
  
  output$pred_text <- renderText({
    req(pred())
    sprintf("%.1f mpg", pred()[["fit"]])
  })
  
  
  output$pi_text <- renderText({
    req(pred())
    sprintf("[%.1f, %.1f] mpg", pred()[["lwr"]], pred()[["upr"]])
  })
  
  
  output$diag_plot <- renderPlot({
    fitted <- fitted(mpg_model)
    ggplot(data.frame(obs = mtcars$mpg, fit = fitted), aes(fit, obs)) +
      geom_point(color = "steelblue", size = 2) +
      geom_abline(slope = 1, intercept = 0, color = "red") +
      labs(x = "Model-predicted mpg", y = "Observed mpg") +
      theme_minimal(base_size = 13)
  })
  
  
  output$neighbors <- renderTable({
    req(spec())
    k <- 5
    neigh <- find_neighbors(spec(), k = k)
    names(neigh) <- c("Car", "mpg", "wt (1000lb)", "hp", "cyl", "am")
    neigh
  }, striped = TRUE, bordered = TRUE, hover = TRUE)
})