#include "script_component.hpp"

private _target = _this select 0;
private _destination = _this select 1;
private _title = _this select 2;
private _description = _this select 3;
private _wpTitle = _this select 4;

[_target, [_title], [_description, _title, _wpTitle], _destination, "Created", 1, true] call BIS_fnc_taskCreate;
[_title, _destination] call BIS_fnc_taskSetDestination;
