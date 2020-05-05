/*
 * Author: Olsen
 *
 * Check if accessory can be attached.
 *
 * Arguments:
 * 0: unit <object>
 * 1: type <string>
 *
 * Return Value:
 * can attach <bool>
 *
 * Public: No
 */

#include "..\script_macros.hpp"

params [
	["_weapon", "", [""]],
	["_item", "", [""]]
];

private _result = false;

{
	if (_item isEqualTo _x) exitWith {
		_result = true;
	};
} forEach ([_weapon] call BIS_fnc_compatibleItems);

_result