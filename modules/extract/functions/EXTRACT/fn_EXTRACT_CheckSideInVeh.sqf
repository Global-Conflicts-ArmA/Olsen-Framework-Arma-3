#include "script_component.hpp"

params [
    ["_veh", objNull, [objNull]],
    ["_side", sideEmpty, [sideEmpty]]
];

private _units = playableUnits select {side _x isEqualTo _side};

private _result = [_veh, _units] call FUNC(EXTRACT_CheckArrayInVeh);

_result;
