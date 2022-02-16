#include "script_component.hpp"

params [
    ["_args", [], [[]]], 
    "_idPFH"
];

_args params [
    ["_group", grpNull, [grpNull]],
    ["_groupPos", [0,0,0], [[]]],
    ["_vehicle", objNull, [objNull]],
    ["_fullCrew", [], [[]]],
    ["_init", false, [false, {}]],
    ["_storedVars", [], [[]]],
    ["_unitIndex", 0, [0]]
];

TRACE_3("vehicle spawn PFH",_group, _vehicle, count _fullCrew);

if (_fullCrew isEqualTo []) then {
    TRACE_1("no more veh members! finising veh spawn",_fullCrew);
    [_vehicle, _init, _storedVars] call FUNC(finishVehicleSpawn);
    [_idPFH] call CBA_fnc_removePerFrameHandler;
} else {
    private _toSpawn = _fullCrew deleteAt 0;
    _args set [3, _fullCrew];
    TRACE_1("vehicle spawn",_toSpawn);
    _toSpawn params ["_vehRole", "_userInfo"];
    _vehRole params ["_role", "_index"];
    private _unit = [false, _group, _groupPos, false, _unitIndex, _userInfo] call FUNC(createUnit);
    [{_this select 0 isNotEqualTo objNull}, {
        _this call FUNC(setAssignedVehicle);
    }, [_unit, _vehicle, _role, _index]] call CBA_fnc_waitUntilAndExecute;
    _unitIndex = _unitIndex + 1;
    _args set [6, _unitIndex];
};
