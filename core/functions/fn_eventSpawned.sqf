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
    {!(GETVAR(_unit,Tracked,false))}
) then {
    SETPVAR(_unit,Tracked,true);
    SETPVAR(_unit,HasDied,false); //we will use this variable to make sure killed eventHandler doesn't fire twice
    GVAR(Teams) apply {
        _x params ["_name", "_side", "_type", "_total", "_current"];
        if (
			((GETVAR(_unit,Side,sideUnknown)) isEqualto _side) &&
			{
                (_type == "both" || _type == "any") ||
                {_type == "player" && {isPlayer _unit}} ||
                {_type == "ai" && {!isPlayer _unit}}
            }
		) exitWith {
            if (_unit call FUNC(isAlive)) then {
                private _newCurrent = _current + 1;
                private _newTotal = _total + 1;
                TRACE_3("Setting new alive count",_unit,_newTotal,_newCurrent);
                _x set [3, _newTotal];
                _x set [4, _newCurrent];
            };
        };
    };
};
