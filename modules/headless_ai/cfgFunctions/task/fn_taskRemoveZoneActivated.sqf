#include "..\..\script_macros.hpp"


private _tasks = _this;
private _zoneTasks = [];
{
    if (_x getVariable[QGVAR(taskZoneActivated),false]) then {
        _zoneTasks pushBack _x;
    };
} forEach _tasks;
_tasks = _tasks - _zoneTasks;
_tasks
