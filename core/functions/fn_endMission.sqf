/*
 * Author: Olsen
 *
 * Ends mission in orderly fashion and displays end screen.
 * Sends the team stats, time limit, scenario and executes "GVAR(EndMission)" on all players machines.
 *
 * Arguments:
 * 0: text to display in end screen <string>
 *
 * Return Value:
 * nothing
 *
 * Public: Yes
 */

#include "..\script_macros.hpp"

params ["_endText"];

if (CBA_missionTime > 0) then {

	GVAR(MissionEnded) = true;

	if (!isNil "aCount_endCount") then {call aCount_endCount};
	
	{
		private _team = (_x select 0);
		private _assets = _team call FUNC(GetDamagedAssets);
		[_team, 5, _assets select 0] call FUNC(SetTeamVariable);
		[_team, 6, _assets select 1] call FUNC(SetTeamVariable);
	} forEach GVAR(Teams);

	[QGVAR(EndMission), [_endText, GVAR(TimeLimit), GVAR(Teams)]] call CBA_fnc_globalEvent;
	
} else {
	"End Conditions have just been triggered. Mission will have to be ended manually." remoteExec ["systemChat", 0, false];
};