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

#include "script_component.hpp"

params ["_endText"];

if (CBA_missionTime > 0) then {

	SETMPVAR(MissionEnded,true);

	private _ammoInfo = [] call FUNC(shotDisplay);

	private _filteredTeams = GVAR(Teams) select {
        private _side = _x select 1;
        (
            _side isEqualTo west && {GETMVAR(EndScreenDisplay_West,true)} ||
            _side isEqualTo east && {GETMVAR(EndScreenDisplay_East,true)} ||
            _side isEqualTo independent && {GETMVAR(EndScreenDisplay_Ind,true)} ||
            _side isEqualTo civilian && {GETMVAR(EndScreenDisplay_Civ,true)}
        )
    } apply {
        _x params ["_name", "_side", "_type", "_total", "_current"];
		private _assets = _name call FUNC(GetDamagedAssets);
		_assets params ["_damaged", "_destroyed"];
        [
            _name,
            _side,
            _type,
            _total,
            _current,
            _damaged,
            _destroyed
        ]
	};

	[QGVAR(EndMission), [_endText, GVAR(TimeLimit), _filteredTeams, _ammoInfo]] call CBA_fnc_globalEvent;

} else {
	"End Conditions have just been triggered. Mission will have to be ended manually." remoteExec ["systemChat", 0, false];
};
