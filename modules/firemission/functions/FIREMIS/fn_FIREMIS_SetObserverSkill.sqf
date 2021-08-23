#include "script_component.hpp"

#include "..\..\Dia\Dia_Global.sqf"

private _unit  = _this select 0;
private _accuracy = _this select 1;
private _speed = _this select 2;
_unit setVariable [VAR_SART_OBSACCURACY,_accuracy];
_unit setVariable [VAR_SART_OBSSPEED,_speed];
