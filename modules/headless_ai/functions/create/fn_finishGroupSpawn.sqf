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
    /* 9 */  ["_taskRadius", 100, [0]],
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
    if (GETMVAR(VerboseDebug,false)) then {
        LOG_2("Setting %1 to manual wp mode with: %2",_group,_waypoints);
    };
    _waypoints deleteAt 0;
    [_group, _waypoints] call FUNC(createWaypoints);
} else {
    private _retreatPos = GETVAR(_group,retreatPos,objNull);
    if (_retreatPos isNotEqualTo objNull) then {
        _retreatThreshold = GETVAR(_group,retreatThreshold,0.5);
        _retreatCount = floor((count units _group) * _retreatThreshold);
        [{  
            _group = _this select 0;
            _retreatCount = _this select 2;
            _subGroup = _group getVariable["subGroup", objNull];
            _subGroupCount = 0;
            if (_subGroup isNotEqualTo objNull) then {
                _subGroupCount = count units _subGroup;
            };
            (({ alive _x } count units _group) + _subGroupCount) <= _retreatCount;
        }, {
            params ["_group", "_retreatPos", "_retreatCount"];
            [_group, "RETREAT", _retreatPos, 50] call FUNC(taskAssign);
        }, [_group, _retreatPos, _retreatCount]] call CBA_fnc_waitUntilAndExecute;
    };

    if (GETVAR(_group,vehCargo,false)) then {
        SETVAR(_group,vehCargoOrigTask,_task);
        private _veh = vehicle leader _group;
        private _cargoGroups = GETVAR(_veh,vehCargoGroups,[]);
        _cargoGroups pushBackUnique _group;
        SETVAR(_veh,vehCargoGroups,_cargoGroups);
        if (GETMVAR(VerboseDebug,false)) then {
            TRACE_2("vehCargoGroups added",_veh,_cargoGroups);
        };
        _task = "CARGO";
        [_group] call FUNC(taskRelease);
    };
    if (GETMVAR(VerboseDebug,false)) then {
        LOG_2("Setting %1 to task: %2",_group,_task);
    };
    private _taskPos = _groupPos;
    private _taskPosValue = GETVAR(_group,taskPos,[ARR_3(0,0,0)]);
    if (_taskPosValue isEqualType "" && {markerColor _taskPosValue isNotEqualTo ""}) then {
        _taskPos = markerPos _taskPosValue;
        _taskRadius = (markerSize _taskPosValue select 0) max (markerSize _taskPosValue select 1);
    } else {
        if (_taskPosValue isNotEqualTo [0,0,0]) then {
            _taskPos = _taskPosValue;
        };
    };
    if (GETMVAR(VerboseDebug,false)) then {
        TRACE_2("",_group,_taskPos);
    };
    private _passarray = [_group,_task,_taskPos,_taskRadius,_taskWait,_behaviour,_combat,_speed,_formation];
    [{(count waypoints (_this select 0)) isNotEqualTo 0},{
        _this call FUNC(taskAssign);
    },_passarray] call CBA_fnc_waitUntilAndExecute;
};
