/*
 * Author: Olsen
 *
 * Stop tracking of unit by framework.
 *
 * Arguments:
 * 0: unit <object>
 *
 * Return Value:
 * nothing
 *
 * Public: No
 */

#include "script_component.hpp"

params ["_unit"];

if (GETVAR(_unit,Tracked,false)) then {
	GVAR(Teams) apply {
		_x params ["", "_side", "_type", "_total", "_current"];
		if (
            ((_unit getVariable [QGVAR(Side), sideEmpty]) isEqualTo _side) &&
            {(((_type != "ai") && {isPlayer _unit}) || (_type == "ai"))}
        ) exitWith {
			if (_unit call FUNC(isAlive)) then {
				_x set [3, _total - 1];
				_x set [4, _current - 1];
			};
		};
	};
	_unit setVariable [QGVAR(Side), nil];
	_unit setVariable [QGVAR(Tracked), nil];
};
