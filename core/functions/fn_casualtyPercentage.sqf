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

//IGNORE_PRIVATE_WARNING ["_start", "_current"];
GETTEAMVAR(_start,_team,3);
GETTEAMVAR(_current,_team,4);

private _count = 0;

if (_start isEqualTo 0) then {
    ERROR_1("Casualty count:<br></br>Warning no units on team '%1'.", _team);
} else {
	_count = (_start - _current) / (_start * 0.01);
};

_count
