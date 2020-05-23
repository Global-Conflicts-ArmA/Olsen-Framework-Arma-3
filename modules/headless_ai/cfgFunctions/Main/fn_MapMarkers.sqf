#include "..\..\script_macros.hpp"

params [
    "_group",
    "_side",
    "_group",
    "_leader",
    "_groupcount",
    "_mission",
    "_behaviour",
    "_target",
    "_position",
    "_areaAssigned",
    "_assetType"
];

if (!(alive _leader) || !(local _leader)) then {
    private _trackername = format ["trk_%1_%2",_side,_group];
    if (_trackername in GVAR(MarkerArray)) then {
        deletemarker _trackername;
        GVAR(MarkerArray) = GVAR(MarkerArray) - [_trackername];
    };
    private _destname = format ["dest_%1_%2",_side,_group];
    if (_destname in GVAR(MarkerArray)) then {
        deletemarker _destname;
        GVAR(MarkerArray) = GVAR(MarkerArray) - [_destname];
    };
    private _destlinename = format ["destline_%1_%2",_side,_group];
    if (_destlinename in GVAR(MarkerArray)) then {
        deletemarker _destlinename;
        GVAR(MarkerArray) = GVAR(MarkerArray) - [_destlinename];
    };
    private _targetname = format ["target_%1_%2",_side,_group];
    if (_targetname in GVAR(MarkerArray)) then {
        deletemarker _targetname;
        GVAR(MarkerArray) = GVAR(MarkerArray) - [_targetname];
    };
} else {
    private _rankshort = [rank _leader,"displayNameShort"] call BIS_fnc_rankparams;
    private _lastName = name _leader;
    private _trackername = format ["trk_%1_%2",_side,_group];
    private _markercolour = (switch (_side) do {
        case west: {"ColorBlue"};
        case east: {"ColorRed"};
        case independent: {"ColorGreen"};
        case civilian: {"ColorYellow"};
        default {"ColorBlack"};
    });
    if !(_trackername in GVAR(MarkerArray)) then {
        createMarker [_trackername,[0,0]];
        GVAR(MarkerArray) pushback _trackername;
        private _drawicon = switch (_assetType) do {
            case "Infantry": {"b_inf"};
            case "Motorized": {"b_motor_inf"};
            default {"b_inf"};
        };
        _trackername setMarkerShape "ICON";
        _trackername setMarkerSize [0.5, 0.5];
        _trackername setMarkerType _drawicon;
        _trackername setmarkercolor _markercolour;
    };
    _trackername setmarkerpos [getpos _leader select 0, getpos _leader select 1];
    private _usedest = if (_mission in [
        "PATROL",
        "PERIMPATROL",
        "SENTRY",
        "ATTACK",
        "BUNKER",
        "ASSAULT",
        "FLANK",
        "MOVE",
        "MANUAL",
        "BLDMOVE",
        "BLDSEARCH"
    ]) then {true} else {false};
    private _usetarget = false;
    if (_target isEqualTo objnull) then {
        _target = "NONE";
    } else {
        _usetarget = true;
    };
    private _text = format ["%1. %2 - Grpcount: %3 - Mission: %4 - Area: %7 - Type: %8 - CombatMode: %5 - Target: %6",_rankshort, _lastname, _groupcount, _mission, _behaviour, _target, _areaAssigned, _assetType];
    //LOG_1("MarkerText: %1",_text);
    _trackername setMarkerText _text;
    if (_usedest) then {
        private _destname = format["dest_%1_%2",_side,_group];
        if (!(_destname in GVAR(MarkerArray))) then {
            createMarker [_destname,[0,0]];
            GVAR(MarkerArray) pushback _destname;
            _destname setMarkerShape "ICON";
            _destname setMarkerType "mil_marker";
            _destname setMarkerSize [0.25,0.25];
            _destname setmarkercolor _markercolour;
        };
        private _wpArray = waypoints _group;
        private _wppos = [0,0,0];
        if !(_wpArray isEqualto []) then {
            private _wpindex = currentWaypoint _group;
            _wppos = waypointPosition [_group,_wpindex];
            _destname setmarkerpos _wppos;
        } else {
            _destname setmarkerpos [0,0];
        };
        private _dist = (_position distance2D _wppos) / 2;
        private _ang = _position getDir _wppos;
        private _center = _position getPos [_dist, _ang];
        private _destlinename = format ["destline_%1_%2",_side,_group];
        if (!(_destlinename in GVAR(MarkerArray))) then {
            createMarker [_destlinename,[0,0]];
            GVAR(MarkerArray) pushback _destlinename;
            _destlinename setMarkerShape "RECTANGLE";
            _destlinename setMarkerBrush "SOLID";
            _destlinename setmarkercolor _markercolour;
        };
        _destlinename setMarkerSize [1,_dist];
        _destlinename setMarkerDir _ang;
        _destlinename setMarkerPos _center;
    } else {
        private _destname = format["dest_%1_%2",_side,_group];
        if (_destname in GVAR(MarkerArray)) then {
            deletemarker _destname;
            GVAR(MarkerArray) = GVAR(MarkerArray) - [_destname];
        };
        private _destlinename = format ["destline_%1_%2",_side,_group];
        if (_destlinename in GVAR(MarkerArray)) then {
            deletemarker _destlinename;
            GVAR(MarkerArray) = GVAR(MarkerArray) - [_destlinename];
        };
    };
    if (_usetarget) then {
        private _targetname = format["target_%1_%2",_side,_group];
        if (!(_targetname in GVAR(MarkerArray))) then {
            createMarker [_targetname,[0,0]];
            GVAR(MarkerArray) pushback _targetname;
            private _targettext = format ["%1. %2",_rankshort,_lastname];
            _targetname setMarkerShape "ICON";
            _targetname setMarkerType "mil_objective";
            _targetname setMarkerSize [0.5,0.5];
            _targetname setmarkercolor _markercolour;
            _targetname setMarkerText _targettext;
        };
        _targetname setMarkerPos [(getpos _target select 0),(getpos _target select 1)];
    } else {
        private _targetname = format["target_%1_%2",_side,_group];
        if (_targetname in GVAR(MarkerArray)) then {
            deletemarker _targetname;
            GVAR(MarkerArray) = GVAR(MarkerArray) - [_targetname];
        };
    };
};
