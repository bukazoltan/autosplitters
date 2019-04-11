state("hp8")
{
	string30 map: "hp8.exe", 0x04FBBCF; // name of the map you are currently on; changes on every load
	string30 eventChange: "hp8.exe", 0x04DF14F; // value is "playvideo" whenever a cutscene plays
}

init
{

}

startup
{
	settings.Add("levels", true, "Split before these levels get loaded:");
	settings.Add("others", true, "Split when...");
	vars.splitSettings = new List<string> {
		"The Streets of Hogsmeade",
		"Problem with Security",
		"The Basilisk Fang",
		"Job to Do",
		"Giant Problem",
		"The Lost Diadem",
		"The Battle of Hogwarts",
		"Surrender",
		"A Turn of Events",
		"Not my Daughter",
		"Voldemorts Last Stand",
	};
	settings.CurrentDefaultParent = "levels";
	foreach (string splits in vars.splitSettings) {
		settings.Add(splits, true);
	}
	settings.Add("halfsplit", false, "...Neville gets control on a Job to Do.", "others");
	settings.Add("endsplit", true, "...the final cutscene gets triggered", "others");

}

start {
	return current.map == "gringotts" && old.map == "ntend~frontendlocation_eng_gb"; // start is not accurate atm
}

exit {

}

update {
	// only for debugging
	print(current.map);
	print(current.eventChange);
}

split {
	return settings["The Streets of Hogsmeade"] && current.map == "hogsmeade" && old.map == "gringotts" ||
		   settings["Problem with Security"] && current.map == "stairs_hall_comp_boss" && old.map == "hogsmeade" ||
		   settings["The Basilisk Fang"] && current.map == "cos_tunnels" && old.map == "stairs_hall_comp_boss" ||
		   settings["Job to Do"] && current.map == "covered_bridge" && old.map == "cos_room_fca" || // working
		   settings["Giant Problem"] && current.map == "viaduct_courtyrd_complete" && old.map == "covered_bridge_fca" ||
		   settings["The Lost Diadem"] && current.map == "ror" && old.map == "viaduct_courtyrd_complete" ||
		   settings["The Battle of Hogwarts"] && current.map == "battle_1" && old.map == "ror_fca" ||
		   settings["Surrender"] && current.map == "viaduct_court_dam_night" && old.map == "battle_1" ||
		   settings["A Turn of Events"] && current.map == "viaduct_court_dam_boss_2" && old.map == "viaduct_court_dam_night" ||
		   settings["Not my Daughter"] && current.map == "viaduct_court_dam_dawn" && old.map == "viaduct_court_dam_boss_2" ||
		   settings["Voldemorts Last Stand"] && current.map == "battle_1_boss" && old.map == "viaduct_court_dam_dawn" ||
		   settings["halfsplit"] && old.eventChange == "_bridge_planting_charges" && current.eventChange == "_bridge_protect_seamus" ||
		   settings["endsplit"] && old.eventChange == "b_final_harry_voldy_duel" && current.eventChange == "playvideo";
}

reset {
	return current.map == "ntend~frontendlocation_eng_gb" && old.map != "ntend~frontendlocation_eng_gb";
}
