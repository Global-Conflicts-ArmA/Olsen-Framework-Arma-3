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

params ["_unit"];

SETPVAR(_unit,Side,(side _unit));

if ((isPlayer _unit) || !(GETVAR(_unit,DontTrack,false))) then {
    if !(GETVAR(_unit,Tracked,false)) then {
        SETPVAR(_unit,Tracked,true);
        SETPVAR(_unit,HasDied,false); //we will use this variable to make sure killed eventHandler doesn't fire twice
        {
            _x params ["_name", "_side", "_Type", "_total", "_current"];
            if (
				(GETVAR(_unit,Side,sideUnknown) isEqualto _side) && 
				{(_Type isEqualto "player" && {isPlayer _unit}) || {(_Type isEqualto "ai" && {!(isPlayer _unit)})}}
			) exitWith {
                _x set [3, (_total + 1)];
                if (_unit call FUNC(Alive)) then {
                    _x set [4, (_current + 1)];
                };
            };
        } forEach GVAR(Teams);
    };
};