/*
 * Author: Olsen
 *
 * Initialize tracking of unit.
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

if !(GETVAR(_unit,Tracked,false)) then {
	private _side = side _unit;
	_unit setVariable [QGVAR(Side), _side];
	_unit setVariable [QGVAR(Tracked), true];
	_unit call FUNC(EventSpawned);
};