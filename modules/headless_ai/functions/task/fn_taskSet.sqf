#include "script_component.hpp"


params ["_group",["_newTask",objNull,[objNull]],["_setTime",0,[0]]];
if (!isNull _newTask) then {
    (_newTask call FUNC(getTaskParams)) params ["_newTask","_cond","_prior","_time","_onComp","_TaskId","_radius","_task","_occupy","_wait","_behaviour","_combat","_speed","_form","_stance"];
    if (_time isEqualTo 0) then {
        _setTime = 1E10;
    } else {
        _setTime = _time;
    };
    _group setVariable[QGVAR(CurrentTaskEndTime),(CBA_MissionTime + _setTime)];
    if (!isNull (_group getVariable[QGVAR(CurrentTask),objNull])) then {
        [_group,(_group getVariable[QGVAR(CurrentTask),objNull])] call FUNC(taskComplete);
    };
    _group setVariable[QGVAR(CurrentTask),_newTask];
    _group call CBA_fnc_clearWaypoints;
    if ((_stance isNotEqualTo "unchanged")) then {
        {
            _x setUnitPos _stance;
        } forEach (units _group);
    };
    private _newBehave = if (_behaviour isEqualTo "unchanged") then {(behaviour (leader _group))} else {_behaviour};
    private _newCombat = if (_combat isEqualTo "unchanged") then {(combatMode _group)} else {_combat};
    private _newSpeed = if (_speed isEqualTo "unchanged") then {(speedMode _group)} else {_speed};
    private _newForm = if (_form isEqualTo "unchanged") then {(formation _group)} else {_form};
    private _passarray = [_group,_task,(getPosATL _newTask),_radius,_wait,_newBehave,_newCombat,_newSpeed,_newForm,_occupy];
    [{!((count waypoints (_this select 0)) isEqualTo 0)},{
        _this call FUNC(taskAssign);
    },_passarray] call CBA_fnc_waitUntilAndExecute;
};
true
