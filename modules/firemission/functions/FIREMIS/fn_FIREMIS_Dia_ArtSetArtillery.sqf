#include "script_component.hpp"

params[
  ["_id", 29379, [29379]],
  ["_gun", 0, [0]]
];

if(_gun >= 0) then
{
  _guns = player getVariable [VAR_SART_OBSGUNS,[]];
  _usableGuns = [];
  {
    if(_x call FUNC(FIREMIS_Dia_IsArtyAvailable)) then
    {
      _usableGuns pushBack _x;
    };
  }forEach _guns;
  _actualGunUnit = _usableGuns select _gun;
  lbClear _id;
  _ammo = _actualGunUnit call FUNC(FIREMIS_Dia_GetArtyAmmo);

  {
    _text = (str (_x select 1)) + "x " + getText (configfile / "CfgMagazines" / (_x select 0) / "displayName");
    lbAdd [_id, _text];

  }forEach _ammo;
  lbSetCurSel [_id,0];
}
