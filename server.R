library(shiny)
library(shinyjs)
library(httr)
library(jsonlite)

load("data/all_data.rdata")
source("get_user.R")
source("get_characters.R")
source("get_inventory.R")
source("get_talent_grid.R")
source("intel_disc_stre_meter.R")
source("get_items_instance.R")
source("user_tag_output.R")
source("item_output.R")
source("subclass_output.R")

apikey <- "PUT YOUR API KEY HERE!!!"

shinyServer(function(input, output, session) {

  observeEvent(input$getuser, {
    
    disable(id = "console")
    disable(id = "user")  
    toggle(id="getuser")
    
    #This function gets the membership id and the user display name
    getUser <- get.user(CONSOLE = input$console,
                        USER = input$user,
                        API_KEY = apikey)
    
    if(is.null(getUser$membershipId)){
      
      output$errorMessage <- renderText("Oops! User not found!")
      output$changeuser <- renderUI(actionButton("switchuser", label = "Change user"))
    
      } else {
        
        #This function gets the user's characters
        getCharacters <- get.characters(CONSOLE = input$console, 
                                        MEMBERSHIP_ID = getUser$membershipId, 
                                        API_KEY = apikey)
        
        #This code generates the "radio buttons" to select a specific character
        output$selectCharacter <- renderUI({char_all <- list()
                                            for(i in 1:length(getCharacters$classHash)){
                                              class_i <- all_data$DestinyClassDefinition[[getCharacters$classHash[i]]]$className
                                              race_i <- all_data$DestinyRaceDefinition[[getCharacters$raceHash[i]]]$raceName
                                              gender_i <- all_data$DestinyGenderDefinition[[getCharacters$genderHash[i]]]$genderName
                                              name_i <- paste0(class_i," / ",race_i," / ",gender_i)
                                              char_all[name_i] <- getCharacters$characterId[i]
                                              }
                                            radioButtons("character",
                                                         choices = char_all, 
                                                         label = "Select character: ")
                                            })
        
        output$getdatabutton <- renderUI(actionButton("getdata", label = "Get data", style="color: #fff; background-color: #337ab7; border-color: #2e6da4"))
        
        output$changeuser <- renderUI(actionButton("switchuser", label = "Change user"))
        
    }
      
    observeEvent(input$getdata, ignoreNULL = TRUE ,{
      
      characterId <- input$character
        
      withProgress(message = "Getting data",value = 0,min = 0, max = 100, {
        
        #This function gets the items instance id's (unique for each user)    
        getInventory <- get.inventory(CONSOLE = input$console,
                                      MEMBERSHIP_ID = getUser$membershipId,
                                      CHARACTER_ID = characterId,
                                      API_KEY = apikey)
        
        incProgress(10)
        
        #This function gets the subclass talent grid for given character    
        getTalentGrid <- get.talent.grid(CONSOLE = input$console, 
                                         MEMBERSHIP_ID = getUser$membershipId, 
                                         CHARACTER_ID = characterId, 
                                         ITEM_ID = getInventory$itemId[1], 
                                         API_KEY = apikey, 
                                         ALLDATA = all_data)
        
        incProgress(10, detail = "Talent grid")
    
        #This function gets the user's items (unique items)
        getItemsInstance <- get.items.instance(API_KEY = apikey, 
                                               CONSOLE = input$console, 
                                               MEMBERSHIP_ID = getUser$membershipId, 
                                               CHARACTER_ID = characterId,
                                               GETINVENTORY = getInventory, 
                                               ALLDATA = all_data)
        
        incProgress(70)
        
        #This function generates the html for the user's tag
        userTagOutput <- user.tag.output(USER = getUser$displayName, 
                                         CHARACTER_ID = characterId, 
                                         GETCHARACTERS = getCharacters, 
                                         ALLDATA = all_data)
        
        #This function generates the html for the user's subclass talent grid, primary stats, and stats
        subclassOutput <- subclass.output(GETTALENTGRID = getTalentGrid, 
                                          GETCHARACTERS = getCharacters, 
                                          CHARACTERID = characterId, 
                                          GETITEMINSTANCE= getItemsInstance, 
                                          ALLDATA = all_data)
        
        #This function generates the html for the weapons, armor, and other items
        itemOutput <- lapply(getItemsInstance, item.output, ALLDATA=all_data)
        
        ####Outputs (Main Panel)####
        output$userEmblem <- renderUI({userTagOutput})
        
        output$subclassTXT <- renderUI({tags$h4("Subclass: ")})
        output$subclassPanel <- renderUI({wellPanel(fluidRow(column(itemOutput$`Subclass`, width = 2),
                                                             column(subclassOutput$character_primary_stats, width = 3),
                                                             column(subclassOutput$character_stats, width = 2),
                                                             column(subclassOutput$talentNodes, offset = 0, width = 5)))})
        
        output$weaponsTXT <- renderUI({tags$h4("Weapons: ")})
        output$weaponsPanel <- renderUI({wellPanel(fluidRow(column(itemOutput$`Primary Weapons`, width = 4),
                                                            column(itemOutput$`Special Weapons`, width = 4),
                                                            column(itemOutput$`Heavy Weapons`, width = 4)))})
        
        output$armorTXT <- renderUI({tags$h4("Armor: ")})
        output$armorPanel <- renderUI({wellPanel(fluidRow(column(itemOutput$`Helmet`, width = 2),
                                                          column(itemOutput$`Gauntlets`, width = 2),
                                                          column(itemOutput$`Chest Armor`, width = 2),
                                                          column(itemOutput$`Leg Armor`, width = 2),
                                                          column(itemOutput$`Class Armor`, width = 2),
                                                          column(itemOutput$`Artifacts`, width = 2)))})
        
        output$otherTXT <- renderUI({tags$h4("Other: ")})
        output$otherPanel <- renderUI({wellPanel(fluidRow(column(itemOutput$`Ghost`, width = 2),
                                                          column(itemOutput$`Shaders`, width = 2),
                                                          column(itemOutput$`Ships`, width = 2),
                                                          column(itemOutput$`Emotes`, width = 2),
                                                          column(itemOutput$`Vehicle`, width = 2),
                                                          column(itemOutput$`Sparrow Horn`, width = 2)))})
        
        incProgress(10, detail = "Finish")
      })
    })
    observeEvent(input$switchuser,{session$reload()})
  })
})

