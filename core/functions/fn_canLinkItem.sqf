/*
 * Author: Olsen
 *
 * Check if item can be linked.
 *
 * Arguments:
 * 0: unit <object>
 * 1: type <string>
 *
 * Return Value:
 * can link <bool>
 *
 * Public: No
 */

#include "..\script_macros.hpp"

params [
	["_unit", objNull, [objNull]],
	["_type", "", [""]]
];

private _assignedItems = [];

{
	_assignedItems pushBack (([_x] call BIS_fnc_itemType) select 1);
} forEach (assignedItems _unit);

private _result = _type in _assignedItems;

!_result