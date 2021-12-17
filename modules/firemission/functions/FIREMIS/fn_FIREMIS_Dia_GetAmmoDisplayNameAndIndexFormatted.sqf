#include "script_component.hpp"

private _unit =_this;
private _ammo = [];
private _ret = "";
private _possibleMags = getArray (configfile >> "CfgWeapons">>  (((_unit) weaponsTurret [0]) select 0) >> "magazines");
{
  _ammo pushBack [_forEachIndex,_x,getText (configfile >> "CfgMagazines">>  _x >> "displayName")];
}forEach _possibleMags;
{
  _ret = _ret + "Index: " + str(_x select 0) + "Classname: " + (_x select 1) + "Displayname: " + (_x select 2) + "\n";
}forEach _ammo;
_ret
