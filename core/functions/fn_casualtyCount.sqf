/*
 * Author: Olsen
 *
 * Counts number of casualties on set team
 *
 * Arguments:
 * 0: team <string>
 *
 * Return Value:
 * casualty count <number>
 *
 * Public: Yes
 */

#include "..\script_macros.hpp"

params ["_team"];

private _start = [_team, 3] call FUNC(GetTeamVariable);
private _current = [_team, 4] call FUNC(GetTeamVariable);

private _count = 0;

if (_start isEqualTo 0) then {
	private _tempText = format ["Casualty count:<br></br>Warning no units on team ""%1"".", _team];
	_tempText call FUNC(DebugMessage);
} else {
	_count = _start - _current;
};

_count