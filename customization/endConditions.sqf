private _westCasualty = "BLUFOR" call FNC_CasualtyPercentage; //Gets the casualty percentage of team "USMC"
private _eastCasualty = "OPFOR" call FNC_CasualtyPercentage; //Gets the casualty percentage of team "VDV"

if (_westCasualty >= 80) exitWith {
	"OPFOR VICTORY! BLUFOR have taken to many casualties and have retreated." call FNC_EndMission;
}; //What % of BLUFOR forces must be dead for mission to end

if (_eastCasualty >= 100) exitWith {
	"BLUFOR VICTORY! OPFOR have taken to many casualties and have retreated." call FNC_EndMission;
}; //What % of OPFOR forces must be dead for mission to end

//Allows a set team/side to end mission when they return to an extraction zone - Start your team/side inside the marker, once they leave and return it'll trigger mission end.
//if ({side _x == west && {_x inArea "MARKERNAME"}} count allUnits} exitWith "Well done, zone capped" call FNC_EndMission;

/*Checks if variable "boss" and "cache" are dead, if yes, then end mission
if (!(alive boss) && {!(alive cache)}) exitWith {
"BLUFOR VICTORY<br />The HVT and ammo cache was destroyed." call FNC_EndMission;
}; 
*/


/* Allows players to capture and contest zones to trigger end condition - Requires Capture_Zone module
if("WEST" == "isis" call FNC_isCaptured) exitWith {
"Iraqi Army Victory!<br />ISIS has retreated due to loss of base." call FNC_EndMission;
};
*/
