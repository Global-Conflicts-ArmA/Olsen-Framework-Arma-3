#include "script_component.hpp"

private _unit =_this;
private _ret = [];
private _possibleMags = getArray (configfile >> "CfgWeapons">>  (((_unit) weaponsTurret [0]) select 0) >> "magazines");
{
  _ret pushBack [_forEachIndex,_x,getText (configfile >> "CfgMagazines">>  _x >> "displayName")];
}forEach _possibleMags;
_ret
