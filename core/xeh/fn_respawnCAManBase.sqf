#include "..\script_macros.hpp"

params ["_unit"];

[QGVAR(eventRespawn), [_unit]] call CBA_fnc_serverEvent;

