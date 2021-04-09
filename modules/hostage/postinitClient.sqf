#include "..\..\core\script_macros.hpp"

params ["_unit"];

if !(local _unit) exitwith {};

private _hostageState = GETVAR(_unit,Enabled,false);
TRACE_2("Hostage InitPost",_unit,_hostageState);

if (_hostageState) then {
    [_unit] call FUNC(Set);
};
