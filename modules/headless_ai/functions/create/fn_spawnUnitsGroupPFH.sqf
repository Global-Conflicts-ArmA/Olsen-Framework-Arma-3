#include "script_component.hpp"

params [
    ["_args", [], [[]]], 
    "_idPFH"
];

_args params [
    ["_group", grpNull, [grpNull]],
    ["_groupSet", [], [[]]],
    ["_groupMem", [], [[]]],
    ["_groupVeh", [], [[]]],
    ["_unitIndex", 0, [0]]
];

if (GETMVAR(VerboseDebug,false)) then {
    TRACE_3("unit spawn PFH",_group, count _groupMem, count _groupVeh);
};

_groupSet params [
    /* 0 */  ["_side", west, [west]],
    /* 1 */  ["_groupPos", [], [[]]],
    /* 2 */  ["_behaviour", "AWARE", [""]],
    /* 3 */  ["_combat", "YELLOW", [""]],
    /* 4 */  ["_speed", "normal", [""]],
    /* 5 */  ["_formation", "wedge", [""]],
    /* 6 */  ["_groupStance", "AUTO", [""]],
    /* 7 */  ["_groupInit", false, [false, {}, ""]],
    /* 8 */  ["_createRadius", 0, [0]],
    /* 9 */  ["_taskRadius", 30, [0]],
    /* 10 */ ["_taskWait", 3, [0]],
    /* 11 */ ["_startBuilding", false, [false]],
    /* 12 */ ["_task", "PATROL", [""]],
    /* 13 */ ["_taskTimer", 0, [0]],
    /* 14 */ ["_multi", 1, [1]],
    /* 15 */ ["_occupy", "Off", ["", 0]],
    /* 16 */ ["_vehAssigned", false, [false]],
    /* 17 */ ["_waypoints", [], [[]]],
    /* 18 */ ["_surfaceWater", false, [false]],
    /* 19 */ ["_fl", false, [false]],
    /* 20 */ ["_surrender", false, [false]],
    /* 21 */ ["_storedVars", [], [[]]],
    /* 22 */ ["_name", "", [""]],
    /* 23 */ ["_groupID", "", [""]],
    /* 24 */ ["_areaAssigned", "NONE", [""]],
    /* 25 */ ["_assetType", "INFANTRY", [""]]
];

if (GETMVAR(PFHBusy, false)) exitWith {};

if (_groupVeh isEqualTo []) then {
    if (_groupMem isEqualTo []) exitWith {
        if (GETMVAR(VerboseDebug,false)) then {
            TRACE_1("no more group members! finishing group spawn",_groupMem);
        };
        [_group, _groupSet] call FUNC(finishGroupSpawn);
        [_idPFH] call CBA_fnc_removePerFrameHandler;
    };
    private _startBld = _occupy isNotEqualTo "Off";
    private _toSpawn = _groupMem deleteAt 0;
    _args set [2, _groupMem];
    if (GETMVAR(VerboseDebug,false)) then {
        TRACE_1("unit spawn",_toSpawn);
    };

    [false, _group, _groupPos, _startBld, _unitIndex, _toSpawn] call FUNC(createUnit);
    _unitIndex = _unitIndex + 1;
    _args set [4, _unitIndex];
} else {
    private _toSpawn = _groupVeh deleteAt 0;
    _args set [3, _groupVeh];
    if (GETMVAR(VerboseDebug,false)) then {
        TRACE_1("vehicle spawn",_toSpawn);
    };

    [_group, _groupPos, _toSpawn] call FUNC(createVehicle);
};
