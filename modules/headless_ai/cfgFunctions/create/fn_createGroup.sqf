#include "..\..\script_macros.hpp"

params ["_args",
    ["_initial", false, [false]],
    ["_specialArgs", [], [[]]]
];

_args params [
    "",
    "_groupSet",
    "_groupMem",
    "_groupVehs"
];

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

createCenter _side;
private _group = createGroup _side;

SETVAR(_group,Spawned,true);

if (_name isNotEqualTo "") then {
    private _uniqueName = [_name] call FUNC(findUniqueName);
    missionNamespace setVariable [_uniqueName, _group, true];
};

if (_groupID isNotEqualTo "") then {
    _group setGroupIdGlobal [_groupID];
};

if (_storedVars isNotEqualTo []) then {
    _storedVars apply {
        _x params ["_varName", "_varValue"];
        _group setvariable [_varName, _varValue];
    };
};

if (_specialArgs isNotEqualTo []) then {
    _specialArgs apply {
        _x params ["_varName", "_varValue"];
        _group setvariable [_varName, _varValue];
    };
};
//using the initial / all group at once members for now
if (_initial) then {
    _groupVehs apply {
        [_group, _groupPos, _x, true] call FUNC(createVehicle);
    };
    {
        [false, _group, _groupPos, _startBuilding, _foreachIndex, _x, _createRadius] call FUNC(createUnit);
    } forEach _groupMem;
    [_group, _groupSet] call FUNC(finishGroupSpawn);
} else {
    private _groupArray = [_group, _groupSet, _groupMem, _groupVehs];
    TRACE_1("sending to spawn units pfh",_groupArray);
    [FUNC(spawnUnitsGroupPFH), 0.1, _groupArray] call CBA_fnc_addPerFrameHandler;
};

_group
