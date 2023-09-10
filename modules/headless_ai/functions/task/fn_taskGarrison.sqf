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

private _largerSearch = true;
private _buildings = (nearestObjects [_pos, ["House", "Strategic", "Ruins"], _radius, true]) select {
    private _blg = _x;
    (!(GETMVAR(garrisonExcludeClaimedBuildings,true)) || !(GETVAR(_blg,claimed,false))) &&
    {
        private _bPosArray = _blg buildingPos -1;
        (count _bPosArray >= 3) &&
        {
            (_bPosArray select {!(_x in GVAR(OccupiedPositions))}) isNotEqualTo []
        }
    }
};
TRACE_2("",_group,_buildings);
if (_largerSearch && {_buildings isEqualTo []}) then {
    _buildings = (nearestObjects [_pos, ["House", "Strategic", "Ruins"], _radius * 3, true]) select {
        private _blg = _x;
        (!(GETMVAR(garrisonExcludeClaimedBuildings,true)) || !(GETVAR(_blg,claimed,false))) &&
        {
            private _bPosArray = _blg buildingPos -1;
            (count _bPosArray >= 3) &&
            {
                (_bPosArray select {!(_x in GVAR(OccupiedPositions))}) isNotEqualTo []
            }
        }
    };
};
TRACE_2("Garrison Choice:",_group,count _buildings);

if (_buildings isNotEqualTo []) then {
    SETVAR(_group,Task,"GARRISON");
    [_group, _pos, _radius, _buildings] call FUNC(combatGarrison);
} else {
    SETVAR(_group,Task,"DEFEND");
    [_group] call FUNC(combatDefend);
};

[_group] call FUNC(taskRelease);
