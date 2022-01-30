#include "script_component.hpp"


params ["_group","_check",["_init",false,[false]],["_syncedTasks",[],[[]]],["_task",objNull,[objNull]],["_taskCheck",[],[[]]],["_taskOrder",[],[[]]]];
if ((GETVAR(_group,CurrentTaskEndTime,0) < CBA_MissionTime) || _init) then {
    if ( !isNull (_group getVariable[QGVAR(CurrentTask),objNull]) ) then {[_group,_check] call FUNC(setCompletedTasks);};
    private _groupTaskOrder = _group getVariable [QGVAR(groupTaskOrder),[]];
    if (count _groupTaskOrder > 1) then {_taskOrder = _groupTaskOrder select 1;};
    if (count _taskOrder > 0) then {
        private _tasks = _taskOrder select {!(_x in (_group getVariable[QGVAR(CompletedTasks),[]]))};
        if (_tasks isNotEqualTo []) then {
            _tasks sort (_groupTaskOrder select 0);
            _task = (_tasks select 0 select 2);
            _taskCheck = [_task];
        } else {
            private _sort = if (_groupTaskOrder select 0) then {false} else {true};
            _taskOrder sort _sort;
            _group setVariable[QGVAR(CompletedTasks),[]];
            [_group,(_taskOrder select 0 select 2)] call FUNC(setCompletedTasks);
            private _tasks = _taskOrder select {!(_x in (_group getVariable[QGVAR(CompletedTasks),[]]))};
            if (_tasks isNotEqualTo []) then {
                _task = (_tasks select 0 select 2);
                _taskCheck = [_task];
                _group setVariable [QGVAR(groupTaskOrder),[_sort,_taskOrder]];
            } else {
                _taskCheck = [(_group getVariable[QGVAR(CurrentTask),objNull])];
            };
        };
    } else {
        if (_init) then {
            private _groupSet = [_group] call FUNC(getGroupVariables);
            _syncedTasks = (_groupSet select 11);
        } else {
            if ((typeName _check) isEqualTo "GROUP") then {
                _syncedTasks = [(leader _check),[QGVAR(TaskModule)]] call FUNC(getSyncedModules);
            } else {
                _syncedTasks = [_check,[QGVAR(TaskModule)]] call FUNC(getSyncedModules);
            };
        };
        private _tasks = _syncedTasks select {!(_x in (_group getVariable[QGVAR(CompletedTasks),[]]))};
        if (_tasks isEqualTo []) then {
            private _index = GVAR(taskedGroups) find [_group];
            GVAR(taskedGroups) deleteAt _index;
        } else {
            private _activeTasks = [];
            {
                private _checkTask = _x;
                private _taskSet = _checkTask call FUNC(getTaskParams);
                _taskSet params ["_task","_cond","_prior","_time","_onComp","_taskId"];
                if (call _cond) then {
                    _activeTasks pushback [_taskId,_prior,_task];
                };
            } foreach _tasks;
            if ((_activeTasks isNotEqualTo [])) then {
                _activeTasks sort true;
                _task = (_activeTasks select 0 select 2);
            };
            _taskCheck = [_task];
        };
    };
} else { _taskCheck = [objNull]; };
_taskCheck
