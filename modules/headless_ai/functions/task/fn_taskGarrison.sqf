#include "script_component.hpp"

params [
    "_group",
    "_pos",
    ["_radius",100,[0]],
    ["_wait",3,[0]],
    ["_behaviour", "UNCHANGED", [""]],
    ["_combat", "NO CHANGE", [""]],
    ["_speed", "UNCHANGED", [""]],
    ["_formation", "NO CHANGE", [""]]
];

private _excludeClaimedHouses = true;
private _largerSearch = true;
private _houses = (nearestObjects [leader _group, ["House", "Strategic", "Ruins"], _radius, true]) select {
    private _bPosArray = _x buildingPos -1;
    (count _bPosArray >= 3) &&
    {
        (_bPosArray select {!(_x in GVAR(OccupiedPositions))}) isNotEqualTo []
    } &&
    {!_excludeClaimedHouses || !(GETVAR(_x,claimed,false))}
};
if (_houses isEqualTo [] && _largerSearch) then {
    _houses = (nearestObjects [leader _group, ["House", "Strategic", "Ruins"], _radius * 3, true]) select {
        private _bPosArray = _x buildingPos -1;
        (count _bPosArray >= 3) &&
        {
            (_bPosArray select {!(_x in GVAR(OccupiedPositions))}) isNotEqualTo []
        } &&
        {!_excludeClaimedHouses || !(GETVAR(_x,claimed,false))}
    };
};
TRACE_2("Garrison Choice:",_group,_houses);

if (_houses isNotEqualTo []) then {
    SETVAR(_group,Task,"GARRISON");
    [_group, _pos, _radius, _houses] call FUNC(combatGarrison);
} else {
    SETVAR(_group,Task,"DEFEND");
    [_group] call FUNC(combatDefend);
};

[_group] call FUNC(taskRelease);
