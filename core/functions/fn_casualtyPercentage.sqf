/*
 * Author: Olsen
 *
 * Returns casualty percentage for set team
 *
 * Arguments:
 * 0: team <string>
 *
 * Return Value:
 * casualty percentage (1-100) <number>
 *
 * Public: Yes
 */

#include "script_component.hpp"

params ["_team"];

private _start = [_team, 3] call FUNC(GetTeamVariable);
private _current = [_team, 4] call FUNC(GetTeamVariable);

private _count = 0;

if (_start isEqualTo 0) then {
	private _tempText = format ["Casualty count:<br></br>Warning no units on team ""%1"".", _team];
	_tempText call FUNC(DebugMessage);
} else {
	_count = (_start - _current) / (_start * 0.01);
};

_count