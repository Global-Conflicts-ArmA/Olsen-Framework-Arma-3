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

private _buildings = _pos nearObjects ["Building", _radius];
_buildings = _buildings select {
    private _positions = _x buildingPos -1;
    count _positions >= 3
};
if (_buildings isNotEqualTo []) then {
    SETVAR(_group,Task,"GARRISON");
    [_group, _pos, _radius] call FUNC(combatGarrison);
} else {
    SETVAR(_group,Task,"DEFEND");
    [_group] call FUNC(combatDefend);
};

[_group] call FUNC(taskRelease);
