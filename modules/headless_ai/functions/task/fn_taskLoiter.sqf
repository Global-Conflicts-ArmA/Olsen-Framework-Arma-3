#include "script_component.hpp"


params [
    "_group",
    "_pos",
    ["_radius", 30, [0]],
    ["_wait", 3, [0]],
    ["_behaviour", "UNCHANGED", [""]],
    ["_combat", "NO CHANGE", [""]],
    ["_speed", "UNCHANGED", [""]],
    ["_formation", "NO CHANGE", [""]]
];

_group setVariable [QGVAR(Task),"LOITER"];
[_group] call FUNC(taskRelease);

[_group] call FUNC(LoiterAction);
