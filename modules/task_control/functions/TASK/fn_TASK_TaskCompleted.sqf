#include "script_component.hpp"

private _title = _this select 0;

private _state = [_title] call FUNC(TASK_GetTaskState);
private _completed = false;

if (_state == "Succeeded") then {
  _completed = true;
};

_completed
