#include "..\script_macros.hpp"

params ["_unit"];
if !(local _unit) exitWith {};
if (
    _unit isKindOf "B_UAV_AI" ||
    _unit isKindOf "O_UAV_AI" ||
    _unit isKindOf "I_UAV_AI"
) exitWith {};

LOG("Killed_Event called");
[QGVAR(KilledEvent), _unit] call CBA_fnc_serverEvent;

if (isPlayer _unit) then {
    [_unit] call FUNC(killcam_killedHandle);
};