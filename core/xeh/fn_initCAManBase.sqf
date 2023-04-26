#include "..\script_macros.hpp"

params ["_unit"];
//LOG("Spawned_Event called");

if !(local _unit) exitWith {};

[QGVAR(spawnedEvent), [_unit]] call CBA_fnc_serverEvent;
