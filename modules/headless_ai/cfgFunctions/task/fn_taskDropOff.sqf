#include "..\..\script_macros.hpp"

params [
    "_group",
    "_dropOffPos",
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

if (_radius < 30) then {
    ERROR_1("taskPatrol _group: %1 radius too small! Setting to default 30m",_group);
    _radius = 30;
};

TRACE_1("taskDropOff started",_this);
_group = _group call CBA_fnc_getGroup;
if !(local _group) exitWith {}; // Don't create waypoints on each machine

_dropOffPos = _dropOffPos call CBA_fnc_getPos;

// Clear existing waypoints first
[_group] call CBA_fnc_clearWaypoints;

SETVAR(_group,InitialWPSet,true);
SETVAR(_group,Task,"DROPOFF");
[_group] call FUNC(taskRelease);

_compradius = GETVAR(_group,taskCompRadius,100);
if (_compradius < 100) then {
    _compradius = 100;
};

[_group, _dropOffPos, _compradius] call FUNC(combatDropOff);
true
