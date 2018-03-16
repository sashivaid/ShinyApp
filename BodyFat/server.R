#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(UsingR)
library(ggplot2)

data(fat)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  calc_height <- reactive({
    input$InputFt *12 + input$InputInches
  })
  
  fat$rating[fat$body.fat <= 10] <- "Athletic"
  fat$rating[fat$body.fat > 10 & fat$body.fat <= 14] <- "Good"
  fat$rating[fat$body.fat > 14 & fat$body.fat <= 20] <- "Acceptable"
  fat$rating[fat$body.fat > 20 & fat$body.fat <= 24] <- "Overweight"
  fat$rating[fat$body.fat > 24] <- "Obese"
  
  fit <- lm(body.fat ~ age + weight + height, data=fat)
  
  calcBodyFat <- reactive({
    predict(fit, newdata = data.frame(age=input$InputAge, 
                                      weight=input$InputWeight, 
                                      height=calc_height()))
  })
  
  output$healthPlot <- renderPlot({
    g <- ggplot(fat, aes(weight, height)) + 
      geom_point(aes(color=rating, size=age))+ 
      geom_smooth(method="lm") + 
      coord_cartesian(ylim=c(60,80)) + 
      labs(title="Scatter Plot of observed data", x="Weight (lbs)", y="Height (in)")
    g
  })
  
  output$bodyFat <- renderText({
    round(calcBodyFat(),2) 
  })
  
  output$rating <- renderText({
    
    if (calcBodyFat() <= 10) {"Athletic"}
    else{
      if(calcBodyFat() <= 14) {"Good"}
      else
      {
        if(calcBodyFat() <= 20) {"Acceptable"}
        else {
          if(calcBodyFat() <= 24) {"Overweight"}
          else {"Obese"}
        }
      }
    }
  })
  
})
