#include "..\core\script_macros.hpp"

private _westCasualty = "USMC" call FUNC(CasualtyPercentage); //Gets the casualty percentage of team "USMC"
private _eastCasualty = "VDV" call FUNC(CasualtyPercentage); //Gets the casualty percentage of team "VDV"

if (_westCasualty >= 50) exitWith {
	"VDV VICTORY<br />USMC has retreated due to casualties." call FUNC(EndMission);
};

if (_eastCasualty >= 75) exitWith {
	"USMC VICTORY<br />VDV has retreated due to casualties." call FUNC(EndMission);
};

/*
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