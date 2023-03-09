#include "script_component.hpp"

params [
    "_group",
    "_pos",
    ["_radius", 100, [0]],
    ["_buildings", [], [[]]]
];

TRACE_2("Garrison Function:",_group,_buildings);

private _units = units _group select {!(INVEHICLE(_x))};

private _allPositions = [];
_buildings apply {
    (_x buildingPos -1) select {!(_x in GVAR(OccupiedPositions))} apply {
        _allPositions pushBackUnique _x;
    };
};
TRACE_2("Garrison Function:",count _units,count _allPositions);
private _largerSearch = true;

_units apply {
    if (_allPositions isEqualTo []) then {
        TRACE_2("Ran out of positions",_group,_allPositions);
        if !(_largerSearch) exitWith {
            TRACE_1("Larger Search disabled, setting to misc defence for remaining units",_group);
        };
        (nearestObjects [leader _group, ["House", "Strategic", "Ruins"], _radius * 3, true]) select {
            ((_x buildingPos -1) select {!(_x in GVAR(OccupiedPositions))}) isNotEqualTo []
        } apply {
            (_x buildingPos -1) select {!(_x in GVAR(OccupiedPositions))} apply {
                _allPositions pushBackUnique _x;
            };
        };
        TRACE_2("Ran larger search",_group,_allPositions);
    };
    private _unit = _x;
    private _pos = _allPositions deleteAt 0;
    SETVAR(_unit,Busy,true);
    GVAR(OccupiedPositions) pushBackUnique _pos;
    doStop _unit;
    TRACE_2("unit occupying position",_unit,_pos);
    [
        {
            params ["_unit", "_pos"];
            _unit moveTo _pos;
            _unit setDestination [_pos, "LEADER PLANNED", true];
            [{
                (_this select 0) distance (_this select 1) <= 1
            }, {
              params ["_unit", "_pos"];
              SETVAR(_unit,Busy,false);
            }, [_unit, _pos]] call CBA_fnc_waitUntilAndExecute;
        }, [_unit, _pos], 0.5 + random 2
    ] call CBA_fnc_waitAndExecute;
};
