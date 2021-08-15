#include "script_component.hpp"

params [
    ["_title", "", [""]]
];

private _state = [_title] call BIS_fnc_taskState;

_state
