#include "script_component.hpp"

GVAR(GroupMarkersPFH) = [{
    {
        private _key = _x;
        _y params [
            /*1*/ "_group",
            /*2*/ "_side",
            /*3*/ "_leader",
            /*4*/ "_groupcount",
            /*5*/ "_task",
            /*6*/ "_behaviour",
            /*7*/ "_target",
            /*8*/ "_position",
            /*9*/ "_areaAssigned",
           /*10*/ "_assetType",
           /*11*/ ["_usedMarkers", [], [[]]]
        ];
        if (
            _group isEqualTo grpNull ||
            {
                (units _group) findIf {_x call EFUNC(FW,isAlive)} isEqualTo -1
            }
        ) then {
            GVAR(markerTrackedGroups) deleteAt _key;
            if (_usedMarkers isNotEqualTo []) then {
                _usedMarkers select {_x isNotEqualTo ""} apply {
                    deletemarker _x;
                };
            };
        } else {
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
            };
            if (_usetarget) then {
                if (_target isEqualTo objNull) then {
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
                /*2*/ _side,
                /*3*/ _leader,
                /*4*/ _groupcount,
                /*5*/ _task,
                /*6*/ _behaviour,
                /*7*/ _target,
                /*8*/ _position,
                /*9*/ _areaAssigned,
               /*10*/ _assetType,
               /*11*/ _usedMarkers
            ]]
        }
    } forEach GVAR(markerTrackedGroups);
}, 1] call CBA_fnc_addPerFrameHandler;
