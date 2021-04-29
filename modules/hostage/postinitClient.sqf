#include "..\..\core\script_macros.hpp"
#include "settings.sqf"

params ["_unit"];

diag_log format ["Unit: %1", _unit];
diag_log format ["Passed params: %1", _this];

if !(local _unit) exitwith {};

private _hostageState = GETVAR(_unit, Enabled, false);
TRACE_2("Hostage InitPost", _unit, _hostageState);

if (_hostageState) then {
    [_unit] call FUNC(HOST_SetHostage);
};
