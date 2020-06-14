#include "script_component.hpp"
params ["_unit", "_fort"];

private _currentDirection = _unit getVariable [QGVAR(currentDirection),0];
private _dir = (getDir _unit) + _currentDirection;
_fort setDir _dir;

_dir
