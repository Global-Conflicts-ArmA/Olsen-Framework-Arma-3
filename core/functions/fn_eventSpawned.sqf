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
    !isNull _unit &&
    {isPlayer _unit ||
    {!(GETVAR(_unit,DontTrack,false))}} &&
    {!(GETVAR(_unit,Tracked,false))} &&
    {_unit call FUNC(isAlive)}
) then {
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
		) then {
            private _newCurrent = _current + 1;
            private _newTotal = _total + 1;
            TRACE_3("Setting new alive count",_unit,_newTotal,_newCurrent);
            (_team select 0) set [3, _newTotal];
            (_team select 0) set [4, _newCurrent];
		};
    };
    SETPVAR(_unit,Tracked,true);
    SETPVAR(_unit,HasDied,false); //we will use this variable to make sure killed eventHandler doesn't fire twice
};
