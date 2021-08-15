#include "script_component.hpp"

params [
    ["_title", "", [""]],
    ["_destination", objNull]
];

[_title, _destination] call BIS_fnc_taskSetDestination;
