#include "..\..\script_macros.hpp"

params ["_args", ["_specialArgs", [], [[]]]];
_args params [
    "",
    "_groupSet",
    "_groupMem"
];

_groupSet params [
    /* 0 */ "_side",
    /* 1 */ "_groupPos",
    /* 2 */ "_behaviour",
    /* 3 */ "_combat",
    /* 4 */ "_speed",
    /* 5 */ "_formation",
    /* 6 */ "_groupStance",
    /* 7 */ "_groupInit",
    /* 8 */ "_createRadius",
    /* 9 */ "_taskRadius",
    /* 10 */ "_wait",
    /* 11 */ "_startBld",
    /* 12 */ "_task",
    /* 13 */ "_taskTimer",
    /* 14 */ "_multi",
    /* 15 */ "_occupyOption",
    /* 16 */ "_vehAssigned",
    /* 17 */ "_waypoints",
    /* 18 */ "_onWater",
    /* 19 */ "_fl",
    /* 20 */ "_surrender",
    /* 21 */ "_tracker",
    /* 22 */ "_storedVars",
    /* 23 */ "_name",
    /* 24 */ "_groupID",
    /* 25 */ "_areaAssigned",
    /* 26 */ "_assetType"
];

createCenter _side;
private _group = createGroup _side;

SETVAR(_group,Spawned,true);

if (_name isNotEqualTo "") then {
    private _uniqueName = [_name] call FUNC(findUniqueName);
    missionNamespace setVariable [_uniqueName, _group, true];
};

if (_name isNotEqualTo "") then {
    _group setGroupIdGlobal [_groupID];
};

if (_storedVars isNotEqualTo []) then {
    {
        _x params ["_varName", "_varValue"];
        _group setvariable [_varName, _varValue];
    } forEach _storedVars;
};

if (_storedVars isNotEqualTo []) then {
    {
        _x params ["_varName", "_varValue"];
        _group setvariable [_varName, _varValue];
    } forEach _specialArgs;
};

{
    if ((_x select 0)) then {
        private _u = [false, _group, _groupPos, _startBld, _foreachIndex, _x, _taskRadius] call FUNC(createUnit);
    } else {
        private _vpos = (_x select 2);
        private _v = [_vpos, _x, _side] call FUNC(createVehicle);
    };
} foreach _groupMem;

[_group,_groupSet] call FUNC(setGroupVariables);
_group call CBA_fnc_clearWaypoints;

if ((GETVAR(leader _group,noAI,false) || {GETVAR(_group,noAI,false)}) || {(count _waypoints > 1) && {_task isEqualTo "NONE"}}) then {
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
    };
    LOG_2("Setting %1 to task: %2",_group,_task);
    private _manualPos = GETVAR(_group,taskPos,[ARR_3(0,0,0)]);
    private _taskPos = if (_manualPos isEqualTo [0,0,0]) then {
        _groupPos
    } else {
        _manualPos
    };
    TRACE_2("",_group,_taskPos);
    private _passarray = [_task,_group,_taskPos,_taskRadius,_wait,_behaviour,_combat,_speed,_formation,_occupyOption];
    [{!((count waypoints (_this select 1)) isEqualTo 0)},{
        _this call FUNC(taskAssign);
    },_passarray] call CBA_fnc_waitUntilAndExecute;
};
_group
