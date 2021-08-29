#include "script_component.hpp"
#include "defs.hpp"

params [
  ["_id", 29378],
  ["_shellSelect", 29379]
];

private _guns = player getVariable [VAR_SART_OBSGUNS,[]];
private _usableGuns = [];

diag_log format ["INFO: _guns = %1", _guns];

{
  if(_x call FUNC(FIREMIS_Dia_IsArtyAvailable)) then
  {
    _usableGuns pushBack _x;
  };
}forEach _guns;

diag_log format ["INFO: _usableGuns = %1", _usableGuns];

lbClear _id;
{
  lbAdd [_id,_x call FUNC(FIREMIS_Dia_GetArtyDisplayName)];

}forEach _usableGuns;
lbSetCurSel [_id,0];
