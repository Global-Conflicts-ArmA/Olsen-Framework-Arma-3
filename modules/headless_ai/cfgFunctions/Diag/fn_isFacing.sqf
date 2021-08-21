#include "..\..\script_macros.hpp"


//unit 1, unit 2
params ["_unit", ["_target", objnull, [objnull]]];

if (_target isEqualTo objnull) exitwith {false};

private _targetPos = getposATL _target;
private _relDir = _unit getRelDir _targetPos;

private _facing = if !((_relDir <= 90) || {_relDir >= 270}) then {
    true;
﻿} else {
    false;
};

_facing
