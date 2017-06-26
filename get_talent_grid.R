
get.talent.grid <- function(CONSOLE, MEMBERSHIP_ID, CHARACTER_ID, ITEM_ID, API_KEY, ALLDATA){
  
  base_URL <- "http://www.bungie.net/Platform/Destiny/"
  itemInstanceId_URL <- paste0(base_URL,CONSOLE,"/Account/",MEMBERSHIP_ID,"/Character/",CHARACTER_ID,"/Inventory/",ITEM_ID,"/")
  itemInstanceId_GET <- GET(itemInstanceId_URL, add_headers("X-API-Key"= API_KEY))
  itemInstanceId_GET_parsed <- fromJSON(content(itemInstanceId_GET, as="text"))  
  
  activeNode <- itemInstanceId_GET_parsed$Response$data$item$nodes$isActivated
  
  talentGridHash <- as.character(itemInstanceId_GET_parsed$Response$data$item$talentGridHash)
  
  row <- as.integer(ALLDATA$DestinyTalentGridDefinition[[talentGridHash]]$nodes$row)+1
  column <- as.integer(ALLDATA$DestinyTalentGridDefinition[[talentGridHash]]$nodes$column)
  
  node <- paste0(row, column)
  
  base_icon_URL <- "http://www.bungie.net"
  
  nodeStepName <- c()
  nodeStepDescription <- c()
  nodeIconPath <- c()
  nodeIcon <- c()
  
  for(i in 1:30){
    nodeStepName[i] <- ifelse(is.null(ALLDATA$DestinyTalentGridDefinition[[talentGridHash]]$nodes$steps[[i]]$nodeStepName), "NA", ALLDATA$DestinyTalentGridDefinition[[talentGridHash]]$nodes$steps[[i]]$nodeStepName)
    nodeStepDescription[i] <- ifelse(is.null(ALLDATA$DestinyTalentGridDefinition[[talentGridHash]]$nodes$steps[[i]]$nodeStepDescription), "NA", ALLDATA$DestinyTalentGridDefinition[[talentGridHash]]$nodes$steps[[i]]$nodeStepDescription)
    nodeIconPath[i] <- ifelse(is.null(ALLDATA$DestinyTalentGridDefinition[[talentGridHash]]$nodes$steps[[i]]$icon), "NA", ALLDATA$DestinyTalentGridDefinition[[talentGridHash]]$nodes$steps[[i]]$icon)
    nodeIcon[i] <- paste0(base_icon_URL, nodeIconPath[i])
  }
  
  return(list("row"=row, "column"=column, "node"=node, "nodeStepName"=nodeStepName, "nodeStepDescription"=nodeStepDescription, "nodeIcon"=nodeIcon, "activeNode"=activeNode))
  
}
