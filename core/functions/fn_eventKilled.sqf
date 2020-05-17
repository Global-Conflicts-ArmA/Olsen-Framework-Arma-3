/*
 * Author: Olsen
 *
 * Triggered by unit death. Decreases number of alive units on a set side in GVAR(Teams).
 *
 * Arguments:
 * 0: unit that has died <object>
 * 1: killer of the unit <object> (OPTIONAL)
 *
 * Return Value:
 * nothing
 *
 * Public: No
 */

#include "..\script_macros.hpp"

params [
	["_unit", objNull, [objNull]],
	["_killer", objNull, [objNull]]
];

if (GETVAR(_unit,Tracked,false)) then {
	{
		_x params ["", "_side", "_type", "", "_current"];
		if (
				!(GETVAR(_unit,HasDied,false)) &&  
				{!(GETVAR(_unit,Dead,false))} && 
				{(GETVAR(_unit,Side,sideUnknown)) isEqualTo _side} && 
				{(_type != "ai" && {isPlayer _unit}) || (_type isEqualTo "ai")}
		) exitWith {
			SETVAR(_unit,HasDied,true);
			_x set [4, _current - 1];
		};
	} forEach GVAR(Teams);
};