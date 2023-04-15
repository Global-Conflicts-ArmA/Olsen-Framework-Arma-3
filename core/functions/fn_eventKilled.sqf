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

#include "script_component.hpp"

params [
	["_unit", objNull, [objNull]],
	["_killer", objNull, [objNull]]
];

if (GETVAR(_unit,Tracked,false)) then {
	private _team = GVAR(Teams) select {
        _x params ["", "_side", "_type", "_total", "_current"];
        (GETVAR(_unit,Side,sideUnknown)) isEqualTo _side &&
        {
            (_type == "both" || _type == "any") ||
            {_type == "player" && {isPlayer _unit}} ||
            {_type == "ai" && {!isPlayer _unit}}
        }
    };
    if (_team isNotEqualTo []) then {
        (_team select 0) params ["", "_side", "_type", "_total", "_current"];
		if (
			!(GETVAR(_unit,HasDied,false)) &&
			{!(GETVAR(_unit,Dead,false))}
		) exitWith {
			SETPVAR(_unit,HasDied,true);
            SETPVAR(_unit,Dead,true);
            SETPVAR(_unit,Tracked,false);
			(_team select 0) set [4, _current - 1];
		};
    };
};
