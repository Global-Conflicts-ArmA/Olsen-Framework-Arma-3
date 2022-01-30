#include "script_component.hpp"


params ["_group",["_task",objNull,[objNull]]];
private _taskSet = _task call FUNC(getTaskParams);
_taskSet params ["_task","_cond","_prior","_time","_onComp"];
[_group,_task] call _onComp;
[_group,_task] call FUNC(setCompletedTasks);
true
