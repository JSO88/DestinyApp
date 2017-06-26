
item.output <- function(BUCKET, ALLDATA){

  weapons <- c("Primary Weapons", "Special Weapons", "Heavy Weapons")
  armor <- c("Ghost", "Helmet", "Gauntlets", "Chest Armor", "Leg Armor", "Class Armor", "Artifacts")
  other <- c("Vehicle", "Sparrow Horn", "Ships", "Shaders", "Emblems","Emotes")
  
  url_item <- paste0("http://www.bungie.net",BUCKET$itemIcon)
  itemIcon <- tags$img(src = url_item, width="70", height="70")
  itemName <- BUCKET$itemName
  
  if(BUCKET$bucketName %in% weapons){
    
    light <- tags$div(id="lightbox", BUCKET$primaryStat)
    
    perksHTML <- c()
    
    for(i in 1:length(BUCKET$itemPerks$perkHash)){
      
      perkIcon <- BUCKET$itemPerks$iconPath[i]
      perkHash <- as.character(BUCKET$itemPerks$perkHash[i])
      perkActive <- BUCKET$itemPerks$isActive[i]
      perkName <- ALLDATA$DestinySandboxPerkDefinition[[perkHash]]$displayName
      perkDescription <- ALLDATA$DestinySandboxPerkDefinition[[perkHash]]$displayDescription
      url_perkIcon <- paste0("http://www.bungie.net",perkIcon)
      circle <- ifelse(perkActive,"blue-circle.png","grey-circle.png")
      
      perksHTML[i] <- paste0(tags$div(class=paste0("perk",i), 
                                      tags$img(id="perklogo", src = url_perkIcon, width="15", height="15"),
                                      tags$span(class="descbox", perkDescription,
                                                tags$span(class="namebox", perkName)),
                                      tags$img(id="circle", src = circle, width="21", height="21")))
    }
    
    itemStats <- BUCKET$itemStats$value
    
    rateOfFireDesc <- ALLDATA$DestinyStatDefinition$`4284893193`$statDescription
    impactDesc <- ALLDATA$DestinyStatDefinition$`4043523819`$statDescription
    rangeDesc <- ALLDATA$DestinyStatDefinition$`1240592695`$statDescription
    stabilityDesc <- ALLDATA$DestinyStatDefinition$`155624089`$statDescription
    reloadDesc <- ALLDATA$DestinyStatDefinition$`4188031367`$statDescription
    magazineDesc <- ALLDATA$DestinyStatDefinition$`3871231066`$statDescription
    
    itemStatsHTML <- tags$div(id="statmeters",
                              tags$div(sytle="position: relative;", 
                                       tags$div(class="weaponstatcontainer", 
                                                tags$div(class="weaponstat", "Rate of Fire: "),
                                                tags$div(class="meterw",
                                                         tags$span(style=paste0("width:",itemStats[1],"%"))),
                                                tags$div(id="clear2"),
                                                tags$span(class="descbox", rateOfFireDesc,
                                                          tags$span(class="namebox", paste0("Rate of Fire: ",itemStats[1],"/100"))))),
                              tags$div(sytle="position: relative;", 
                                       tags$div(class="weaponstatcontainer", 
                                                tags$div(class="weaponstat", "Impact: "),
                                                tags$div(class="meterw",
                                                         tags$span(style=paste0("width:",itemStats[2],"%"))),
                                                tags$div(id="clear2"),
                                                tags$span(class="descbox", impactDesc,
                                                          tags$span(class="namebox", paste0("Impact: ",itemStats[2],"/100"))))),
                              tags$div(sytle="position: relative;", 
                                       tags$div(class="weaponstatcontainer", 
                                                tags$div(class="weaponstat", "Range: "),
                                                tags$div(class="meterw",
                                                         tags$span(style=paste0("width:",itemStats[3],"%"))),
                                                tags$div(id="clear2"),
                                                tags$span(class="descbox", rangeDesc,
                                                          tags$span(class="namebox", paste0("Range: ",itemStats[3],"/100"))))),
                              tags$div(sytle="position: relative;", 
                                       tags$div(class="weaponstatcontainer", 
                                                tags$div(class="weaponstat", "Stability: "),
                                                tags$div(class="meterw",
                                                         tags$span(style=paste0("width:",itemStats[4],"%"))),
                                                tags$div(id="clear2"),
                                                tags$span(class="descbox", stabilityDesc,
                                                          tags$span(class="namebox", paste0("Stability: ",itemStats[4],"/100"))))),
                              tags$div(sytle="position: relative;", 
                                       tags$div(class="weaponstatcontainer", 
                                                tags$div(class="weaponstat", "Reload: "),
                                                tags$div(class="meterw",
                                                         tags$span(style=paste0("width:",itemStats[5],"%"))),
                                                tags$div(id="clear2"),
                                                tags$span(class="descbox", reloadDesc,
                                                          tags$span(class="namebox", paste0("Reload: ",itemStats[5],"/100"))))),
                              tags$div(sytle="position: relative;", 
                                       tags$div(class="weaponstatcontainer", 
                                                tags$div(class="weaponstat", "Magazine: "),
                                                tags$div(class="weaponstat",style="text-align: left; font-weight: bold;",itemStats[6]),
                                                tags$span(class="descbox", magazineDesc,
                                                          tags$span(class="namebox", "Magazine")))))
    
    
    itemOutput <- tags$div(id="weaponcontainer", 
                           tags$div(id="iconsweapon", itemIcon, light, HTML(paste(perksHTML, collapse = ""))),
                           itemStatsHTML,
                           tags$p(style="position: absolute; left:6px; bottom:2px; margin:0px; padding:0px;",itemName))
    
    
  } else if (BUCKET$bucketName %in% armor){
    
    light <- tags$div(id="lightbox", BUCKET$primaryStat)
    
    perksHTML <- c()
    
    if(length(BUCKET$itemPerks$perkHash)==0){
      
      perksHTML <- tags$div(class="perk1")
      
    } else {
      
      for(i in 1:length(BUCKET$itemPerks$perkHash)){
        
        perkIcon <- BUCKET$itemPerks$iconPath[i]
        perkHash <- as.character(BUCKET$itemPerks$perkHash[i])
        perkActive <- BUCKET$itemPerks$isActive[i]
        perkName <- ALLDATA$DestinySandboxPerkDefinition[[perkHash]]$displayName
        perkDescription <- ALLDATA$DestinySandboxPerkDefinition[[perkHash]]$displayDescription
        url_perkIcon <- paste0("http://www.bungie.net",perkIcon)
        circle <- ifelse(perkActive,"blue-circle.png","grey-circle.png")
        
        perksHTML[i] <- paste0(tags$div(class=paste0("perk",i), 
                                        tags$img(id="perklogo", src = url_perkIcon, width="15", height="15"),
                                        tags$span(class="descbox", perkDescription,
                                                  tags$span(class="namebox", perkName)),
                                        tags$img(id="circle", src = circle, width="21", height="21")))
        
      }
      
    }
    
    itemOutput <- HTML(paste0(tags$div(id="icons", 
                                 itemIcon, 
                                 light, 
                                 HTML(paste(perksHTML, collapse = ""))),
                              itemName))
    
  } else if (BUCKET$bucketName %in% other){
    
    itemOutput <- HTML(paste0(itemIcon, tags$br(), itemName))
    
  } else {
    
    itemOutput <- HTML(paste0(tags$div(style="margin:auto; position:relative; height:145px; padding:30px;", itemIcon, tags$br(), itemName)))
    
  }

  return(itemOutput)
}
