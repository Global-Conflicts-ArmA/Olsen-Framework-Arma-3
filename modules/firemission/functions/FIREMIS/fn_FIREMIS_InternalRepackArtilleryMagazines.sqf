#include "script_component.hpp"

private _unit = _this;
private _ammo = _unit call FUNC(FIREMIS_Dia_GetArtyAmmo);
{_unit removeMagazine _x} forEach (magazines _unit);
{
  _count  = _x select 1;
  _classNam = _x select 0;
  _maxAmmo = getNumber(configFile >> "CfgMagazines" >> _classNam >> "count");
  while{_count > 0} do
  {
    if(_count >= _maxAmmo) then
    {
        _unit addMagazine [_classNam,_maxAmmo];
    }
    else
    {
        _unit addMagazine [_classNam,_count];
    };
    _count = _count - _maxAmmo;
  };
} forEach _ammo;
