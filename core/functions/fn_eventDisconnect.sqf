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

#include "script_component.hpp"

params ["_unit", "_id", "_uid", "_name"];

TRACE_1("HandleDisconnect",_this);

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
        (_team select 0) set [3, _total - 1];
        (_team select 0) set [4, _current - 1];
        SETPVAR(_unit,Dead,true);
    };
	if ((GVAR(DisconnectBodyCleanupTime) < 0) && {(CBA_missionTime < (GVAR(DisconnectBodyCleanupTime) * 60))} && {(side _unit) in GVAR(DisconnectBodyCleanupSides)}) then {
		deleteVehicle _unit;
	};
};
