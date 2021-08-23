#include "script_component.hpp"

#include "..\..\Dia\Dia_Global.sqf"

if (isServer) then
{
    [_this , false] call FNC_SetArtyReadyStatus;
    [_this , false] call FNC_SetArtyReadyStatus;
    terminate (_this getVariable [VAR_SART_FMHANDLE,scriptNULL]);

};
