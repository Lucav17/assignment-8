library(plotly)
library(shiny)
library(dplyr)

#Store the data frame in a new data frame.
data_iris <- data.frame(iris)

shinyServer(function(input, output) {
  #Create an adjustable graph that depends on user input
  output$graph <- renderPlotly({
    
    #filter the data based on user input for species
    data_species <- switch(input$species, 
                           "setosa" = data_iris %>% filter(Species == "setosa"),
                           "versicolor" = data_iris %>% filter(Species == "versicolor"),
                           "virginica" = data_iris %>% filter(Species == "virginica"))
    
    
    #select which width column
    datax <- switch(input$typex, 
                   "Sepal Width" = data_species$Sepal.Width,
                   "Petal Width" = data_iris$Petal.Width)
    
    #select which length column
    datay <- switch(input$typey, 
                    "Sepal Length" = data_species$Sepal.Length,
                    "Petal Length" = data_iris$Petal.Length)
    
    #Create the graph that adjusts its labels and shows the area information when hovering over the columns.
    plot_ly(
      x = datax,
      y = datay,
      text = paste('Total Area: ', datay * datax),
      name = "Flower Graph",
      type = "bar"
    ) %>%  layout(title = paste(input$typex, "Vs", input$typey), 
                  xaxis = list(title = paste(input$typex, "in Centimeters")),
                  yaxis = list(title = paste(input$typey, "in Centimeters")))
    
})
}
)
