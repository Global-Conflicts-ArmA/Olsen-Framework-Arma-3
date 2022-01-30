#include "script_component.hpp"


{
    _x params ["_group"];
    if (({alive _x} count (units _group) > 0) && {_group getVariable[QGVAR(isNotZoneActivated),true]}) then {
        if (isNull (_group getVariable[QGVAR(CurrentTask),objNull])) then {
            private _taskCheck = [_group,_group,true] call FUNC(taskCheck);
            _taskCheck params [["_task",objNull,[objNull]]];
            if (!isNull _task) then {
                [_group,_task] call FUNC(taskSet);
            };
        } else {
            private _taskCheck = [_group,(_group getVariable[QGVAR(CurrentTask),objNull])] call FUNC(taskCheck);
            _taskCheck params [["_task",objNull,[objNull]]];
            if (GETVAR(_group,CurrentTaskEndTime,0) < CBA_MissionTime && (!isNull _task)) then {
                [_group,_task] call FUNC(taskSet);
            };
        };
    } else {
        _index = GVAR(taskedGroups) find [_group];
        GVAR(taskedGroups) deleteAt _index;
    };
} forEach GVAR(taskedGroups);
true
