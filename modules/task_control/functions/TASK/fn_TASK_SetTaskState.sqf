#include "script_component.hpp"

params [
    ["_title", "", [""]],
    ["_state", "", [""]]
];

[_title, _state] call BIS_fnc_taskSetState;
