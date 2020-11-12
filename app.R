library(shiny)
library(DT)
library(dplyr)
library(ggplot2)
library(stringr)

cocktails <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-05-26/cocktails.csv') %>%
  mutate(alcoholic = str_replace(alcoholic, "alcohol", "Alcohol"))

mytable<-function(x,y){
   filter(cocktails, category %in% x & alcoholic %in% y)%>%
        select(drink, ingredient, measure, id_drink)
}

ggplot(cocktails, aes(x=category))+ geom_bar() +coord_flip()


a<- ggplot(cocktails, aes(x = alcoholic, color = category)) +
    geom_point(stat = "count", aes(y = ..count..))



ui<-fluidPage(
    titlePanel("Cocktail Category"),
    sidebarPanel(
    selectInput(inputId = "type",
                label="Choose a category",
                choices=unique(cocktails$category)),

    selectInput(inputId = "alcohol",
                label="Choose Alcoholic",
                choices=unique(cocktails$alcoholic))
    ),

    mainPanel(
      plotOutput("plot1"),
      tableOutput("tab1")
    )

)


server <-function(input, output){

    output$plot1 <- renderPlot({
      cocktails %>%
        mutate(selected = category %in% input$type & alcoholic %in% input$alcohol) %>%
        ggplot(aes(x=category, fill = selected))+ geom_bar() +coord_flip()},height = 400,width = 600)

    output$tab1 <- renderTable({
      mytable(input$type, input$alcohol)
    })

}



shinyApp(ui = ui, server = server)
