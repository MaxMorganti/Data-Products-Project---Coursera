
library(shiny)

shinyServer(function(input, output) {
   
  output$mainPlot <- renderPlot({
    
    a <- as.numeric(input$a)
    b <- as.numeric(input$b)
    c <- as.numeric(input$c)
    d <- as.numeric(input$d)
    e <- as.numeric(input$e)
    
    x_min <- as.numeric(input$x_min)
    x_max <- as.numeric(input$x_max)
    y_min <- as.numeric(input$y_min)
    y_max <- as.numeric(input$y_max)
    
    bound_left <- as.numeric(input$left)
    bound_right <-as.numeric(input$right)
      
    # draw the histogram with the specified number of bins
    curve(e*x^4 + d*x^3 + c*x^2 + b*x + a, from=x_min, to=x_max, n=1000, xlab="X", ylab="Y", 
            col="blue", lwd=3, main="Function Plot", xlim = c(x_min, x_max), ylim = c(y_min, y_max))
    
    
    abline(h = 0, col = 'black', lwd = 3)
    abline(v = 0, col = 'black', lwd = 3)
    
    #lines for integration bounds
    abline(v = bound_left, col = 'red', lwd = 2)
    abline(v = bound_right, col = 'red', lwd = 2)
    
  })
  
  monte_carlo <- eventReactive(input$go, {
     
      a <- as.numeric(input$a)
      b <- as.numeric(input$b)
      c <- as.numeric(input$c)
      d <- as.numeric(input$d)
      e <- as.numeric(input$e)
      
      bound_left <- as.numeric(input$left)
      bound_right <-as.numeric(input$right)
      y_min <- as.numeric(input$y_min)
      y_max <- as.numeric(input$y_max)
      n_pts <- as.numeric(input$n_pts)
      
      
      inside <- 0
      for(i in 1:n_pts) {
          my_y <- runif(1, y_min, y_max)
          my_x <- runif(1, bound_left, bound_right)
          f_y <- e*(my_x)^4 + d*(my_x)^3 + c*(my_x)^2 + b*(my_x) + a
          
          if(0 < my_y && my_y <= f_y) {
              inside <- inside + 1
          } else if (0 >= my_y && my_y>= f_y) {
              inside <- inside - 1
          }
      }
      (inside/n_pts)*((bound_right-bound_left)*(y_max-y_min))
      
      
  })
  
  
  output$result <- renderText({
      monte_carlo()
  })
  
  
})
