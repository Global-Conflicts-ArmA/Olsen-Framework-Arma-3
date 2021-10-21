#include "script_component.hpp"

params[
  ["_unit", objNull, [objNull]],
  ["_callGrid", [0,0], [[0,0]]],
  ["_mils", 0, [0]],
  ["_distance", 100, [100]],
  ["_dispersion", 100, [100]],
  ["_burstCount", 0, [0]],
  ["_burstSize", 0, [0]],
  ["_burstWait", 0, [0]],
  ["_minSpottedDistance", 100, [100]],
  ["_roundType", 0, [0]]
];

private	_loc = [_callGrid, true] call CBA_fnc_mapGridToPos;
private	_degrees = MILSPERROUND / _mils * 360.0;
private _dir = [cos _degrees, sin _degrees,0];

[_unit, _loc vectorAdd (_dir vectorMultiply _distance), _dispersion, _burstCount, _burstSize, _burstWait, _minSpottedDistance, _roundType] call FUNC(FIREMIS_PointFiremission);
