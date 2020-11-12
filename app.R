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
    sidebarPanel(
    titlePanel("Cocktail Category"),
    
    selectInput(inputId = "C", 
                label="Pick a category",
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
    
    mainPanel(plotOutput("myplot")
              
    )
    
)


serve <-function(input, output){
    mytable<-function(x,y){
        c<-filter(cocktails, category=="x" & alcoholic=="y")%>%
            select(drink, ingredient, measure, id_drink)
        print (c)
    }
    
    output$myplot <- renderPlot({ggplot(cocktails, aes(x = alcoholic, color = category)) + 
            geom_point(stat = "count", aes(y = ..count..))})
    
    
    output$table <- renderTable({
    mytable(input$C, input$A)
        })
}



shinyApp(ui = ui, server = server)
