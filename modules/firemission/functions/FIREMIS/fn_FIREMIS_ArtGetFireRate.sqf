#include "script_component.hpp"

#include "..\..\Dia\Dia_Global.sqf"

private["_unit","_classname","_weaps","_reloadTime"];
_unit = _this;
_classname = typeOf(_unit);
_weaps = _unit weaponsTurret [0];
_reloadTime  = getNumber (configfile / "CfgWeapons" / (_weaps select 0) / "reloadTime");
_reloadTime
