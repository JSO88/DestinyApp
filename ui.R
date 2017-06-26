library(shiny)
library(shinyjs)

shinyUI(fluidPage(
  tags$head(tags$link(rel="stylesheet", type="text/css", href="bootstrap.min.css"),
            tags$link(rel="stylesheet", type="text/css", href="custom.css")),
  
  useShinyjs(),
  
  titlePanel("Destiny App"),
  
  sidebarLayout(
    sidebarPanel(width=3,
      radioButtons("console",label = "Console: ", choices = list("PlayStation"=2,"Xbox"=1),inline = TRUE),
      textInput("user", label = "User Name: ", value = "TJSari"),
      actionButton("getuser", label = "Search user",style="color: #fff; background-color: #337ab7; border-color: #2e6da4"),
      
      uiOutput("selectCharacter"),
      
      div(style="display:inline-block", uiOutput("getdatabutton")),
      div(style="display:inline-block", uiOutput("changeuser"))
      ),
    
    mainPanel(width=9,
              textOutput("errorMessage"),

      uiOutput("userEmblem"),
      
      uiOutput("subclassTXT"),
      uiOutput("subclassPanel"),
      
      uiOutput("weaponsTXT"),
      uiOutput("weaponsPanel"),
      
      uiOutput("armorTXT"),
      uiOutput("armorPanel"),
      
      uiOutput("otherTXT"),
      uiOutput("otherPanel")
      
    )
  )
))
