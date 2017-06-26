
intel.disc.stre.meter <- function(INTELLECT, DISCIPLINE, STRENGTH, GETITEMINSTANCE){
  
  intellectDescription <- "Decreases the cooldown of your super ability.\n\nIntellect can be increased by your Armor."
  disciplineDescription <- "Decreases the cooldown time of your grenades, allowing you to use them more often.\n\nFind and equip armor with Discipline to boost this effect."
  strengthDescription <- "Reduces the cooldown time of your melee ability, allowing you to use it more often.\n\nFind and equip armor with Strength to boost this effect."
  
  intellect_floor <- floor(INTELLECT/60)
  discipline_floor <- floor(DISCIPLINE/60)
  strength_floor <- floor(STRENGTH/60)
  
  intellect_dec <- ((INTELLECT/60)-intellect_floor)*100
  discipline_dec <- ((DISCIPLINE/60)-discipline_floor)*100
  strength_dec <- ((STRENGTH/60)-strength_floor)*100
  
  subclass <- GETITEMINSTANCE$`Subclass`$itemName
  
  subclass_super <- c("Defender", "Nightstalker", "Striker", "Sunsinger")
  
  subclass_slow_melee <- c("Nightstalker", "Gunslinger")
  
  if(subclass %in% subclass_super){
    super <- c("5:00","4:46","4:31","4:15","3:58","3:40")
  } else {
    super <- c("5:30","5:14","4:57","4:39","4:20","4:00")
  }
  
  if(subclass %in% subclass_slow_melee){
    melee <- c("1:10","1:04","0:57","0:49","0:40","0:29")
  } else {
    melee <- c("1:00","0:55","0:49","0:42","0:34","0:25")
  }
  
  granade <- c("1:00","0:55","0:49","0:42","0:34","0:25")
  
  intel <- switch(intellect_floor+1,
                  list("intel"=c(intellect_dec,0,0,0,0), "tier"=0, "cool"=super[1]),
                  list("intel"=c(100,intellect_dec,0,0,0), "tier"=1, "cool"=super[2]),
                  list("intel"=c(100,100,intellect_dec,0,0), "tier"=2, "cool"=super[3]),
                  list("intel"=c(100,100,100,intellect_dec,0), "tier"=3, "cool"=super[4]),
                  list("intel"=c(100,100,100,100,intellect_dec), "tier"=4, "cool"=super[5]),
                  list("intel"=c(100,100,100,100,100), "tier"=5, "cool"=super[6]))
  
  disc <- switch(discipline_floor+1,
                 list("disc"=c(discipline_dec,0,0,0,0), "tier"=0, "cool"=granade[1]),
                 list("disc"=c(100,discipline_dec,0,0,0), "tier"=1, "cool"=granade[2]),
                 list("disc"=c(100,100,discipline_dec,0,0), "tier"=2, "cool"=granade[3]),
                 list("disc"=c(100,100,100,discipline_dec,0), "tier"=3, "cool"=granade[4]),
                 list("disc"=c(100,100,100,100,discipline_dec), "tier"=4, "cool"=granade[5]),
                 list("disc"=c(100,100,100,100,100), "tier"=5, "cool"=granade[6]))
  
  stre <- switch(strength_floor+1,
                 list("stre"=c(strength_dec,0,0,0,0), "tier"=0, "cool"=melee[1]),
                 list("stre"=c(100,strength_dec,0,0,0), "tier"=1, "cool"=melee[2]),
                 list("stre"=c(100,100,strength_dec,0,0), "tier"=2, "cool"=melee[3]),
                 list("stre"=c(100,100,100,strength_dec,0), "tier"=3, "cool"=melee[4]),
                 list("stre"=c(100,100,100,100,strength_dec), "tier"=4, "cool"=melee[5]),
                 list("stre"=c(100,100,100,100,100), "tier"=5, "cool"=melee[6]))
  
  return(list("intellect" = list("stats" = intel, "description" = intellectDescription), 
              "discipline" = list("stats" = disc, "description" = disciplineDescription), 
              "strength" = list("stats" = stre, "description" = strengthDescription)))

}
