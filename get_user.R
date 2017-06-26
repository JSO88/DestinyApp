
get.user <- function(CONSOLE, USER, API_KEY){
  
  user_URL <- paste0("http://www.bungie.net/Platform/Destiny/SearchDestinyPlayer/",CONSOLE,"/",USER,"/")
  
  user_GET <- GET(user_URL, add_headers("X-API-Key"= API_KEY))
  
  user_GET_parsed <- fromJSON(content(user_GET, as="text"))
  
  membershipId <- user_GET_parsed$Response$membershipId
  
  displayName <- user_GET_parsed$Response$displayName
  
  return(list("membershipId"=membershipId, "displayName"=displayName))
}
