#include "..\..\script_macros.hpp"

params ["_args", ["_specialArgs", [], [[]]]];
_args params [
    "",
    "_groupSet",
    "_groupMem",
    ["_currentVeh",objNull,[objNull]]
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
    /* 26 */ "_assetType",
    /* 27 */ ["_manualPos", [0,0,0], [[]]]
];

createCenter _side;
private _group = createGroup _side;

SETVAR(_group,Spawned,true);

if !(_name isEqualTo "") then {
    private _uniqueName = [_name] call FUNC(findUniqueName);
    missionNamespace setVariable [_uniqueName, _group, true];
};

if !(_groupID isEqualTo "") then {
    _group setGroupIdGlobal [_groupID];
};

if !(_storedVars isEqualTo []) then {
    {
        _x params ["_varName", "_varValue"];
        _group setvariable [_varName, _varValue];
    } forEach _storedVars;
};

if !(_specialArgs isEqualTo []) then {
    {
        _x params ["_varName", "_varValue"];
        _group setvariable [_varName, _varValue];
    } forEach _specialArgs;
};

{
    if ((_x select 0)) then {
        private _u = [false, _group, _groupPos, _startBld, _foreachIndex, _x, _taskRadius, _currentVeh] call FUNC(createUnit);
    } else {
        private _vpos = (_x select 2);
        private _v = [_vpos, _x, _side] call FUNC(createVehicle);
        _currentVeh = _v;
    };
} foreach _groupMem;

[_group,_groupSet] call FUNC(setGroupVariables);
_group call CBA_fnc_clearWaypoints;

if (((GETVAR(leader _group,noAI,false)) || {GETVAR(_group,noAI,false)}) || {(count _waypoints > 1) && {_task isEqualTo "NONE"}}) then {
    LOG_2("Setting %1 to manual wp mode with: %2",_group,_waypoints);
    [_group,_waypoints] call FUNC(createWaypoints);
} else {
    LOG_2("Setting %1 to task: %2",_group,_task);
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
