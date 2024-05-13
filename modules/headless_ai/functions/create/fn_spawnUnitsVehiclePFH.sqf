#include "script_component.hpp"

params [
    ["_args", [], [[]]],
    "_idPFH"
];

_args params [
    ["_group", grpNull, [grpNull]],
    ["_groupPos", [0,0,0], [[]]],
    ["_vehicle", objNull, [objNull]],
    ["_vehCrew", [], [[]]],
    ["_cargoGroup", grpNull, [grpNull]],
    ["_cargoGroupInfo", [], [[]]],
    ["_cargoCrew", [], [[]]],
    ["_init", false, [false, {}]],
    ["_storedVars", [], [[]]],
    ["_unitIndex", 0, [0]]
];

if (GETMVAR(VerboseDebug,false)) then {
    TRACE_3("vehicle spawn PFH",_vehicle, count _vehCrew, count _cargoCrew);
};

if (_vehCrew isEqualTo []) then {
    if (_cargoCrew isEqualTo []) then {
        if (GETMVAR(VerboseDebug,false)) then {
            TRACE_1("no more veh members! finishing veh spawn",_vehCrew);
        };
        if (_cargoGroup isNotEqualTo grpNull) then {
            [_cargoGroup, _cargoGroupInfo] call FUNC(finishGroupSpawn);
        };
        [_vehicle, _init, _storedVars] call FUNC(finishVehicleSpawn);
        [_idPFH] call CBA_fnc_removePerFrameHandler;
    } else {
        private _toSpawn = _cargoCrew deleteAt 0;
        _args set [6, _cargoCrew];
        if (GETMVAR(VerboseDebug,false)) then {
            TRACE_1("vehicle cargo spawn",_toSpawn);
        };
        _toSpawn params ["_vehRole", "_userInfo"];
        _vehRole params ["_role", "_index"];
        private _unit = [false, _cargoGroup, _groupPos, false, _unitIndex, _userInfo] call FUNC(createUnit);
        [{_this select 0 isNotEqualTo objNull}, {
            _this call FUNC(setAssignedVehicle);
        }, [_unit, _vehicle, _role, _index]] call CBA_fnc_waitUntilAndExecute;
        _unitIndex = _unitIndex + 1;
        _args set [9, _unitIndex];
    };
} else {
    private _toSpawn = _vehCrew deleteAt 0;
    _args set [3, _vehCrew];
    if (GETMVAR(VerboseDebug,false)) then {
        TRACE_1("vehicle spawn",_toSpawn);
    };
    _toSpawn params ["_vehRole", "_userInfo"];
    _vehRole params ["_role", "_index"];
    private _unit = [false, _group, _groupPos, false, _unitIndex, _userInfo] call FUNC(createUnit);
    [{_this select 0 isNotEqualTo objNull}, {
        _this call FUNC(setAssignedVehicle);
    }, [_unit, _vehicle, _role, _index]] call CBA_fnc_waitUntilAndExecute;
    _unitIndex = _unitIndex + 1;
    _args set [9, _unitIndex];
};
