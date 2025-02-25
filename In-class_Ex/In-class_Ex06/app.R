# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

pacman::p_load(shiny, tidyverse)

exam <- read.csv("data/Exam_data.csv")

# Define UI -------------------------------------------------
ui <- fluidPage(

    # Application title
    titlePanel("Pupils Exam results Dashboard"),

    sidebarLayout(
        sidebarPanel(
          selectInput(inputId = "variable",
                      label = "Subject",
                      choices = c("Engish" = "ENGLISH",
                                  "Maths" = "MATHS",
                                  "Science" = "SCIENCE"),
                      selected = "ENGLISH"),
          sliderInput(inputId = "bins",
                      label = "Number of Bins",
                      min = 5,
                      max = 20,
                      value = 10)
                      ),
        mainPanel(
            plotOutput("distPlot")
        )
    )
)

# Define server -------------------------------------------------
server <- function(input, output) {
    output$distPlot <- renderPlot({
       ggplot(exam, aes_string(x = input$variable)) +
          geom_histogram(bins = input$bins,
                         color = "black",
                         fill = "light blue")
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
