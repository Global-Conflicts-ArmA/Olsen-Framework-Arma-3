#include "..\script_macros.hpp"

params ["_unit"];
//LOG("Spawned_Event called");

if !(local _unit) exitWith {};
if (
    _unit isKindOf "B_UAV_AI" ||
    _unit isKindOf "O_UAV_AI" ||
    _unit isKindOf "I_UAV_AI"
) exitWith {};

[QGVAR(spawnedEvent), [_unit]] call CBA_fnc_serverEvent;
