#include "script_component.hpp"

private _title = _this select 0;

private _state = [_title] call BIS_fnc_taskState;

_state
