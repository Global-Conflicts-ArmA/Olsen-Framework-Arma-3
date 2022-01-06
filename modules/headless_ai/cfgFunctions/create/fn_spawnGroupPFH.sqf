#include "..\..\script_macros.hpp"

if (GVAR(spawnQueue) isEqualTo []) exitWith {
    [GVAR(spawnGroupPFH)] call CBA_fnc_removePerFrameHandler;
    GVAR(spawnGroupPFH) = -1;
};

private _queueArray = GVAR(spawnQueue) deleteAt 0;
TRACE_1("",count _queueArray);

_queueArray params [
    ["_toSpawn", [], [[]]]
];

[_toSpawn, false] call FUNC(createGroup);
