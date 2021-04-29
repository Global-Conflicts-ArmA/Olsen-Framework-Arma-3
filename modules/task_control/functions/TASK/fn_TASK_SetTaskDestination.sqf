#include "script_component.hpp"

private _title = _this select 0;
private _destination = _this select 1;

[_title, _destination] call BIS_fnc_taskSetDestination;
