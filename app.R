library(shiny)
library(DT)
library(dplyr)
library(ggplot2)

cocktails <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-05-26/cocktails.csv')

mytable<-function(x,y){
   c<-filter(cocktails, category=="x" & alcoholic=="y")%>%
        select(drink, ingredient, measure, id_drink)
   print (c)
}

ggplot(cocktails, aes(x=category))+ geom_bar() +coord_flip()


a<- ggplot(cocktails, aes(x = alcoholic, color = category)) + 
    geom_point(stat = "count", aes(y = ..count..))



ui<-fluidPage(
    titlePanel("Cocktail Category"),
    sidebarPanel(
    selectInput(inputId = "C", 
                label="Choose a category",
                choices=list("Beer",
                             "Cofee/Tea",
                             "Cocoa",
                             "Cocktail",
                             "Homemade Liquer",
                             "Milk/Float/Shake",
                             "Oridnary Drink",
                             "Punch/Party Drink",
                             "Soft Drink/Soda",
                             "Shot",
                             "Other/Unknown"),
                selected ="Beer"),
    
    selectInput(inputId = "A",
                label="Choose Alcoholic",
                choices=list("Alcoholic",
                             "Non Alcoholic",
                             "Non alcoholic",
                             "Optional alcohol",
                             "NA"),
                selected="Alcoholic")
    ),
    
    mainPanel(plotOutput("plot1")
              
    )
    
)


serve <-function(input, output){
  
    output$plot1 <- renderPlot({
        ggplot(cocktails(), aes(x=category))+ geom_bar() +coord_flip()},height = 400,width = 600)
    
}



shinyApp(ui = ui, server = server)
