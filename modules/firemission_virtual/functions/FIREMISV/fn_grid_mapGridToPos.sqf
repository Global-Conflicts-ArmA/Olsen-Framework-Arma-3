#include "script_component.hpp"

params ["_grid", "_mils", "_dist"];

private	_degs = _mils * 0.05625;

private _locGrid = _grid call CBA_fnc_mapGridToPos;

private _ret = _locGrid getPos [_dist, _degs];

_ret
