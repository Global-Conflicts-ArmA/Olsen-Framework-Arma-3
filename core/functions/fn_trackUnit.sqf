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

#include "script_component.hpp"

params ["_unit"];

if !(GETVAR(_unit,Tracked,false)) then {
	SETVAR(_unit,side,side _unit);
	SETPVAR(_unit,Tracked,true);
	_unit call FUNC(EventSpawned);
};