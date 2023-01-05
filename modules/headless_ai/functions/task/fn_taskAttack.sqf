#include "script_component.hpp"

params [
    "_group",
    "_attackPos",
    ["_radius",100,[0]],
    ["_wait",3,[0]],
    ["_behaviour", "UNCHANGED", [""]],
    ["_combat", "NO CHANGE", [""]],
    ["_speed", "UNCHANGED", [""]],
    ["_formation", "NO CHANGE", [""]]
];

SETVAR(_group,Task,"ATTACK");
[_group] call FUNC(taskRelease);

LOG_1("taskAssault started _this: %1",_this);
_group = _group call CBA_fnc_getGroup;
if !(local _group) exitWith {}; // Don't create waypoints on each machine

_attackPos = _attackPos call CBA_fnc_getPos;

[_group, _attackPos] call FUNC(combatAttack);
