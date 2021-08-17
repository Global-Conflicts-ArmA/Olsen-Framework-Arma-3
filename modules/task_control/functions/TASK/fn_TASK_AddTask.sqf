#include "script_component.hpp"

params [
    ["_target", blufor],
    ["_destination", objNull],
    ["_title", "", [""]],
    ["_description", "", [""]],
    ["_wpTitle", "", [""]]
];

[_target, [_title], [_description, _title, _wpTitle], _destination, "Created", 1, true] call BIS_fnc_taskCreate;
[_title, _destination] call BIS_fnc_taskSetDestination;
