
get.items.instance <- function(API_KEY, CONSOLE, MEMBERSHIP_ID, CHARACTER_ID, GETINVENTORY, ALLDATA){
  
  itemId <- GETINVENTORY$itemId
  
  base_URL <- paste0("http://www.bungie.net/Platform/Destiny/", CONSOLE, "/Account/",MEMBERSHIP_ID,"/Character/",CHARACTER_ID,"/Inventory/")
  
  itemsInstance <- list()
  
  for(i in 1:length(itemId)){
    
    itemInstanceId_URL <- paste0(base_URL, itemId[i],"/")
    itemInstanceId_GET <- GET(itemInstanceId_URL, add_headers("X-API-Key"= API_KEY))
    itemInstanceId_GET_parsed <- fromJSON(content(itemInstanceId_GET, as="text"))   
    
    itemHash <- as.character(itemInstanceId_GET_parsed$Response$data$item$itemHash)
    
    bucketTypeHash <- as.character(ALLDATA$DestinyInventoryItemDefinition[[itemHash]]$bucketTypeHash)
    
    bucketName <- ALLDATA$DestinyInventoryBucketDefinition[[bucketTypeHash]]$bucketName
    
    itemName <- ALLDATA$DestinyInventoryItemDefinition[[itemHash]]$itemName
    
    itemIcon <- ALLDATA$DestinyInventoryItemDefinition[[itemHash]]$icon
    
    nodeActivated <- itemInstanceId_GET_parsed$Response$data$talentNodes$isActivated
    
    primaryStat <- itemInstanceId_GET_parsed$Response$data$item$primaryStat$value
    
    itemStats <- itemInstanceId_GET_parsed$Response$data$item$stats
    
    itemTalentGridComplete <- itemInstanceId_GET_parsed$Response$data$item$isGridComplete
    
    itemTalentGridHash <- itemInstanceId_GET_parsed$Response$data$item$talentGridHash
    
    itemPerks <- itemInstanceId_GET_parsed$Response$data$item$perks
    
    damageTypeHash <- as.character(itemInstanceId_GET_parsed$Response$data$item$damageTypeHash)
    
    damageTypeIcon <- ALLDATA$DestinyDamageTypeDefinition[[damageTypeHash]]$iconPath
    
    itemsInstance[[bucketName]] <- list("bucketName"=bucketName,
                                        "itemHash"=itemHash,
                                        "itemId"=itemId[i],
                                        "itemName"=itemName,
                                        "itemIcon"=itemIcon,
                                        "nodeActivated"=nodeActivated, 
                                        "primaryStat"=primaryStat, 
                                        "itemStats"=itemStats, 
                                        "itemTalentGridComplete"=itemTalentGridComplete , 
                                        "itemTalentGridHash"=itemTalentGridHash, 
                                        "itemPerks"=itemPerks,
                                        "damageTypeIcon"=damageTypeIcon)
    
    incProgress((70/17), detail = bucketName)
  }
  
  return(itemsInstance)
  
}



