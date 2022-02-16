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

#include "script_component.hpp"

params ["_unit"];

SETPVAR(_unit,Side,(side _unit));

if (
    (isPlayer _unit ||
    {!(GETVAR(_unit,DontTrack,false))}) &&
    {!(GETVAR(_unit,Tracked,false))}
) then {
    SETPVAR(_unit,Tracked,true);
    SETPVAR(_unit,HasDied,false); //we will use this variable to make sure killed eventHandler doesn't fire twice
    GVAR(Teams) apply {
        _x params ["_name", "_side", "_type", "_total", "_current"];
        if (
			((GETVAR(_unit,Side,sideUnknown)) isEqualto _side) &&
			{(isPlayer _unit && {_type != "ai"}) || {_type == "ai"}}
		) exitWith {
            if (_unit call FUNC(isAlive)) then {
                _x set [3, _total + 1];
                _x set [4, _current + 1];
            };
        };
    };
};
