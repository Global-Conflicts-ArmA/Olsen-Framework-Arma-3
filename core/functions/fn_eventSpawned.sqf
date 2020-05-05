/*
 * Author: Olsen
 *
 * If unit is tracked increase number of alive units on it's team.
 *
 * Arguments:
 * 0: unit to track <object>
 *
 * Return Value:
 * nothing
 *
 * Public: No
 */

#include "..\script_macros.hpp"

params ["_unit"];

if (GETVAR(_unit,Tracked,false)) then {
	SETVAR(_unit,HasDied,false); //we will use this variable to make sure killed eventHandler doesn't fire twice
	{
		_x params ["", "_side", "_type", "_total", "_current"];
		if (
				((GETVAR(_unit,Side,sideUnknown)) isEqualTo _side) && 
				{(((_type isEqualTo "ai") && {!(isPlayer _unit)}) || (_type != "ai"))}
			) exitWith {
			_x set [3, _total + 1];
			if (_unit call FUNC(Alive)) then {
				_x set [4, _current + 1];
			};
			LOG_1("cba init 6 for unit: %1", _unit);
		};
	} forEach GVAR(Teams);
};