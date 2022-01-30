#include "script_component.hpp"

params [
    "_group",
    "_landPos",
    ["_radius",100,[0]],
    ["_wait",3,[0]],
    ["_behaviour", "UNCHANGED", [""]],
    ["_combat", "NO CHANGE", [""]],
    ["_speed", "UNCHANGED", [""]],
    ["_formation", "NO CHANGE", [""]],
    ["_Type","MOVE",[""]],
    ["_oncomplete",QUOTE(this call FUNC(taskSearchNearby)),[""]],
    ["_compradius",50,[0]],
    ["_wpcount",10,[0]]
];


LOG_1("taskPickup started _this: %1",_this);
_group = _group call CBA_fnc_getGroup;
if !(local _group) exitWith {}; // Don't create waypoints on each machine

_landPos = _landPos call CBA_fnc_getPos;

// Clear existing waypoints first
[_group] call CBA_fnc_clearWaypoints;

SETVAR(_group,InitialWPSet,true);
SETVAR(_group,Task,"PICKUP");
[_group] call FUNC(taskRelease);

_compradius = GETVAR(_group,taskCompRadius,150);
TRACE_2("",_group,_compradius);

[_group, _landPos, _compradius] call FUNC(combatLand);
true
