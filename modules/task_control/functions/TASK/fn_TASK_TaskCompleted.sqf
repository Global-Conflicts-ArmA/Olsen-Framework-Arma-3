#include "script_component.hpp"

params [
    ["_title", "", [""]]
];

private _state = [_title] call FUNC(TASK_GetTaskState);
private _completed = false;

if (_state == "Succeeded") then {
  _completed = true;
};

_completed
