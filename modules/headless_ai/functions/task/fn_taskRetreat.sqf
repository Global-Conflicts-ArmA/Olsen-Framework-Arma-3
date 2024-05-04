#include "script_component.hpp"

params [
    "_group",
    "_retreatPos",
    ["_radius",100,[0]],
    ["_wait",3,[0]],
    ["_behaviour", "UNCHANGED", [""]],
    ["_combat", "NO CHANGE", [""]],
    ["_speed", "UNCHANGED", [""]],
    ["_formation", "NO CHANGE", [""]],
    ["_Type","MOVE",[""]],
    ["_oncomplete",QUOTE(this call FUNC(taskGarrison)),[""]],
	["_nextTask","GARRISON",[""]],
    ["_compRadius",50,[0]],
    ["_wpcount",10,[0]]
];

if (_radius < 30) then {
    ERROR_1("taskRetreat _group: %1 radius too small! Setting to default 30m",_group);
    _radius = 30;
};

LOG_1("taskRetreat started _this: %1",_this);
_group = _group call CBA_fnc_getGroup;
if !(local _group) exitWith {}; // Don't create waypoints on each machine

//private _timeout = [(_wait*0.5), _wait, (_wait*1.5)];
_retreatPos = _retreatPos call CBA_fnc_getPos;

// Clear existing waypoints first
[_group] call CBA_fnc_clearWaypoints;

SETVAR(_group,Task,"RETREAT");
[_group] call FUNC(taskRelease);

[_group, _retreatPos, _radius, "RETREAT"] call FUNC(combatBound);

[{
    params ["_group", "_nextTask", "_retreatPos"];
    GETVAR(_group,ExitingBound,false);
}, {
    params ["_group", "_nextTask", "_retreatPos"];
    SETVAR(_group,ExitingBound,false);
    [_group, _nextTask, _retreatPos] call FUNC(taskAssign);
}, [_group, _nextTask, _retreatPos]] call CBA_fnc_waitUntilAndExecute;
