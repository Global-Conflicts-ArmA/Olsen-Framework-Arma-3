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

params ["_unit", ["_forcedSide", sideEmpty, [sideEmpty]]];

private _forced = _forcedSide isNotEqualTo sideEmpty;
if (GETMVAR(verboseDebugEnabled,false)) then {
    TRACE_2("untrackUnit",_unit,_forced);
};

if (GETVAR(_unit,Tracked,false) || {_forced}) then {
    private _team = GVAR(Teams) select {
        _x params ["", "_side", "_type", "_total", "_current"];
        (
            _forced && {_forcedSide isEqualto _side} ||
            {(GETVAR(_unit,Side,sideUnknown)) isEqualto _side}
        ) &&
        {
            (_type == "both" || _type == "any") ||
            {_type == "player" && {isPlayer _unit}} ||
            {_type == "ai" && {!isPlayer _unit}}
        }
    };
    if (_team isNotEqualTo []) then {
        (_team select 0) params ["", "_side", "_type", "_total", "_current"];
		if (
            _forced ||
            {_unit call FUNC(isAlive)}
		) then {
            private _newCurrent = _current - 1;
            private _newTotal = _total - 1;
            if (GETMVAR(verboseDebugEnabled,false)) then {
                TRACE_3("Setting new alive count",_unit,_newTotal,_newCurrent);
            };
            (_team select 0) set [3, _newTotal];
            (_team select 0) set [4, _newCurrent];
		};
    };
    _unit setVariable [QGVAR(Side), nil];
	_unit setVariable [QGVAR(Tracked), nil];
};
