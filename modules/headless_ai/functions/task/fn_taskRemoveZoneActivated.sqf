#include "script_component.hpp"


private _tasks = _this;
private _zoneTasks = [];
_tasks apply {
    if (_x getVariable[QGVAR(taskZoneActivated),false]) then {
        _zoneTasks pushBack _x;
    };
};
_tasks = _tasks - _zoneTasks;
_tasks
