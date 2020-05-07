#include "..\script_macros.hpp"

params ["_unit"];

[QGVAR(eventKilled), [_unit]] call CBA_fnc_serverEvent;

