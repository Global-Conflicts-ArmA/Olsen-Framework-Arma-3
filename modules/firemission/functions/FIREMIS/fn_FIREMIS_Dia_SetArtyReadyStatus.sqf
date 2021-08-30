#include "script_component.hpp"

private _unit = _this select 0;
private _isFiring = _this select 1;

_unit setVariable [VAR_SART_ARTINFIREMISSION,_isFiring,true];
["Event_ArtyIsReady", [_unit,_isFiring]] call CBA_fnc_globalEvent;
