#include "script_component.hpp"

params [
  ["_id", 29378]
  /* ,["_shellSelect", 29379] */
];

private _guns = player getVariable [VAR_SART_OBSGUNS,[]];
private _usableGuns = [];

/* diag_log format ["INFO: _guns = %1", _guns]; */

_guns apply {
  if(_x call FUNC(Dia_IsArtyAvailable)) then
  {
    _usableGuns pushBack _x;
  };
};

/* diag_log format ["INFO: _usableGuns = %1", _usableGuns]; */

lbClear _id;
_usableGuns apply {
  lbAdd [_id,_x call FUNC(Dia_GetArtyDisplayName)];

};
lbSetCurSel [_id,0];
