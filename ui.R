
library(shiny)


shinyUI(fluidPage(
  
  # Application title
  titlePanel("Monte Carlo Polynomial Integration"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
        h4('For Coefficient Format:'),
        h4('y = e*x^4 + d*x^3 + c*x^2 + b*x + a:'),
        
        textInput("e", "Input e:", value = 0),
        textInput("d", "Input d:", value = 0),
        textInput("c", "Input c:", value = 1), 
        textInput("b", "Input b:", value = 0), 
        textInput("a", "Input a:", value = 0),
        
        br(),
        br(),
        h3('Plotting Window:'), 
        textInput('x_min', 'X-min.', value = 0),
        textInput('x_max', 'X-max.', value = 1),
        br(),
        textInput('y_min', 'Y-min.', value = 0),
        textInput('y_max', 'Y-max.', value = 1)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
       plotOutput("mainPlot"),
       textInput("n_pts", "Input Number of Integration Points:", value = 100000),
       br(),
       textInput("left", "Input Left Bound:", value = 0),
       textInput("right", "Input Right Bound:", value = 1),
       actionButton('go', 'Integrate'),
       br(),
       br(),
       p(strong('Result:')),
       textOutput('result'),
       br(),
       br(),
       p(strong('Instructions:')),
       p('Create a polynomial function using the coefficient inputs on the sidebar and adjust the plot window and integration bounds
         as needed. Ensure that the plot window contains both bounds of integration (red vertical lines should be visible) and 
         the entire vertical scale of the function, or errors/miscalculations may result. Then, set the number of random points to 
         calculate with. Note that more adding points will give a more accurate calculation, but will also take more time to run. Also,
         as the area to be approximated increases, more points will be needed for the same level of precision.'),
       
       p('This program integrates a polynomial function using a Monte Carlo technique. 
         Points are randomly generated within the bounds of integration and checked against the y-value of
         the function at their given x-value. The fraction of the points that lie under the curve multiplied by the rectangular
         area over which the points were generated yields the area under the curve. This is a random process and answers will not
         be exact, but they will be good approximations if the number of random points is sufficiently large.')
    )
  )
))
