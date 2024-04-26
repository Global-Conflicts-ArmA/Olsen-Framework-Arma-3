#include "script_component.hpp"

params [
    "_group",
    "_pos",
    ["_radius",100,[0]]
];
;
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
TRACE_2("Garrison Choice:",_group,count _buildings);

if (_buildings isNotEqualTo []) then {
    SETVAR(_group,Task,"GARRISON");
    [_group, _pos, _radius, _buildings] call FUNC(combatGarrison);
} else {
    SETVAR(_group,Task,"DEFEND");
    [_group] call FUNC(combatPatrol);
};

[_group] call FUNC(taskRelease);
