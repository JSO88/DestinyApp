
get.characters <- function(CONSOLE, MEMBERSHIP_ID, API_KEY){
  
  base_URL <- "http://www.bungie.net/Platform/Destiny/"
  characters_URL <- paste0(base_URL,CONSOLE,"/Account/",MEMBERSHIP_ID,"/Summary/")
  characters_GET <- GET(characters_URL, add_headers("X-API-Key"= API_KEY))
  characters_GET_parsed <- fromJSON(content(characters_GET, as = "text"))
  
  characterId <- characters_GET_parsed$Response$data$characters$characterBase$characterId
  classHash <- as.character(characters_GET_parsed$Response$data$characters$characterBase$classHash)
  raceHash <- as.character(characters_GET_parsed$Response$data$characters$characterBase$raceHash)
  genderHash <- as.character(characters_GET_parsed$Response$data$characters$characterBase$genderHash)
  characterLevel <- characters_GET_parsed$Response$data$characters$characterLevel
  emblemPath <- characters_GET_parsed$Response$data$characters$emblemPath
  backgroundPath <- characters_GET_parsed$Response$data$characters$backgroundPath
  dateLastPlayed <- characters_GET_parsed$Response$data$characters$characterBase$dateLastPlayed
  powerLevel <- characters_GET_parsed$Response$data$characters$characterBase$powerLevel
  grimoireScore <- characters_GET_parsed$Response$data$characters$characterBase$grimoireScore
  
  STAT_INTELLECT <- characters_GET_parsed$Response$data$characters$characterBase$stats$STAT_INTELLECT
  STAT_DISCIPLINE <- characters_GET_parsed$Response$data$characters$characterBase$stats$STAT_DISCIPLINE
  STAT_STRENGTH <- characters_GET_parsed$Response$data$characters$characterBase$stats$STAT_STRENGTH
  STAT_ARMOR <- characters_GET_parsed$Response$data$characters$characterBase$stats$STAT_ARMOR
  STAT_AGILITY <- characters_GET_parsed$Response$data$characters$characterBase$stats$STAT_AGILITY
  STAT_RECOVERY <- characters_GET_parsed$Response$data$characters$characterBase$stats$STAT_RECOVERY
  STAT_OPTICS <- characters_GET_parsed$Response$data$characters$characterBase$stats$STAT_OPTICS
  STAT_DEFENSE <- characters_GET_parsed$Response$data$characters$characterBase$stats$STAT_DEFENSE
  
  stats <- list("intellect"=STAT_INTELLECT, "discipline"=STAT_DISCIPLINE, "strength"=STAT_STRENGTH,
                "armor"=STAT_ARMOR, "agility"=STAT_AGILITY, "recovery"=STAT_RECOVERY, "optics"=STAT_OPTICS, "defense"=STAT_DEFENSE)
  
  return(list("characterId"=characterId, "classHash"=classHash, "raceHash"=raceHash, "genderHash"=genderHash,
              "characterLevel"=characterLevel, "emblemPath"=emblemPath, "backgroundPath"=backgroundPath,
              "dateLastPlayed"=dateLastPlayed, "powerLevel"=powerLevel, "grimoireScore"=grimoireScore,
              "stats"=stats))
}
