/*
 * Author: Olsen
 *
 * Changes value in FW_Teams for set team.
 *
 * Arguments:
 * 0: Team name <string>
 * 1: Index of variable to change <number>
 * 2: Value to set variable to <any>
 *
 * Return Value:
 * found <bool>
 *
 * Public: No
 */

#include "script_component.hpp"

params [
	["_team", "", [""]],
	["_index", 0, [0]],
	"_value"
];

private _return = false;

{
	if ((_x select 0) isEqualTo _team) exitWith {
		_x set [_index, _value];
		_return = true;
	};
} forEach FW_Teams;

_return