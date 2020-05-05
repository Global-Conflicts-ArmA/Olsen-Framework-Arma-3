/*
 * Author: Olsen
 *
 * If unit's alive, reduce number of units on it's side.
 *
 * Arguments:
 * 0: unit that disconnected <object>
 *
 * Return Value:
 * nothing, false <bool> if not found
 *
 * Public: No
 */

#include "..\script_macros.hpp"

params ["_unit"];

if (GETVAR(_unit,Tracked,false)) then {
	{
		_x params ["", "_side", "_type", "_total", "_current"];

		if ((GETVAR(_unit,Side,sideUnknown)) isEqualTo _side) exitWith {
			if (_unit call FUNC(Alive)) then {
				_x set [3, _total - 1];
				_x set [4, _current - 1];
				SETPVAR(_unit,Dead,true);
			};
		};
	} forEach GVAR(Teams);
};

false