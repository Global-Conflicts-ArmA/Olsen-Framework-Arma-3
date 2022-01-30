#include "script_component.hpp"


//unit 1, unit 2
params ["_unit","_target"];

private _return = true;
private _targetpos = position _target;

_unit doWatch objnull;
_unit doTarget objnull;
_unit reveal [_target,4];
_unit glanceat _targetpos;
private _targetdir = (vehicle _unit) getdir _targetpos;
_unit setformdir _targetdir;
_unit doWatch _targetpos;
_unit doTarget _target;

_return
