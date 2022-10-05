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
        private _assetType = GETVAR(_group,assetType,"Infantry");
        private _groupcount = count _aliveUnits;
        private _behaviour = behaviour _leader;
        private _target = GETVAR(_group,CurrentTarget,objNull);
        if (
            _target isNotEqualTo objNull &&
            {
                assignedTarget _leader isEqualTo objNull ||
                {!(_target call EFUNC(FW,isAlive))}
            }
        ) then {
            _target = objNull;
            SETVAR(_group,CurrentTarget,objNull);
        };
        //if (_target isEqualTo objNull && {assignedTarget _leader isNotEqualTo objNull}) then {
        //    TRACE_2("set target on active group",_group,_target);
        //    _target = leader (assignedTarget _leader);
        //    if (_target isEqualTo objNull) then {
        //        private _targetCounter = GETVAR(_group,NullTargetCounter,0);
        //        if (_targetCounter >= 5) then {
        //            TRACE_1("no longer in combat, exiting and resetting",_group);
        //            SETVAR(_group,NullTargetCounter,0);
        //            private _originalBeh = GETVAR(_group,behaviour,"AWARE");
        //            private _originalCM = GETVAR(_group,combatMode,"YELLOW");
        //            private _originalSpeed = GETVAR(_group,speed,"normal");
        //            private _originalForm = GETVAR(_group,formation,"wedge");
        //            [_group,_originalBeh,_originalCM,_originalSpeed,_originalForm] call FUNC(setGroupBehaviour);
        //            private _originalTask = GETVAR(_group,OriginalTask,"PATROL");
        //            private _originalPos = GETVAR(_group,Pos,getPos leader _group);
        //            private _originalRadius = GETVAR(_group,taskRadius,30);
        //            [_group,_originalTask,_originalPos,_originalRadius] call FUNC(taskAssign);
        //        } else {
        //            _targetCounter = _targetCounter + 1;
        //            SETVAR(_group,NullTargetCounter,_targetCounter);
        //        };
        //    } else {
        //        SETVAR(_group,CurrentTarget,_target);
        //    };
        //} else {
        //    SETVAR(_group,NullTargetCounter,0);
        //};
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
        if (CBA_missionTime >= _lastTimeChecked + 3) then {
            private _inCombat = (_behaviour in ["COMBAT","STEALTH"]) && {!(GETVAR(_group,taskCombatModeSet,false))};
            //TRACE_2("inCombat check",_group,_inCombat);
            if (_inCombat || {(_target isNotEqualTo objnull)}) then {
                //switch tasks on actions
                //handle for special loiter task - regroup
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
                    if (!(GETMVAR(RadioNeedRadio,false)) || {(_group call FUNC(hasRadioGroup)) select 0}) then {
                        private _radioWait = GETMVAR(RadioWait,30);
                        private _lastCallTime = GETVAR(_group,LastCallTime,(CBA_MissionTime - _radioWait));
                        if (CBA_MissionTime >= (_LastCallTime + _radioWait) && {!(GETVAR(_group,Reinforcing,false))}) then {
                            TRACE_1("radio call for support",_group);
                            SETVAR(_group,LastCallTime,CBA_MissionTime);
                            //if (GVAR(CommanderEnabled)) then {
                            //    [_group,_target,_side] call FUNC(RadioReportThreat);
                            //} else {
                                [_group,_target,_side] call FUNC(RadioCallForSupport);
                            //};
                        };
                    };
                };
            } else {
                if (_task isEqualTo "MANUAL") then {
                    private _lastWaypointTime = GETVAR(_group,lastWaypointTime,CBA_MissionTime - 3);
                    private _currentWaypoint = currentWaypoint _group;
                    private _waypoints = waypoints _group;
                    if (_currentWaypoint > (count _waypoints - 1) && {(_group getVariable [QGVAR(Task), "PATROL"]) isEqualTo "MANUAL"}) then {
                        [_group, _position] call FUNC(taskPatrol);
                    };
                };
            };
            //commander handling
            if (
                (GETMVAR(CommanderEnabled,false)) &&
                {!(GETVAR(_group,CommanderExempt,false))} &&
                {side _group isEqualTo (GETMVAR(CommanderSide,east))}
            ) then {
                if (_areaAssigned isEqualTo "NONE") then {
                    //check zones for assignments
                    private _assigned = false;
                    {
                        private _namespace = missionNamespace getVariable _x;
                        private _displayName = GETVAR(_namespace,displayName,"");
                        //private _mission = GETVAR(_namespace,mission,"Patrol");
                        //private _marker = GETVAR(_namespace,marker,"");
                        //private _min = GETVAR(_namespace,min,0);
                        private _max = GETVAR(_namespace,max,10);
                        //private _threshold = GETVAR(_namespace,threshold,1);
                        //private _QRFSupport = GETVAR(_namespace,QRFSupport,true);
                        //private _assetSupport = GETVAR(_namespace,assetSupport,true);
                        //private _withdrawalEnabled = GETVAR(_namespace,withdrawalEnabled,true);
                        //private _resourceUse = GETVAR(_namespace,resourceUse,true);
                        private _preferredTypes = GETVAR(_namespace,preferredTypes,"ALL");
                        //private _terrainMode = GETVAR(_namespace,terrainMode,"Auto");
                        //private _importance = GETVAR(_namespace,importance,_forEachIndex);
                        private _assignedAssets = GETVAR(_namespace,assignedAssets,[]);
                        private _controlStatus = GETVAR(_namespace,control,"Neutral");
                        private _assetCount = count _assignedAssets;
                        //LOG_3("Area: %1 _assetCount: %2 _max: %3",_displayName,_assetCount,_max);
                        if (
                            (_assetCount < _max) &&
                            {!_assigned} &&
                            {!(_controlStatus in ["EnemyControlled", "Contested"])} &&
                            {(_assetType in _preferredTypes) || (_preferredTypes isEqualTo ["ALL"])}
                        ) then {
                            LOG_2("Sending group %1 to area %2",_group,_displayName);
                            _assigned = true;
                            [_group,_namespace] call FUNC(assignToArea);
                        };
                    } foreach GVAR(CommanderAreasParsed);
                    if !(_assigned) then {
                        ERROR_1("Could not find area suitable for: %1 type %2 ignoring preferred types",_group,_assetType);
                        {
                            private _namespace = missionNamespace getVariable _x;
                            private _displayName = GETVAR(_namespace,displayName,"");
                            //private _mission = GETVAR(_namespace,mission,"Patrol");
                            //private _marker = GETVAR(_namespace,marker,"");
                            //private _min = GETVAR(_namespace,min,0);
                            private _max = GETVAR(_namespace,max,10);
                            //private _threshold = GETVAR(_namespace,threshold,1);
                            //private _QRFSupport = GETVAR(_namespace,QRFSupport,true);
                            //private _assetSupport = GETVAR(_namespace,assetSupport,true);
                            //private _withdrawalEnabled = GETVAR(_namespace,withdrawalEnabled,true);
                            //private _resourceUse = GETVAR(_namespace,resourceUse,true);
                            //private _preferredTypes = GETVAR(_namespace,preferredTypes,"ALL");
                            //private _terrainMode = GETVAR(_namespace,terrainMode,"Auto");
                            //private _importance = GETVAR(_namespace,importance,_forEachIndex);
                            private _assignedAssets = GETVAR(_namespace,assignedAssets,[]);
                            private _controlStatus = GETVAR(_namespace,control,"Neutral");
                            private _assetCount = count _assignedAssets;
                            //LOG_3("Area: %1 _assetCount: %2 _max: %3",_marker,_assetCount,_max);
                            if (
                                (_assetCount < _max) &&
                                {!_assigned} &&
                                {!(_controlStatus in ["EnemyControlled", "Contested"])}
                            ) then {
                                LOG_2("Sending group %1 to area %2",_group,_displayName);
                                _assigned = true;
                                [_group,_namespace] call FUNC(assignToArea);
                            };
                        } foreach GVAR(CommanderAreasParsed);
                        if !(_assigned) then {
                            ERROR_1("Could not find area suitable for: %1 sending to default zone",_group);
                            [_group,(missionNamespace getVariable (GVAR(CommanderAreasParsed) select 0))] call FUNC(assignToArea);
                        };
                    };
                };
            };
            SETVAR(_group,lastTimeChecked,CBA_missionTime);
        };
    };
}, 1] call CBA_fnc_addPerFrameHandler;
