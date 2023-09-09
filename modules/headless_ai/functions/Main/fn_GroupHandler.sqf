#include "script_component.hpp"

LOG("Starting GroupHandlerPFH");

GVAR(GroupHandlerPFH) = [{
    allGroups select {
        (GETVAR(_x,Spawned,false)) &&
        {!isNull leader _x} &&
        {alive leader _x} &&
        {!(GETVAR(leader _x,NOAI,false))} &&
        {!(GETVAR(_x,NOAI,false))} &&
        {!(isPlayer leader _x)}
    } apply {
        private _group = _x;
        private _lastTimeChecked = GETVAR(_group,lastTimeChecked,-1);
        private _units = units _group;
        private _aliveUnits = _units select {alive _x};
        private _leader = leader _group;
        private _side = side _leader;
        private _task = GETVAR(_group,Task,"NONE");
        private _position = getposATL _leader;
        private _areaAssigned = GETVAR(_group,areaAssigned,"NONE");
        private _assetType = GETVAR(_group,assetType,"INFANTRY");
        private _groupcount = count _aliveUnits;
        private _behaviour = behaviour _leader;
        private _target = GETVAR(_group,CurrentTarget,objNull);
        if (assignedTarget _leader isEqualTo objNull) then {
            // reset target to objNull
            if (_target isNotEqualTo objNull) then {
                _target = objNull;
                SETVAR(_group,CurrentTarget,objNull);
            };
            // reset back to original task?
        } else {
            if (
                _target isEqualTo objNull &&
                {!(_target call EFUNC(FW,isAlive))}
            ) then {
                TRACE_2("set target on active group",_group,_target);
                _target = assignedTarget _leader;
                SETVAR(_group,CurrentTarget,_target);
                // react
                // switch tasks on actions
                // handle for special loiter task - regroup
                if (_task isEqualTo "LOITER") then {
                    _group setSpeedMode "FULL";
        			_units apply {_x setUnitPos "Auto"; _x doFollow _leader};
                    [_group, _target] call FUNC(CombatDefend);
                };
                if (_task in ["PATROL", "PERIMPATROL", "SENTRY", "BLDMOVE"]) then {
                    //TRACE_2("non combat task check",_group,_task);
                    [_group, _target] call FUNC(CombatDefend);
                };
                //radio for help
                if ((GETMVAR(RadioDistance,2000)) > 0) then {
                    if (
                        !(GETMVAR(RadioNeedRadio,false)) ||
                        {(_group call FUNC(hasRadioGroup)) select 0}
                    ) then {
                        private _radioWait = GETMVAR(RadioWait,30);
                        private _lastCallTime = GETVAR(_group,LastCallTime,(CBA_MissionTime - _radioWait));
                        if (
                            CBA_MissionTime >= (_lastCallTime + _radioWait) &&
                            {!(GETVAR(_group,Reinforcing,false))}
                        ) then {
                            TRACE_1("radio call for support",_group);
                            SETVAR(_group,LastCallTime,CBA_MissionTime);
                            if (
                                GVAR(CommanderEnabled) &&
                                {side _group isEqualTo (GETMVAR(CommanderSide,east))}
                            ) then {
                                [_group,_target] call FUNC(RadioReportThreat);
                            } else {
                                [_group,_target,_side] call FUNC(RadioCallForSupport);
                            };
                        };
                    };
                };
            } else {
                if (_task isEqualTo "MANUAL") then {
                    private _lastWaypointTime = GETVAR(_group,lastWaypointTime,CBA_MissionTime - 3);
                    private _currentWaypoint = currentWaypoint _group;
                    private _waypoints = waypoints _group;
                    if (
                        _currentWaypoint > (count _waypoints - 1) &&
                        {(_group getVariable [QGVAR(Task), "PATROL"]) isEqualTo "MANUAL"}
                    ) then {
                        [_group, _position] call FUNC(taskPatrol);
                    };
                };
            };
            // no enemy detected - what do?
        };
        if (GETMVAR(UseMarkers,false)) then {
            //TRACE_2("",GVAR(markerTrackedGroups),str _group);
            GVAR(markerTrackedGroups) set [str _group, [
                _group,
                _side,
                _leader,
                _groupcount,
                _task,
                _behaviour,
                _target,
                _position,
                _areaAssigned,
                _assetType
            ]]
        };
        // AI Commander
        if (
            (GETMVAR(CommanderEnabled,false)) &&
            {!(GETVAR(_group,CommanderExempt,false))} &&
            {side _group isEqualTo (GETMVAR(CommanderSide,east))} &&
            {!(_group in GVAR(CommanderAssets))}
        ) then {
            // add to commander asset array
            GVAR(CommanderAssets) pushBackUnique _group;
        };
        SETVAR(_group,lastTimeChecked,CBA_missionTime);
    };
}, 1] call CBA_fnc_addPerFrameHandler;
