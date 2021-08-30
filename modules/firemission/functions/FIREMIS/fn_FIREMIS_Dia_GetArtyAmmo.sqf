#include "script_component.hpp"

private _unit =_this;
private _ammo = magazinesAmmo _unit;
private _ret = [];
private _possibleMags = getArray (configfile >> "CfgWeapons">>  (((_unit) weaponsTurret [0]) select 0) >> "magazines");
{
  _ret pushBack [_x,0];
}forEach _possibleMags;

{
  _check = _x;
  _found = false;
  {
    if(_x select 0 == _check select 0) then
    {
      _found = true;
      _num = (_check select 1) + (_x select 1);
      _x set [1,_num];
    }
  }forEach _ret;
  if(!_found) then
  {
    hint "GetArtyAmmo Error";
  };

}forEach _ammo;
_ret
