// Autosplitter done by mczolly and marczeslaw
// Load removal done by Flo203

state("hp8")
{
	string30 map: "hp8.exe", 0x04FBBCF; 		// name of the map you are currently on; changes on every load
	string30 eventChange: "hp8.exe", 0x04DF14F; // value is "playvideo" whenever a cutscene plays
	bool isLoading: 0x51CC94; 					// returns true when there are loads
	float xcoord: 0x4E3BF8;
	//float ycoord: 0x4E3BFC;
	float zcoord: 0x4E3C00;
}

init
{
	vars.final_col = true;
}

startup
{
	var LevelNames = new Dictionary<string, string> 				// <map name, text next to checkbox> 
	{
		{				 "hogsmeade", "The Streets of Hogsmeade"},
		{	 "stairs_hall_comp_boss", "Problem with Security"},
		{			   "cos_tunnels", "The Basilisk Fang"},
		{			"covered_bridge", "Job to Do"},
		{"viaduct_courtyrd_complete", "Giant Problem"},
		{					   "ror", "The Lost Diadem"},
		{				  "battle_1", "The Battle of Hogwarts"},
		{  "viaduct_court_dam_night", "Surrender"},
		{ "viaduct_court_dam_boss_2", "A Turn of Events"},
		{   "viaduct_court_dam_dawn", "Not my Daughter"},
		{			 "battle_1_boss", "Voldemorts Last Stand"}				
	};

	var subMap = new String[,]					// <map name, text next to checkbox, main split name>
	{
		{	 "stairs_hall_dam_boss", "Ginny has finished defending the castle",  "viaduct_court_dam_dawn"},
		{"viaduct_court_dam_boss_3", "We defeated Voldemort at the bridges",     "battle_1_boss"},
		{				  "ror_fca", "Running out of Room of Requirements", 	 "ror"},
		{	 "stairs_hall_complete", "We enter the castle", 		 			 "battle_1"},
		{"viaduct_court_dam_boss_1", "We leave the castle", 					 "battle_1"},
		{		 "forbidden_forest", "We enter the Forest", 					 "viaduct_court_dam_night"},
		{	  "stairs_hall_dam_fca", "We defeated Voldemort for the first time", "viaduct_court_dam_boss_2"},
		{	   "stairs_hall_damage", "We have to escape from Voldemort", 				 "viaduct_court_dam_boss_2"},
		{			 "cos_room_fca", "We have to run out of Chamber", 			 "cos_tunnels"},
		{			 "boathouse", 	 "We defeated Greyback", 				 	 "battle_1"}
	};

	var subEvent = new String[,]			// <old event, current event, text next to checkbox, main split name>
	{
		{"_bridge_planting_charges", "_bridge_protect_seamus",  "Neville gets control",   "covered_bridge"},
		{"_carrows", 				 "_snape", 					"We have to fight Snape", "stairs_hall_comp_boss"}
	};


	settings.Add("load-removal", true, "Enable load removal");
	settings.Add("autostart", true, "Enable autostart (full run)");
	settings.Add("autostartIL", false, "Enable autostart (individual levels)");
	settings.Add("hundo final", true, "Split on the last collectible in hundo's route");
	settings.Add("levels", true, "Split starting segment or on certain event:");

	foreach (var Level in LevelNames)						
		settings.Add(Level.Key, true, Level.Value, "levels");

	for (int i = 0; i < subMap.GetLength(0); i++)
		settings.Add(subMap[i, 0], false, subMap[i, 1], subMap[i, 2]);

	for (int i = 0; i < subEvent.GetLength(0); i++)
		settings.Add(subEvent[i, 0] + subEvent[i, 1], false, subEvent[i, 2], subEvent[i, 3]);

	settings.Add("b_final_harry_voldy_duel" + "playvideo", true, "The final cutscene starts", "battle_1_boss");

}

start {
    return (settings["autostart"] && current.map == "gringotts" && old.map.Contains("ntend~frontendlocation")) ||
    (settings["autostartIL"] && old.isLoading && !current.isLoading && !current.map.Contains("ntend~frontendlocation"));
}

isLoading
{
    return settings["load-removal"] && current.isLoading;
}

split
{
	if (old.map != current.map && !old.map.Contains("ntend~frontendlocation"))
		{ return settings[current.map]; }
	else if (old.eventChange != current.eventChange)
		{ return settings[old.eventChange + current.eventChange]; }
	else if(current.map == "hogsmeade" && vars.final_col
		&& current.xcoord > 117.45 && current.xcoord < 118.25
		&& current.zcoord > -25.15 && current.zcoord < -24.35)
		{ 
			vars.final_col = false;
			return settings["hundo final"]; 
		}
}
