# DestinyApp
Destiny app developed in R Shiny to get a specified user's inventory and stats. 

To use the app just download all files and put your Destiny API Key in the server.R file (in line 17).

App architecture:  
  
There are two main files:  
1.- ui.R: user interface script.  
2.- server.R: server script where all calculations and requests are executed. This script uses all functions described below to get all the user info and to produce the outputs.  

Functions:  
1.- get.user (get_user.R): retrieves the membership ID and display name of the specified user.  
2.- get.characters (get_characters.R): retrieves all the user's characters general information.  
3.- get.inventory (get_inventory.R): retrieves the specified character's general inventory.  
4.- get.talent.grid (get_talent_grid.R): retrieves the talent nodes for the currently active subclass of the specified character.  
5.- get.items.instance (get_items_instance.R): retireves the stats and specific perks of the item.  
6.- user.tag.output (user_tag_output.R): generates the html for the users tag.  
7.- subclass.output (subclass_output): generates the html for the subclass talent grid and the character's statistics.  
8.- item.output (item_output): generates the html for each of the items in the inventory.  
9.- intel.disc.stre.meter (intel_disc_stre_meter.R): generates necessary objects for the character's statistics output.  



