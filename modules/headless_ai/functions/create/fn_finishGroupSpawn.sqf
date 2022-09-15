#include "script_component.hpp"

params [
    ["_group", grpNull, [grpNull]],
    ["_groupSet", [], [[]]]
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

[_group,_groupSet] call FUNC(setGroupVariables);
_group call CBA_fnc_clearWaypoints;

if (
    _task isEqualTo "MANUAL" ||
    (GETVAR(leader _group,noAI,false)) ||
    (GETVAR(_group,noAI,false)) ||
    {(count _waypoints > 1) && {_task isEqualTo "NONE"}}
) then {
    LOG_2("Setting %1 to manual wp mode with: %2",_group,_waypoints);
    _waypoints deleteAt 0;
    [_group, _waypoints] call FUNC(createWaypoints);
} else {
    if (GETVAR(_group,vehCargo,false)) then {
        SETVAR(_group,vehCargoOrigTask,_task);
        private _veh = vehicle leader _group;
        private _cargoGroups = GETVAR(_veh,vehCargoGroups,[]);
        _cargoGroups pushBackUnique _group;
        SETVAR(_veh,vehCargoGroups,_cargoGroups);
        TRACE_2("vehCargoGroups added",_veh,_cargoGroups);
        _task = "CARGO";
        [_group] call FUNC(taskRelease);
    };
    LOG_2("Setting %1 to task: %2",_group,_task);
    private _manualPos = GETVAR(_group,taskPos,[ARR_3(0,0,0)]);
    private _taskPos = if (_manualPos isEqualTo [0,0,0]) then {
        _groupPos
    } else {
        _manualPos
    };
    TRACE_2("",_group,_taskPos);
    private _passarray = [_group,_task,_taskPos,_taskRadius,_wait,_behaviour,_combat,_speed,_formation,_occupyOption];
    [{(count waypoints (_this select 0)) isNotEqualTo 0},{
        _this call FUNC(taskAssign);
    },_passarray] call CBA_fnc_waitUntilAndExecute;
};
