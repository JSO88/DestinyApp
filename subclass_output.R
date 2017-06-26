
subclass.output <- function(GETTALENTGRID, GETCHARACTERS, CHARACTERID, GETITEMINSTANCE, ALLDATA){
  
  nodes <- c()
  for(i in 1:length(GETTALENTGRID$node)){
    
    if(nchar(GETTALENTGRID$node[i])==2){
      node <- GETTALENTGRID$node[i]  
      circle <- ifelse(GETTALENTGRID$activeNode[i],"blue-circle.png","grey-circle.png")
      nodes[i]<- paste0(tags$div(class=paste0("node", node),
                                 tags$img(id="node", src=GETTALENTGRID$nodeIcon[i], width="25", height="25"),
                                 tags$span(class="descbox", GETTALENTGRID$nodeStepDescription[i],
                                           tags$span(class="namebox", GETTALENTGRID$nodeStepName[i])),
                                 tags$img(id="circle", src=circle, width="31", height="31")))
    } else {
      nodes[i] <- ""
    }
  }
  
  talentNodes <- HTML(paste0(tags$div(id="talentgridcontainer",tags$div(id="talentcontainer", HTML(paste(nodes, collapse = ""))))))
  
  character_index <- which(CHARACTERID==GETCHARACTERS$characterId)
  
  intellectValue <- as.integer(GETCHARACTERS$stats$intellect$value[character_index])
  disciplineValue <- as.integer(GETCHARACTERS$stats$discipline$value[character_index])
  strengthValue <- as.integer(GETCHARACTERS$stats$strength$value[character_index])
  
  url_intellectLogo <- "http://www.bungie.net/common/destiny_content/icons/b5860f840defcf2243aba88a4b125e66.png"
  url_disciplineLogo <- "http://www.bungie.net/common/destiny_content/icons/0bae27ec7fa564a5928e23af11e27b83.png"
  url_strengthLogo <- "http://www.bungie.net/common/destiny_content/icons/0cb8cf4c73f21d1f4c3ab7b3af9193c4.png"
  
  i.d.s.Meter <- intel.disc.stre.meter(INTELLECT = intellectValue, DISCIPLINE = disciplineValue, STRENGTH = strengthValue, GETITEMINSTANCE = GETITEMINSTANCE)
  
  intellect <- HTML(paste0(tags$div(class="meterq",
                                    tags$span(style=paste0("width:",i.d.s.Meter$intellect$stats$intel[1],"%"))),
                           tags$div(class="meterq",
                                    tags$span(style=paste0("width:",i.d.s.Meter$intellect$stats$intel[2],"%"))),
                           tags$div(class="meterq",
                                    tags$span(style=paste0("width:",i.d.s.Meter$intellect$stats$intel[3],"%"))),
                           tags$div(class="meterq",
                                    tags$span(style=paste0("width:",i.d.s.Meter$intellect$stats$intel[4],"%"))),
                           tags$div(class="meterq",
                                    tags$span(style=paste0("width:",i.d.s.Meter$intellect$stats$intel[5],"%"))),
                           tags$div(id="clear")))
  
  discipline <- HTML(paste0(tags$div(class="meterq",
                                     tags$span(style=paste0("width:",i.d.s.Meter$discipline$stats$disc[1],"%"))),
                            tags$div(class="meterq",
                                     tags$span(style=paste0("width:",i.d.s.Meter$discipline$stats$disc[2],"%"))),
                            tags$div(class="meterq",
                                     tags$span(style=paste0("width:",i.d.s.Meter$discipline$stats$disc[3],"%"))),
                            tags$div(class="meterq",
                                     tags$span(style=paste0("width:",i.d.s.Meter$discipline$stats$disc[4],"%"))),
                            tags$div(class="meterq",
                                     tags$span(style=paste0("width:",i.d.s.Meter$discipline$stats$disc[5],"%"))),
                            tags$div(id="clear")))
  
  strength <- HTML(paste0(tags$div(class="meterq",
                                   tags$span(style=paste0("width:",i.d.s.Meter$strength$stats$stre[1],"%"))),
                          tags$div(class="meterq",
                                   tags$span(style=paste0("width:",i.d.s.Meter$strength$stats$stre[2],"%"))),
                          tags$div(class="meterq",
                                   tags$span(style=paste0("width:",i.d.s.Meter$strength$stats$stre[3],"%"))),
                          tags$div(class="meterq",
                                   tags$span(style=paste0("width:",i.d.s.Meter$strength$stats$stre[4],"%"))),
                          tags$div(class="meterq",
                                   tags$span(style=paste0("width:",i.d.s.Meter$strength$stats$stre[5],"%"))),
                          tags$div(id="clear")))
    
  # character_primary_stats <- HTML(paste0(tags$div(class="primarystatcontainer",
  #                                                 tags$h5("Intellect:"), 
  #                                                 intellect,
  #                                                 tags$span(class="primarystatdescbox",tags$p(paste0("Tier ",i.d.s.Meter$intellect$stats$tier,":  ",i.d.s.Meter$intellect$stats$cool," super cooldown time" )), tags$p(i.d.s.Meter$intellect$description),
  #                                                           tags$span(class="primarystatnamebox", paste0("Intellect: ",intellectValue,"/300")))),
  #                                        tags$div(class="primarystatcontainer",
  #                                                 tags$h5("Discipline:"), 
  #                                                 discipline,
  #                                                 tags$span(class="primarystatdescbox",tags$p(paste0("Tier ",i.d.s.Meter$discipline$stats$tier,":  ",i.d.s.Meter$discipline$stats$cool," granade cooldown time" )), tags$p(i.d.s.Meter$discipline$description),
  #                                                           tags$span(class="primarystatnamebox", paste0("Discipline: ",disciplineValue,"/300")))),
  #                                        tags$div(class="primarystatcontainer",
  #                                                 tags$h5("Strength:"), 
  #                                                 strength,
  #                                                 tags$span(class="primarystatdescbox",tags$p(paste0("Tier ",i.d.s.Meter$strength$stats$tier,":  ",i.d.s.Meter$strength$stats$cool," melee cooldown time" )), tags$p(i.d.s.Meter$strength$description),
  #                                                           tags$span(class="primarystatnamebox", paste0("Strength: ",strengthValue,"/300"))))))
  # 
  character_primary_stats <- HTML(paste0(tags$div(class="primarystatbigcontainer",
                                                  tags$div(class="primarystatlogo", 
                                                           tags$img(src=url_intellectLogo, width="40", height="40")),
                                                  tags$div(class="titlemetercontainer",
                                                           tags$div(class="primarystatcontainer",
                                                                    tags$h5(style="margin-top:0px;", "Intellect:"), 
                                                                    intellect,
                                                                    tags$span(class="primarystatdescbox",
                                                                              tags$p(paste0("Tier ",i.d.s.Meter$intellect$stats$tier,":  ",i.d.s.Meter$intellect$stats$cool," super cooldown time" )), tags$p(i.d.s.Meter$intellect$description),
                                                                              tags$span(class="primarystatnamebox", 
                                                                                        paste0("Intellect: ",intellectValue,"/300"))))),
                                                  tags$div(style="clear: both; margin:8px;"),
                                                  tags$div(class="primarystatlogo", 
                                                           tags$img(src=url_disciplineLogo, width="40", height="40")),
                                                  tags$div(class="titlemetercontainer",
                                                           tags$div(class="primarystatcontainer",
                                                                    tags$h5(style="margin-top:0px;", "Discipline:"), 
                                                                    discipline,
                                                                    tags$span(class="primarystatdescbox",
                                                                              tags$p(paste0("Tier ",i.d.s.Meter$discipline$stats$tier,":  ",i.d.s.Meter$discipline$stats$cool," granade cooldown time" )), tags$p(i.d.s.Meter$discipline$description),
                                                                              tags$span(class="primarystatnamebox", 
                                                                                        paste0("Discipline: ",disciplineValue,"/300"))))),
                                                  tags$div(style="clear: both; margin:8px;"),
                                                  tags$div(class="primarystatlogo", 
                                                           tags$img(src=url_strengthLogo, width="40", height="40")),
                                                  tags$div(class="titlemetercontainer",
                                                           tags$div(class="primarystatcontainer",
                                                                    tags$h5(style="margin-top:0px;", "Strength:"), 
                                                                    strength,
                                                                    tags$span(class="primarystatdescbox",
                                                                               tags$p(paste0("Tier ",i.d.s.Meter$strength$stats$tier,":  ",i.d.s.Meter$strength$stats$cool," melee cooldown time" )), tags$p(i.d.s.Meter$strength$description),
                                                                               tags$span(class="primarystatnamebox", 
                                                                                         paste0("Strength: ",strengthValue,"/300"))))),
                                                  tags$div(style="clear: both; margin:7px;"))))
  
  agilityValue <- (as.integer(GETCHARACTERS$stats$agility$value[character_index]))*10
  armorValue <- (as.integer(GETCHARACTERS$stats$armor$value[character_index]))*10
  recoveryValue <- (as.integer(GETCHARACTERS$stats$recovery$value[character_index]))*10
  
  agilityDesc <- ALLDATA$DestinyStatDefinition$`2996146975`$statDescription
  armorDesc <- ALLDATA$DestinyStatDefinition$`392767087`$statDescription
  recoveryDesc <- ALLDATA$DestinyStatDefinition$`1943323491`$statDescription
  
  agility <- tags$div(class="meter",
                      tags$span(style=paste0("width:",agilityValue,"%")))
  armor <- tags$div(class="meter",
                    tags$span(style=paste0("width:",armorValue,"%")))
  recovery <- tags$div(class="meter",
                       tags$span(style=paste0("width:",recoveryValue,"%")))
  
  character_stats <- HTML(paste0(tags$div(class="statscontainer",
                                          tags$div(class="statcontainer",
                                                  tags$h5("Agility:"), 
                                                  agility,
                                                  tags$span(class="statdescbox", 
                                                            agilityDesc,
                                                            tags$span(class="statnamebox", paste0("Agility: ", (agilityValue/10),"/10")))),
                                          tags$div(class="statcontainer",
                                                   tags$h5("Armor:"), 
                                                   armor,
                                                   tags$span(class="statdescbox", 
                                                             armorDesc,
                                                             tags$span(class="statnamebox", paste0("Armor: ", (armorValue/10),"/10")))),
                                          tags$div(class="statcontainer",
                                                   tags$h5("Recovery:"), 
                                                   recovery,
                                                   tags$span(class="statdescbox", 
                                                             recoveryDesc,
                                                             tags$span(class="statnamebox", paste0("Recovery: ", (recoveryValue/10),"/10"))))))) 
                                 
  return(list("talentNodes"=talentNodes, "character_primary_stats"=character_primary_stats, "character_stats"=character_stats))
  
}


