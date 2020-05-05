#include "..\..\script_macros.hpp"


params ["_group","_i"];
([_group] call FUNC(getGroupVariables)) params ["_pos","_behaviour","_combat","_speed","_formation","_taskRadius","_wait","_task","_taskTimer","_occupyOption","_waypoints","_tasks","_fl","_surrender","_tracker"];
if (_occupyOption > 0 && _task < 6) then {
    if (_task isEqualTo 2 || _task isEqualTo 4 || _task isEqualTo 5) then {
        for "_i" from 0 to (count(units _group)) do {
            private _u = (units _group) select _i;
            _u setvariable[QGVAR(Occupy),true];
            private _blds = ["_spos","_taskRadius","_occupyOption","_groupcount"] call FUNC(getBuildingList);
            _blds params [["_bld",[],[[]]],["_bldPos",[],[[]]]];
            private _setBldPos = [_occupyOption,_i,_bld,_bldPos] call FUNC(setBuildingPos);
            _setBldPos params [["_spos",[],[[]]],["_uBld",objNull,[objNull]]];
            [_u,_uBld,_bldPos,_wait,[_behaviour,_combat,_speed,_formation]] spawn FUNC(taskBuildingPatrol);
        };
        _group setVariable[QGVAR(CompletedTasks),[]];
        _group setVariable[QGVAR(CurrentTaskEndTime),(CBA_MissionTime + _taskTimer)];
    };
    if (_task isEqualTo 0 || _task isEqualTo 1 || _task isEqualTo 3) then {
        {_x setvariable[QGVAR(Occupy),true]} forEach (units _group);
        _group setVariable[QGVAR(CompletedTasks),[]];
        _group setVariable[QGVAR(CurrentTaskEndTime),(CBA_MissionTime + _taskTimer)];
        [{!((count waypoints (_this select 1)) isEqualTo 0)}, {
            _this call FUNC(taskAssign);
        },[_task,_group,_pos,_taskRadius,_wait,_behaviour,_combat,_speed,_formation,_occupyOption]] call CBA_fnc_waitUntilAndExecute;
    };
} else {
    _group setVariable[QGVAR(CompletedTasks),[]];
    _group setVariable[QGVAR(CurrentTaskEndTime),(CBA_MissionTime + _taskTimer)];
    [{!((count waypoints (_this select 1)) isEqualTo 0)},{
        _this call FUNC(taskAssign);
    },[_task,_group,_pos,_taskRadius,_wait,_behaviour,_combat,_speed,_formation,_occupyOption]] call CBA_fnc_waitUntilAndExecute;
};
