#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)


shinyUI(fluidPage(
  
  # Application title
  titlePanel("Predict your body Fat!"),
  h3("Bonus! You will also get a rating!"),
  h3("Enter your age, weight & height and hit the submit button!"),
  
  sidebarLayout(
    sidebarPanel(
      
      sliderInput("InputAge", "What is your age?", 0,100, value = 45),
      sliderInput("InputWeight", "What is your weight (in lbs)?", 0,400, value=145),
      h3("Enter your height"),
      numericInput('InputFt', 'ft', 5, min = 0, max = 7, step = 1),
      numericInput('InputInches', 'in',5, min = 0, max = 11, step = 1),
      submitButton("Submit")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("healthPlot"),
      h3("Predicted Body Fat %: "),
      textOutput("bodyFat"),
      h3("Predicted Rating: "),
      textOutput("rating")
    )
  )
))
