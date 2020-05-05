#include "..\..\script_macros.hpp"


params [["_group",grpNull,[grpNull]],["_tasks",[],[[]]],["_visited",[],[[]]]];
private _unvisited = + _tasks;
while {count _unvisited > 0 } do {
    private _taskModule = _unvisited select 0;
    _unvisited deleteAt 0;
    _visited pushback _taskModule;
    private _taskGroups = _taskModule getVariable [QGVAR(taskGroups), []];
    _taskGroups pushBack _group;
    _taskModule setVariable [QGVAR(taskGroups), _taskGroups];
    _unvisited = _unvisited + (([_taskModule ,[QGVAR(TaskModule)]] call FUNC(getSyncedModules)) - _visited);
};
true
