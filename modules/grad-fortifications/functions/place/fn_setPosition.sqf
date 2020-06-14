#include "script_component.hpp"
params ["_unit", "_fort"];

private _currentDistance = _unit getVariable [QGVAR(currentDistance),3];
private _pos = _unit getRelPos [_currentDistance,0];
_pos set [2, (_unit getVariable [QGVAR(currentHeight),0]) + (getPosATL _unit select 2)];

_fort setPos _pos;

_pos
