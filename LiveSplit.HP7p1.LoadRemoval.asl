//Autosplitter made by marczeslaw, splits to use with all boxes ticked: https://drive.google.com/file/d/1RJV_dFLZxwIwVk5n7h_Bdhp1x8ylq8ly/view?usp=sharing

state("hp7")
{
	string30 beforeLoad: "hp7.exe", 0x0393F7F; // name of the map you are currently on; changes before load
	string30 afterLoad: "hp7.exe", 0x0397DDB; // name of the map you are currently on; changes after load
	string4 eventChange: "hp7.exe", 0x03B41F0; // describes which section of the map you're on, changes to "play" when cutscene starts
	bool isLoading1: 0x39C110;
	bool isLoading2: 0x39C0F8;
}

init
{
	vars.checker = true; 
}

startup
{
	settings.Add("levels", true, "Split after these levels:");
	settings.Add("others", true, "Split when...");
	vars.splitSettings = new List<string> {
		"Intro (Seven Potters)",
		"The Cafe",
		"Grimmauld Place",
		"Mini Quest 1 (Reactors)",
		"Mini Quest 2 (The Ruins)",
		"Mini Quest 3 (Dragon)",
		"Outside the Ministry",
		"Atrium Level (Ministry)",
		"Looking for Umbridge's office (Ministry)",
		"Coutrooms (Ministry)",
		"Escape from the Ministry",
		"Dean part 1",
		"Dean part 2",
		"Mini Quest 4 (Ministry)",
		"Mini Quest 5 (Spiders)",
		"Mini Quest 6",
		"Godric's Hollow",
		"Mini Quest 7 (Snatcher Camp)",
		"Mini Quest 8",
		"Mini Quest 9 (Godric's Hollow)",
		"The Silver Doe",
		"The way back",
		"Getting back to camp",
		"Lovegood house (intro)",
		"Lovegood house (inside)",
		"Lovegood house (escape)"
	};
	settings.CurrentDefaultParent = "levels";
	foreach (string splits in vars.splitSettings) {
		settings.Add(splits, true);
	}
	settings.Add("endsplit", true, "...the final cutscene gets triggered", "others");
	settings.Add("umbridge", false, "...when the cutscene starts after defeating Umbridge.", "others");
	settings.Add("Enter Cafe", false, "...when you enter Cafe.", "others");
	settings.Add("neckless", false, "...when you start and finish fight with horcrux (2 splits).", "others");

}

update {
	// only for debugging
	print(current.beforeLoad);
	print(current.afterLoad);
	print(current.eventChange);
	if (current.beforeLoad == "malfoymanor_end")
	{	if (old.eventChange == "ma1" && current.eventChange == "play") 
			{vars.checker = !vars.checker;}
		else if (old.beforeLoad.Contains("frontendlocation")) 
			{vars.checker = true;}
	}
}

start
{
	return old.beforeLoad != current.beforeLoad && current.beforeLoad == "theskies";
}

isLoading
{
    return current.isLoading1 || current.isLoading2;
}    

split {
	return settings["Intro (Seven Potters)"] && current.beforeLoad == "theburrow" && old.beforeLoad == "theskies" ||
		   settings["The Cafe"] && current.beforeLoad == "grimauld_place" && old.beforeLoad == "shaftesburyavenue" ||
		   settings["Grimmauld Place"] && current.beforeLoad == "mixedforest1" && old.beforeLoad == "grimauld_place" ||
		   settings["Mini Quest 1 (Reactors)"] && current.beforeLoad == "mixedforest6_refugee" && old.beforeLoad != "mixedforest6_refugee" ||
		   settings["Mini Quest 2 (The Ruins)"] && current.beforeLoad == "mixedforest3_dragon" && old.beforeLoad != "mixedforest3_dragon" ||
		   settings["Mini Quest 3 (Dragon)"] && current.beforeLoad == "whitehall" && old.beforeLoad != "whitehall" ||
		   settings["Outside the Ministry"] && current.beforeLoad == "atriumlevel" && old.beforeLoad == "whitehall" ||
		   settings["Atrium Level (Ministry)"] && current.beforeLoad == "umbridgefloor" && old.beforeLoad != "umbridgefloor" ||
		   settings["Looking for Umbridge's office (Ministry)"] && current.beforeLoad == "courtroomlevel" && old.beforeLoad != "courtroomlevel" ||
		   settings["Coutrooms (Ministry)"] && current.beforeLoad == "atriumlevel" && old.beforeLoad == "courtroomlevel" ||
		   settings["Escape from the Ministry"] && current.beforeLoad == "mixedforest2" && old.beforeLoad != "mixedforest2" ||
		   settings["Dean part 1"] && current.beforeLoad == "mixedforest1" && old.beforeLoad != "mixedforest1" ||
		   settings["Dean part 2"] && current.beforeLoad == "detentionfloor" && old.beforeLoad != "detentionfloor" ||
		   settings["Mini Quest 4 (Ministry)"] && current.beforeLoad == "forestofdean3" && old.beforeLoad != "forestofdean3" ||
		   settings["Mini Quest 5 (Spiders)"] && current.beforeLoad == "forestofdean4_quarry" && old.beforeLoad != "forestofdean4_quarry" ||
		   settings["Mini Quest 6"] && current.beforeLoad == "godricshollow" && old.beforeLoad == "mixedforest1" ||
		   settings["Godric's Hollow"] && current.beforeLoad == "bathildabagshots" && old.beforeLoad != "bathildabagshots" ||
		   settings["Mini Quest 7 (Snatcher Camp)"] && current.beforeLoad == "forestofdean5_inferi" && old.beforeLoad != "forestofdean5_inferi" ||
		   settings["Mini Quest 8"] && current.beforeLoad == "godricshollow" && old.beforeLoad == "forestofdean5_inferi" ||
		   settings["Mini Quest 9 (Godric's Hollow)"] && current.beforeLoad == "forestofdean1" && old.beforeLoad == "mixedforest4_snatcher" ||
		   settings["The Silver Doe"] && current.beforeLoad == "forestofdean2" && old.beforeLoad == "forestofdean1_b" ||
		   settings["The way back"] && old.beforeLoad == "forestofdean2" && current.beforeLoad == "forestofdean1_b" ||
		   settings["Getting back to camp"] && current.beforeLoad == "lovegoodshouse~outside" && old.beforeLoad == "forestofdean1" ||
		   settings["Lovegood house (intro)"] && current.beforeLoad == "lovegoodshouse~inside" && old.beforeLoad == "lovegoodshouse~outside" ||
		   settings["Lovegood house (inside)"] && current.beforeLoad == "lovegoodshouse~outside" && old.beforeLoad == "lovegoodshouse~inside" ||
		   settings["Lovegood house (escape)"] && current.beforeLoad == "mixedforest4_snatcher" && old.beforeLoad == "lovegoodshouse~outside" ||

		   settings["endsplit"] && old.eventChange == "ma1" && current.eventChange == "play" && vars.checker ||
		   settings["Enter Cafe"] && old.eventChange != current.eventChange && current.eventChange == "play" && current.afterLoad == "shaftesburyavenue" ||
		   settings["neckless"] && old.eventChange != current.eventChange && current.eventChange == "play" && current.afterLoad == "forestofdean2" ||
		   settings["umbridge"] && old.eventChange == "play" && current.eventChange == "mim5";
}
