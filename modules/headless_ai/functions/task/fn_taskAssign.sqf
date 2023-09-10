#include "script_component.hpp"


params [
    ["_group",grpNull,[grpNull]],
    ["_task","NONE",[""]],
    ["_pos",[],[[]]],
    ["_radius",50,[0]],
    ["_wait",3,[0]],
    ["_behaviour", "UNCHANGED", [""]],
    ["_combat", "NO CHANGE", [""]],
    ["_speed", "UNCHANGED", [""]],
    ["_formation", "NO CHANGE", [""]]
];

private _taskSet = [_group,_pos,_radius,_wait,_behaviour,_combat,_speed,_formation];

_task = toUpper _task;
if (_task isEqualTo "NONE") then {
    _task = ["PATROL", "STATIONARY"] select (INVEHICLE(leader _group));
    LOG_2("group:%1 defaulted to task: %2,",_group,_task);
};
LOG_2("group:%1 set to task: %2,",_group,_task);
if (_task isEqualTo "MANUAL") exitWith {};

TRACE_2("getting task function",_group,_task);
private _taskInfo = GVAR(Tasks) getOrDefault [_task, []];
_taskInfo params [
    ["_function", "", [""]],
    ["_isMove", false, [false]],
    ["_needsPos", false, [false]],
    ["_combatResponse", "", [""]],
    ["_reinforce", false, [false]]
];

if (_function isNotEqualTo "") then {
    TRACE_2("calling task assign function",_group,_function);
    _taskSet call (missionNamespace getVariable [_function, {}]);
};
