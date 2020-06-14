#include "..\..\script_macros.hpp"


params ["_group",["_tasks",[],[[]]],["_task",objNull,[objNull]],["_taskOrdered",false,[false]]];
private _activeTasks = [];
for "_i" from 0 to (count _tasks) do {
    private _taskSet = (_tasks select _i) call FUNC(getTaskParams);
    _taskSet params ["_task","_cond","_prior","_time","_onComp","_taskId"];
    if (call _cond) then {
        _taskOrdered = if (_taskId > 0) then {true} else {false};
        _activeTasks pushback [_taskId,_prior,_task];
    };
};
if (_activeTasks isEqualTo []) then {
    [_group] call FUNC(taskGroup);
} else {
    _activeTasks sort true;
    if (_taskOrdered) then {
        _task = (_activeTasks select 0 select 2);
        _group setVariable [QGVAR(groupTaskOrder),[true,_activeTasks]];
    } else {
        _task = (_activeTasks select 0 select 2);
    };
};
if (!isNull _task) then {
    [_group,_task] call FUNC(taskSet);
};
true


