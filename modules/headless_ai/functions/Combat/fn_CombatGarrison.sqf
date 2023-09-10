#include "script_component.hpp"

params [
    "_group",
    "_pos",
    ["_radius", 100, [0]],
    ["_buildings", [], [[]]]
];

//TRACE_2("Garrison Function:",_group,_buildings);

private _units = units _group select {!(INVEHICLE(_x))};

private _allPositions = [];
TRACE_2("Garrison Function:",count _units,count _buildings);
private _largerSearch = true;

_units apply {
    private _unit = _x;
    //TRACE_2("unit loop start:",_unit,_allPositions);
    if (_allPositions isEqualTo []) then {
        if (_buildings isEqualTo []) then {
            TRACE_2("Ran out of positions",_group,_allPositions);
            if !(_largerSearch) exitWith {
                TRACE_1("Larger Search disabled, setting to misc defence for remaining units",_group);
            };
            _buildings = (nearestObjects [_pos, ["House", "Strategic", "Ruins"], _radius * 3, true]) select {
                private _bld = _x;
                (!(GETMVAR(garrisonExcludeClaimedBuildings,true)) || !(GETVAR(_bld,claimed,false))) &&
                {((_bld buildingPos -1) select {!(_x in GVAR(OccupiedPositions))}) isNotEqualTo []}
            };
            TRACE_2("Ran larger search",_group,_buildings);
        };
        private _currentBuilding = selectRandom _buildings;
        SETVAR(_currentBuilding,claimed,true);
        (_currentBuilding buildingPos -1) select {!(_x in GVAR(OccupiedPositions))} apply {
            _allPositions pushBackUnique _x;
        };
    };
    private _posUnit = _allPositions deleteAt 0;
    //TRACE_2("unit loop end:",_unit,_posUnit);
    SETVAR(_unit,Busy,true);
    GVAR(OccupiedPositions) pushBackUnique _posUnit;
    doStop _unit;
    TRACE_2("unit occupying position",_unit,_posUnit);
    [
        {
            params ["_unit", "_posUnit"];
            _unit moveTo _posUnit;
            _unit setDestination [_posUnit, "LEADER PLANNED", true];
            [{
                (_this select 0) distance (_this select 1) <= 1
            }, {
              params ["_unit", "_posUnit"];
              SETVAR(_unit,Busy,false);
            }, [_unit, _posUnit]] call CBA_fnc_waitUntilAndExecute;
        }, [_unit, _posUnit], 0.5 + random 2
    ] call CBA_fnc_waitAndExecute;
};
