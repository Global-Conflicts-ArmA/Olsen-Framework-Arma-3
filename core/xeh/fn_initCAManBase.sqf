#include "..\script_macros.hpp"

params ["_unit"];

[QGVAR(eventSpawned), [_unit]] call CBA_fnc_serverEvent;


