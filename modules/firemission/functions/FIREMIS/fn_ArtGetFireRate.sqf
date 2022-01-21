#include "script_component.hpp"

params[
  ["_unit", objNull, [objNull]]
];

private _weaps = _unit weaponsTurret [0];
private _reloadTime  = getNumber (configfile / "CfgWeapons" / (_weaps select 0) / "reloadTime");
_reloadTime
