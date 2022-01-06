#include "..\script_macros.hpp"

params ["_unit"];
//LOG("Spawned_Event called");

if !(local _unit) exitWith {};

//LOG("Spawned_Event called past local check");

[QGVAR(spawnedEvent), [_unit]] call CBA_fnc_serverEvent;


