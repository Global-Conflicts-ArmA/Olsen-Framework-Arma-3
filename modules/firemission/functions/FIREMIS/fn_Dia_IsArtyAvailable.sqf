#include "script_component.hpp"

/* INFO("INFO: In Dia_IsArtyAvailable"); */

params [
  ["_unit", objNull, [objNull]]
];

private _artilleryInFiremission = (_unit) getVariable [VAR_SART_ARTINFIREMISSION, false];
private _artilleryAvailable = (_unit) getVariable [VAR_SART_IsAviable, true];

/* diag_log format ["Artillery %1 | In firemission = %2 | Available = %3", _unit, _artilleryInFiremission, _artilleryAvailable]; */

private _ret = (alive (_unit) && !(_artilleryInFiremission) && (_artilleryAvailable));
_ret;
