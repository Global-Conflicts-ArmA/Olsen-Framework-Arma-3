#include "..\script_macros.hpp"

params ["_unit"];
if !(local _unit) exitWith {};

LOG("Spawned_Event called");

[QGVAR(SpawnedEvent), _this] call CBA_fnc_serverEvent;


