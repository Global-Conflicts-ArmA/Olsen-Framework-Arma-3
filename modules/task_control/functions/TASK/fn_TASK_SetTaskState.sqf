#include "script_component.hpp"

private _title = _this select 0;
private _state = _this select 1;

[_title, _state] call BIS_fnc_taskSetState;
