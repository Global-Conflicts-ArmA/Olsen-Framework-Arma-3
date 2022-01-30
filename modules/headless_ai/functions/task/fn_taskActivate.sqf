#include "script_component.hpp"


{
    private _task = _x;
    {
        private _group = _x;
        _group setVariable[QGVAR(isNotZoneActivated),false];
        _group setVariable[QGVAR(CurrentTaskEndTime),CBA_missionTime - 1];
        [_group,_task] call FUNC(taskSet);
    } forEach (_task getVariable [QGVAR(taskGroups), []]);
} forEach _this;
true
