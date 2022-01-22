#include "script_component.hpp"

params[
  ["_unit", objNull, [objNull]],
  ["_pos", [0,0], [[]]],
  ["_ammo", "", [""]]
];

private _ret = _unit getArtilleryETA [_pos, _ammo];
_ret
