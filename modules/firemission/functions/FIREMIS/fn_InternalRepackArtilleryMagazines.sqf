#include "script_component.hpp"

private _unit = _this;
private _ammo = _unit call FUNC(Dia_GetArtyAmmo);
{_unit removeMagazine _x} forEach (magazines _unit);
{
  private _count  = _x select 1;
  private _className = _x select 0;
  private _maxAmmo = getNumber(configFile >> "CfgMagazines" >> _className >> "count");
  while{_count > 0} do
  {
    if(_count >= _maxAmmo) then
    {
        _unit addMagazine [_className,_maxAmmo];
    }
    else
    {
        _unit addMagazine [_className,_count];
    };
    _count = _count - _maxAmmo;
  };
} forEach _ammo;
