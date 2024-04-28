#include "script_component.hpp"

params [
    "_group",
    "_attackPos",
    ["_radius",100,[0]],
    ["_wait",3,[0]],
    ["_behaviour", "UNCHANGED", [""]],
    ["_combat", "NO CHANGE", [""]],
    ["_speed", "UNCHANGED", [""]],
    ["_formation", "NO CHANGE", [""]],
    ["_Type","MOVE",[""]],
    ["_oncomplete",QUOTE(this call FUNC(taskSearchNearby)),[""]],
    ["_nextTask","PATROL",[""]],
    ["_compRadius",50,[0]],
    ["_wpcount",10,[0]]
];

if (_radius < 30) then {
    ERROR_1("taskAssault _group: %1 radius too small! Setting to default 30m",_group);
    _radius = 30;
};

LOG_1("taskAssault started _this: %1",_this);
_group = _group call CBA_fnc_getGroup;
if !(local _group) exitWith {}; // Don't create waypoints on each machine

//private _timeout = [(_wait*0.5), _wait, (_wait*1.5)];
_attackPos = _attackPos call CBA_fnc_getPos;

// Clear existing waypoints first
[_group] call CBA_fnc_clearWaypoints;

SETVAR(_group,Task,"ASSAULT");
[_group] call FUNC(taskRelease);

[_group, _attackPos, _radius, "ASSAULT"] call FUNC(combatBound);

[{
    params ["_group", "_nextTask", "_attackPos"];
    GETVAR(_group,BoundPFH,objNull) isEqualTo objNull;
}, {
    params ["_group", "_nextTask", "_attackPos"];
    [_group, _nextTask, _attackPos] call FUNC(taskAssign);
}, [_group, _nextTask, _attackPos]] call CBA_fnc_waitUntilAndExecute;