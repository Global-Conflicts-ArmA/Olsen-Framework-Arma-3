#include "script_component.hpp"

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
    ["_compRadius",50,[0]],
    ["_wpcount",10,[0]]
];

if (_radius < 30) then {
    ERROR_1("taskDropOff _group: %1 radius too small! Setting to default 30m",_group);
    _radius = 30;
};

private _veh = vehicle leader _group;
private _cargoGroups = GETVAR(_veh,vehCargoGroups,[]);
if (_cargoGroups isEqualTo []) exitWith {
    ERROR_1("taskDropOff _group: %1 has no cargo group!",_group);
};

TRACE_1("taskDropOff started",_this);
_group = _group call CBA_fnc_getGroup;
if !(local _group) exitWith {}; // Don't create waypoints on each machine

_dropOffPos = _dropOffPos call CBA_fnc_getPos;

// Clear existing waypoints first
[_group] call CBA_fnc_clearWaypoints;

SETVAR(_group,Task,"DROPOFF");
[_group] call FUNC(taskRelease);

_compRadius = GETVAR(_group,taskCompRadius,100);
if (_compRadius < 100) then {
    _compRadius = 100;
};

[_group, _dropOffPos, _compRadius] call FUNC(combatDropOff);
