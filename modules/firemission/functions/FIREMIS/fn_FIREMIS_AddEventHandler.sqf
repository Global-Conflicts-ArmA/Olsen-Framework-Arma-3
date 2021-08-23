#include "script_component.hpp"

#include "..\..\Dia\Dia_Global.sqf"

if(!((_this) getVariable [VAR_SART_ARTHASEH,false])) then
{
    (_this) addeventhandler ["fired", {(_this select 0) setvehicleammo 1}];
    (_this) setVariable [VAR_SART_ARTHASEH,true];
};
