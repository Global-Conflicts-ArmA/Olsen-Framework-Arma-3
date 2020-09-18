/*
 * Author: Olsen
 *
 * Retrieve variable for a set team from GVAR(Teams).
 *
 * Arguments:
 * 0: Team name <string>
 * 1: Index of variable to retrieve <number>
 *
 * Return Value:
 * 0 <number> if not found, var value <any> if found
 *
 * Public: No
 */

#include "script_component.hpp"

params [
	["_team", "", [""]],
	["_type", "", [""]]
];

if (_type isEqualTo "") exitWith {
	ERROR_1("Critical:<br></br>type '%1' does not exist.", _type);
};

private _index = switch (toUpper _type) do {
    case "SIDE": {1};
    case "TYPE": {2};
    case "TOTAL": {3};
    case "CURRENT": {4};
    default {-1};
};

if (_index isEqualTo -1) exitwith {
	ERROR_1("Critical:<br></br>Data '%1' does not exist.", _type);
};

private _teamIndex = GVAR(Teams) findIF {
	_x params ["_name"];
	((toUpper _name) isEqualTo (toUpper _team))
};

if (_teamIndex isEqualTo -1) exitwith {
	ERROR_1("Critical:<br></br>Team '%1' does not exist.", _team);
};
private _return = GVAR(Teams) select _teamIndex select _index;

_return