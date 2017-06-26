
get.inventory <- function(CONSOLE, MEMBERSHIP_ID, CHARACTER_ID, API_KEY){
  
  base_URL <- "http://www.bungie.net/Platform/Destiny/"
  inventory_URL <- paste0(base_URL,CONSOLE,"/Account/",MEMBERSHIP_ID,"/Character/",CHARACTER_ID,"/Inventory/Summary/")
  inventory_GET <- GET(inventory_URL, add_headers("X-API-Key"= API_KEY))
  inventory_GET_parsed <- fromJSON(content(inventory_GET, as="text"))
  
  itemHash <- as.character(inventory_GET_parsed$Response$data$items$itemHash)
  itemId <- as.character(inventory_GET_parsed$Response$data$items$itemId)
  damageTypeHash <- as.character(inventory_GET_parsed$Response$data$items$damageTypeHash)
  primaryStat <- inventory_GET_parsed$Response$data$items$primaryStat
  
  return(list("itemHash"=itemHash, "itemId"=itemId, "damageTypeHash"=damageTypeHash, "primaryStat"=primaryStat))
  
}