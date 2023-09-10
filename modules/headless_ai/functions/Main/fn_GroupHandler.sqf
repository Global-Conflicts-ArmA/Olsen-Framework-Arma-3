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
                private _taskInfo = GVAR(Tasks) getOrDefault [_task, []];
                _taskInfo params [
                    ["_function", "", [""]],
                    ["_isMove", false, [false]],
                    ["_needsPos", false, [false]],
                    ["_combatResponse", "", [""]],
                    ["_reinforce", false, [false]]
                ];
                [_group, _target] call (missionNamespace getVariable [_combatResponse, {}]);
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
            private _key = str _group;
            private _usedMarkers = [];
            if !(_key in GVAR(markerTrackedGroups)) then {
                GVAR(markerTrackedGroups) set [_key, [
                    _group,
                    []
                ]];
            } else {
                _usedMarkers = (GVAR(markerTrackedGroups) get _key) select 1;
            };
            _usedMarkers params [
                ["_tracker", "", [""]],
                ["_dest", "", [""]],
                ["_destLine", "", [""]],
                ["_targetMarker", "", [""]]
            ];
            private _markercolour = switch (_side) do {
                case west: {"ColorBlue"};
                case east: {"ColorRed"};
                case independent: {"ColorGreen"};
                case civilian: {"ColorYellow"};
                default {"ColorBlack"};
            };
            if (_tracker isEqualTo "") then {
                _tracker = format ["trk_%1_%2",_side,_group];
                createMarker [_tracker,[0,0]];
                private _drawicon = switch (_assetType) do {
                    case "Infantry": {"b_inf"};
                    case "Motorized": {"b_motor_inf"};
                    default {"b_inf"};
                };
                _tracker setMarkerShapeLocal "ICON";
                _tracker setMarkerSizeLocal [0.5, 0.5];
                _tracker setMarkerTypeLocal _drawicon;
                _tracker setMarkerColor _markercolour;
            };
            _tracker setMarkerPos [getpos _leader select 0, getpos _leader select 1];
            private _usetarget = _target isNotEqualTo objnull;
            if !(_usetarget) then {
                _target = "NONE";
            };
            private _text = if ((GETMVAR(CommanderEnabled,false)) && {(GETMVAR(CommanderSide,east)) isEqualTo _side}) then {
                format ["%1 - Grpcount: %2 - Task: %3 - Area: %4 - Type: %5 - CombatMode: %6 - Target: %7",
                    _group,
                    _groupcount,
                    _task,
                    _areaAssigned,
                    _assetType,
                    _behaviour,
                    _target
                ];
            } else {
                format ["%1 - Grpcount: %2 - Task: %3 - CombatMode: %4 - Target: %5",
                    _group,
                    _groupcount,
                    _task,
                    _behaviour,
                    _target
                ];
            };
            //LOG_1("MarkerText: %1",_text);
            _tracker setMarkerText _text;
            // find appropriate dest waypoint, if any
            if (_task in [
                "PATROL",
                "PERIMPATROL",
                "SENTRY",
                "ATTACK",
                "ASSAULT",
                "FLANK",
                "MOVE",
                "MANUAL",
                "BLDMOVE",
                "BLDSEARCH",
                "PICKUP",
                "DROPOFF"
            ]) then {
                private _groupWPs = waypoints _group;
                if (_groupWPs isEqualTo []) then {
                    if (_dest isNotEqualTo "") then {
                        deletemarker _dest;
                        deletemarker _destline;
                        _dest = "";
                        _destline = "";
                    };
                } else {
                    private _currentWP = currentWaypoint _group;
                    private _wpPos = waypointPosition [_group, _currentWP];
                    if (
                        _currentWP >= count _groupWPs &&
                        {_wpPos isEqualTo [0,0,0]}
                    ) then {
                        if (_dest isNotEqualTo "") then {
                            deletemarker _dest;
                            deletemarker _destline;
                            _dest = "";
                            _destline = "";
                        };
                    } else {
                        if (_dest isEqualTo "") then {
                            _dest = format["dest_%1_%2", _side, _group];
                            createMarker [_dest, [0, 0]];
                            _dest setMarkerShapeLocal "ICON";
                            _dest setMarkerTypeLocal "mil_marker";
                            _dest setMarkerSizeLocal [0.25, 0.25];
                            _dest setMarkerColorLocal _markercolour;
                            _destline = format ["destline_%1_%2", _side, _group];
                            createMarker [_destline, [0, 0]];
                            _destline setMarkerShapeLocal "RECTANGLE";
                            _destline setMarkerBrushLocal "SOLID";
                            _destline setMarkerColorLocal _markercolour;
                        };
                        _dest setMarkerPos _wpPos;
                        private _dist = (_position distance2D _wppos) / 2;
                        private _ang = _position getDir _wppos;
                        private _center = _position getPos [_dist, _ang];
                        _destline setMarkerSizeLocal [1, _dist];
                        _destline setMarkerDirLocal _ang;
                        _destline setMarkerPos _center;
                    };
                };
            } else {
                if (_dest isNotEqualTo "") then {
                    deletemarker _dest;
                    deletemarker _destline;
                    _dest = "";
                    _destline = "";
                };
            };
            if (_usetarget) then {
                if (_target isEqualTo objNull || _target isEqualTo "NONE") then {
                    if (_targetMarker isNotEqualTo "") then {
                        deletemarker _targetMarker;
                        _targetMarker = "";
                    };
                } else {
                    if (_targetMarker isEqualTo "") then {
                        _targetMarker = format["target_%1_%2",_side,_group];
                        createMarker [_targetMarker,[0,0]];
                        private _targettext = format ["%1",_group];
                        _targetMarker setMarkerShapeLocal "ICON";
                        _targetMarker setMarkerTypeLocal "mil_objective";
                        _targetMarker setMarkerSizeLocal [0.5,0.5];
                        _targetMarker setmarkercolorLocal _markercolour;
                        _targetMarker setMarkerTextLocal _targettext;
                    };
                    _targetMarker setMarkerPos [(getpos _target select 0),(getpos _target select 1)];
                };
            } else {
                if (_targetMarker isNotEqualTo "") then {
                    deletemarker _targetMarker;
                    _targetMarker = "";
                };
            };
            _usedMarkers = [
                _tracker,
                _dest,
                _destLine,
                _targetMarker
            ];
            GVAR(markerTrackedGroups) set [_key, [
                /*1*/ _group,
                /*2*/ _usedMarkers
            ]];
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
    {
        private _groupStr = _x;
        private _groupArray = _y;
        _groupArray params ["_group", "_usedMarkers"];
        if (_group isEqualTo grpNull || leader _group isEqualTo objNull) then {
            GVAR(markerTrackedGroups) deleteAt _groupStr;
            if (_usedMarkers isNotEqualTo []) then {
                _usedMarkers select {_x isNotEqualTo ""} apply {
                    deletemarker _x;
                };
            };
        };
    } forEach GVAR(markerTrackedGroups);
}, 1] call CBA_fnc_addPerFrameHandler;
