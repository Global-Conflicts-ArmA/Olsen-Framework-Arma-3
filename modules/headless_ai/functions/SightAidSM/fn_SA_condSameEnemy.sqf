#include "script_component.hpp"

params ["_unit"];

if (_unit getVariable [QGVAR(busy), false]) exitWith {false};

private _target = _unit getVariable [QGVAR(SA_target), objNull];
private _canSee = [_unit, _target, false, false] call FUNC(LOSCheck);

_canSee