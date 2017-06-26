
user.tag.output <- function(USER, CHARACTER_ID, GETCHARACTERS, ALLDATA){
  
  character_index <- which(CHARACTER_ID==GETCHARACTERS$characterId)
  
  char_class <- ALLDATA$DestinyClassDefinition[[GETCHARACTERS$classHash[character_index]]]$className
  grimoire <- GETCHARACTERS$grimoireScore[character_index]
  light <- GETCHARACTERS$powerLevel[character_index]
  level <- GETCHARACTERS$characterLevel[character_index]
  url_emblem <- paste0("http://www.bungie.net", GETCHARACTERS$emblemPath[character_index])
  url_emblem_background <- paste0("http://www.bungie.net", GETCHARACTERS$backgroundPath[character_index])
  
  user_html <- paste0('<p id=userName >',USER, '</p>')
  class_html <- paste0('<p id=c_class >',char_class,'</p>')
  grimoire_html <- paste0('<p id=grimoire >',grimoire,'</p>')
  light_html <- paste0('<p id=light >',light, '</p>')
  level_html <- paste0('<p id=c_level >',level, '</p>')
  emblem_html <- paste0('<img id="emblemlogo" src="',url_emblem,'">')
  emblem_background_html <- paste0('<img id="emblem_bkgrd" src="',url_emblem_background,'">')
  
  userTagOutput <- paste0('<div id="tagcontainer">',
                            emblem_background_html,
                            emblem_html,
                            user_html,
                            class_html,
                            '<img id="grimoirepng" src="grimoire.png" width="13" height="13"/>',
                            grimoire_html,
                            '<img id="lightstar" src="lightstar.png" width="13" height="13"/>',
                            light_html,
                            level_html,
                          '</div>')
  
  return(HTML(userTagOutput))
  
}
