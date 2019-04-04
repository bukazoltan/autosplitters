// QUIDDITCH WORLD CUP auto splitter (by mczolly & spectralplatypus)
// Automatically splits every time the snitch is caught.
// The run autoresets if you quit to main menu from the opponent selector screen (typical reset situation)

state("QWC")
{
	byte snitchCaught : "QWC.exe", 0x0020E904;
	int location: "QWC.exe", 0x0020EA94;
	byte tutorialLevel : "QWC.exe", 0x00C18F98;
}

startup
{
	settings.Add("snitch", true, "Split every time the snitch is caught.");

	settings.Add("passing", true, "Split after the passing tutorial.");
	settings.Add("tackle", true, "Split after the tackle & shoot tutorial.");
	settings.Add("seeker", true, "Split after the seeker tutorial.");
	settings.Add("bludger", true, "Split after the beaters & bludgers tutorial.");
	settings.Add("special", true, "Split after the special moves tutorial.");
	settings.Add("combos", true, "Split after the combos tutorial.");
}

split
{
	// checking for catching the snitch
	if (old.snitchCaught == 0 && current.snitchCaught == 1) {
		return settings["snitch"];
	}

	// checking if the passing tutorial level has been passed
	if (old.tutorialLevel == 1 && current.tutorialLevel == 0) {
		return settings["passing"];
	}

	// checking if the tackle & shoot tutorial level has been passed
	if (old.tutorialLevel == 2 && current.tutorialLevel == 0) {
		return settings["tackle"];
	}

	// checking if the seeker tutorial level has been passed
	if (old.tutorialLevel == 3 && current.tutorialLevel == 0) {
		if (settings["snitch"] == false) {
			return settings["seeker"];
		}
	}

	// checking if the beaters & bludgers tutorial level has been passed
	if (old.tutorialLevel == 4 && current.tutorialLevel == 0) {
		return settings["bludger"];
	}

	// checking if the special moves tutorial level has been passed
	if (old.tutorialLevel == 5 && current.tutorialLevel == 0) {
		return settings["special"];
	}

	// checking if the combos tutorial level has been passed
	if (old.tutorialLevel == 6 && current.tutorialLevel == 0) {
		return settings["combos"];
	}
}

reset
{
	if (old.location == 81920 && current.location == 0) {
		return true;
	}
}
