private _westCasualty = "USMC" call FUNC(CasualtyPercentage); //Gets the casualty percentage of team "USMC"
private _eastCasualty = "VDV" call FUNC(CasualtyPercentage); //Gets the casualty percentage of team "VDV"

if (_westCasualty >= 50) exitWith {
	"VDV VICTORY<br />USMC has retreated due to casualties." call FUNC(EndMission);
};

if (_eastCasualty >= 75) exitWith {
	"USMC VICTORY<br />VDV has retreated due to casualties." call FUNC(EndMission);
};

/*
Soft Ending the Mission
    Missions can be "soft" ended via the FUNC(SoftEndMission) function.
    The mission end warn message will display first, then count down the time to end, then display
    the regular endmission screen. Minimum time to wait is 5 seconds. If no warn message is given, eg:
    ["USMC VICTORY<br />VDV has retreated due to casualties.", "", 30] call FUNC(SoftEndMission);
    then function uses the regular end mission text as the warn message as well.
    [<MISSION END MESSAGE: STRING>, <MISSION END WARN MESSAGE: STRING | OPTIONAL>, <TIME TO WAIT: NUMBER | OPTIONAL>] call FUNC(SoftEndMission);
    eg. ["USMC VICTORY<br />VDV has retreated due to casualties.", "USMC VICTORY", 30] call FUNC(SoftEndMission);

    If you want the mission to only display the end mission, and for it only to end when a GM calls it, set the time to wait to -1
    eg. ["USMC VICTORY<br />VDV has retreated due to casualties.", "USMC VICTORY", -1] call FUNC(SoftEndMission);

Alternative methods of counting casualties

	"USMC" call FUNC(casualtyCount);
		this will count how many members of a team died in the mission

	"USMC" call FUNC(countTeam);
		this will check how many players are remaining in a team
		be careful as using this method will end the mission instantly if
		not enough players are present in the team

Adding extraction

	["USMC", "ExtractionAreaMarker", 0.8] call FUNC(hasExtracted);
		this will check if at least 80% of remaining forces are present in extraction area
*/
