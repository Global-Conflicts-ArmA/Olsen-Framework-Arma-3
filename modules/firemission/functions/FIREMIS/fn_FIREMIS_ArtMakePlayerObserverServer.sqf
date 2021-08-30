#include "script_component.hpp"

private _unit = _this select 0;
private	_guns = _this select 1;
if (isServer) then
{


    _unit setVariable [VAR_SART_OBSGUNS,_guns,true];
    ["Event_ReceiveFoGuns",_guns,_unit] call CBA_fnc_targetEvent;

};
