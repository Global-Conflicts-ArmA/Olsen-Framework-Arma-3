#include "script_component.hpp"

params [
    "_group",
    "_pos",
    ["_radius",100,[0]],
    ["_wait",3,[0]],
    ["_behaviour", "UNCHANGED", [""]],
    ["_combat", "NO CHANGE", [""]],
    ["_speed", "UNCHANGED", [""]],
    ["_formation", "NO CHANGE", [""]],
    ["_Type","MOVE",[""]],
    ["_oncomplete","",[""]],
    ["_compradius",0,[0]],
    ["_wpcount",10,[0]]
];

SETVAR(_group,Task,"DEFEND");
[_group] call FUNC(combatDefend);
[_group] call FUNC(taskRelease);
