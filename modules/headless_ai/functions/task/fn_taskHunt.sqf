#include "script_component.hpp"

params [
    "_group",
    "_attackPos",
    ["_radius",100,[0]]
];

SETVAR(_group,Task,"HUNT");
[_group] call FUNC(taskRelease);

TRACE_1("taskHunt started",_this);
_group = _group call CBA_fnc_getGroup;
if !(local _group) exitWith {}; // Don't create waypoints on each machine

_attackPos = _attackPos call CBA_fnc_getPos;

[_group, _attackPos, _radius] call FUNC(combatHunt);
