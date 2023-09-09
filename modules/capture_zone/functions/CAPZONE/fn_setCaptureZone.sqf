#include "script_component.hpp"

params [
	["_marker", "marker_capture", [""]],
	["_zoneName", "Capture Zone 1", [""]],
	["_zoneVar", "captureZone1", [""]],
	["_sides", [[blufor, 300, 1]], [[]]],
    ["_mode", "HOLD", [""]],
    ["_playerOnly", false, [false]],
    ["_interval", 5, [0]],
    ["_colourChangePercent", 50, [50]],
    ["_messages", ["Blufor is capturing the zone", "Opfor is capturing the zone", "Resistance is capturing the zone", "Civilian is capturing the zone", "The zone is contested", "The zone is uncontested"], [[]]],
    ["_colours", ["ColorBlue", "ColorRed", "ColorGreen", "ColorYellow", "ColorWhite", "ColorKhaki"], [[]]]
];

_mode = toUpper _mode;

_sides apply {
    _x params [
        ["_side", blufor, [sideEmpty]],
        ["_timeNeeded", 300, [0]],
        ["_ratio", 1, [0]]
    ];
    TRACE_3("",_side,_timeNeeded,_ratio);
};

if (_zoneName isEqualTo "") then {
    _zoneName = _marker;
};

if ({_x isEqualType ""} count _messages < 6) then {
    _messages = ["Blufor is capturing the zone", "Opfor is capturing the zone", "Resistance is capturing the zone", "Civilian is capturing the zone", "The zone is contested", "The zone is uncontested"];
};

if ({_x isEqualType ""} count _colours < 6) then {
    _colours = ["ColorBlue", "ColorRed", "ColorGreen", "ColorYellow", "ColorWhite", "ColorKhaki"];
};

if (_interval < 5) then {
    _interval = 5;
};

[{
    params ["_args", "_pfhID"];
    _args params [
    /*0*/ ["_marker", "marker_capture", [""]],
    /*1*/ ["_zoneName", "Capture Zone 1", [""]],
    /*2*/ ["_zoneVar", "captureZone1", [""]],
    /*3*/ ["_sides", [], [[]]],
    /*4*/ ["_mode", "HOLD", [""]],
    /*5*/ ["_playerOnly", false, [false]],
    /*6*/ ["_colourChangePercent", 50, [50]],
    /*7*/ ["_messages", [], [[]]],
    /*8*/ ["_colours", [], [[]]],
    /*9*/ ["_timer", CBA_missionTime, [0]],
    /*10*/ ["_oldOwner", sideEmpty, [sideEmpty]],
   /*11*/ ["_firstRun", true, [true]]
    ];

    TRACE_3("",_marker,_timer,_oldOwner);

    _messages params [
        "_bluforMessage",
        "_opforMessage",
        "_indforMessage",
        "_civMessage",
        "_conMessage",
        "_unconMessage"
    ];

    _colours params [
        "_bluforColour",
        "_opforColour",
        "_indforColour",
        "_civColour",
        "_conColour",
        "_unconColour"
    ];

    private _timeDelta = CBA_missionTime - _timer;

    //gather units
    private _eligibleUnits = ([allUnits, allPlayers] select _playerOnly) select {
        _x inArea _marker &&
        {_x call EFUNC(FW,isAlive)}
    };

    //find highest count for teams (with applied ratios) for each eligble side
    private _highestCount = 0;
    // For HOLD mode, teams must continue to hold objective or else it will default back to uncontested
    private _controlSide = [_oldOwner, sideEmpty] select (_mode isEqualTo "HOLD");
    _sides apply {
        _x params [
            ["_side", blufor, [sideEmpty]],
            ["_timeNeeded", 300, [0]],
            ["_ratio", 1, [1]]
        ];
        private _count = {side _x isEqualTo _side} count _eligibleUnits;
        if (_ratio < 1) then {
            _ratio = 1;
        };
        private _countWithRatio = _count / _ratio;
        TRACE_2("",_side,_ratio);
        TRACE_2("",_count,_countWithRatio);
        if (_countWithRatio > _highestCount) then {
            _highestCount = _countWithRatio;
            _controlSide = _side;
        } else {
            if (_countWithRatio > 0 && {_countWithRatio isEqualTo _highestCount}) then {
                _controlSide = sideUnknown;
            };
        };
        TRACE_2("",_highestCount,_controlSide);
    };

    if (_firstRun) exitWith {
        private _colour = switch _controlSide do {
            case blufor: {_bluforColour};
            case opfor: {_opforColour};
            case independent: {_indforColour};
            case civilian: {_civColour};
            default {_unconColour};
        };
        _marker setMarkerColorLocal _colour;
        _marker setMarkerBrush "SolidBorder";
        _firstRun = false;
        _args set [11, _firstRun];
        _oldOwner = _controlSide;
        _args set [10, _oldOwner];
        missionNamespace setVariable [_zoneVar, _controlSide, true];
    };

    if (_oldOwner isEqualTo _controlSide && {_controlSide isNotEqualTo sideUnknown}) then {
        //skip iteration if var is already set
        if ((missionNamespace getVariable [_zoneVar, sideEmpty]) isEqualTo _controlSide) exitWith {};
        //determine time anwdd whether to capture
        private _timeNeeded = if (_controlSide isEqualTo sideEmpty) then {
            30
        } else {
            _sides select {_x select 0 isEqualTo _controlSide} select 0 select 1
        };
        TRACE_3("",_controlSide,_timeNeeded,_timeDelta);
        if (_timeDelta > _timeNeeded) then {
            private _colour = _bluforColour;
            private _conTeamName = "no one";
            switch _controlSide do {
                case blufor: {
                    _colour = _bluforColour;
                    _conTeamName = missionNamespace getVariable [QEGVAR(FW,TeamName_Blufor), "Blufor"];
                };
                case opfor: {
                    _colour = _opforColour;
                    _conTeamName = missionNamespace getVariable [QEGVAR(FW,TeamName_Opfor), "Opfor"];
                };
                case independent: {
                    _colour = _indforColour;
                    _conTeamName = missionNamespace getVariable [QEGVAR(FW,TeamName_Indfor), "Indfor"];
                };
                case civilian: {
                    _colour = _civColour;
                    _conTeamName = missionNamespace getVariable [QEGVAR(FW,TeamName_Civ), "Civilian"];
                };
                default {
                    _colour = _unconColour;
                    _conTeamName = "no one";
                };
            };
            _marker setMarkerColorLocal _colour;
            _marker setMarkerAlpha 1;
            _marker setMarkerBrush "SolidBorder";
            [_zoneName + " is now under the control of " + _conTeamName] remoteExec ["hintSilent"];
            missionNamespace setVariable [_zoneVar, _controlSide, true];
            if (_mode isEqualTo "ONCE") exitWith {
                TRACE_2("Capzone is set to ONCE mode, exiting loop",_marker,_controlSide);
            };
        } else {
            //visually show objective "capturing" for a side - change colour & alpha if team is over 50% the capture time
            private _levelOfControl = _timeDelta / _timeNeeded;
            if (_colourChangePercent isEqualTo -1 || _levelOfControl >= (_colourChangePercent / 100)) then {
                private _colour = switch _controlSide do {
                    case blufor: {_bluforColour};
                    case opfor: {_opforColour};
                    case independent: {_indforColour};
                    case civilian: {_civColour};
                    default {_conColour};
                };
                _marker setMarkerColorLocal _colour;
                _marker setMarkerAlphaLocal _levelOfControl;
                _marker setMarkerBrush "Solid";
                TRACE_3("Changing Alpha for capzone",_marker,_levelOfControl,_colour);
            };
        };
    } else {
        //start contested state and set timer start
        _marker setMarkerColorLocal _conColour;
        _marker setMarkerAlphaLocal 0.8;
        _marker setMarkerBrush "Solid";
        _timer = CBA_missionTime;
        _args set [9, _timer];
        TRACE_2("Started Contesting",_controlSide,_timer);
        // For HOLD mode, teams must continue to hold objective or else it will default back to uncontested
        if (_controlSide isEqualTo sideEmpty) then {
            [_zoneName + " is no longer being held by a team and will default back to being uncontrolled"] remoteExec ["hintSilent"];
        } else {
            // There is a tie, so it is contested with no control
            if (_controlSide isEqualTo sideUnknown) then {
                [_zoneName + " is being contested"] remoteExec ["hintSilent"];
            } else {
                private _conTeamName = switch _controlSide do {
                    case blufor: {missionNamespace getVariable [QEGVAR(FW,TeamName_Blufor), "Blufor"]};
                    case opfor: {missionNamespace getVariable [QEGVAR(FW,TeamName_Opfor), "Opfor"]};
                    case independent: {missionNamespace getVariable [QEGVAR(FW,TeamName_Indfor), "Indfor"]};
                    case civilian: {missionNamespace getVariable [QEGVAR(FW,TeamName_Civ), "Civilian"]};
                    default {"no one"};
                };
                private _oldOwnerName = switch _oldOwner do {
                    case blufor: {missionNamespace getVariable [QEGVAR(FW,TeamName_Blufor), "Blufor"]};
                    case opfor: {missionNamespace getVariable [QEGVAR(FW,TeamName_Opfor), "Opfor"]};
                    case independent: {missionNamespace getVariable [QEGVAR(FW,TeamName_Indfor), "Indfor"]};
                    case civilian: {missionNamespace getVariable [QEGVAR(FW,TeamName_Civ), "Civilian"]};
                    default {"no one"};
                };
                [_zoneName + " was being held by " + _oldOwnerName + " and is being captured by " + _conTeamName] remoteExec ["hintSilent"];
            };
        };
        _oldOwner = _controlSide;
        _args set [10, _oldOwner];
        missionNamespace setVariable [_zoneVar, sideEmpty, true];
    };
}, _interval,
    [
        _marker,
        _zoneName,
        _zoneVar,
        _sides,
        _mode,
        _playerOnly,
        _colourChangePercent,
        _messages,
        _colours
    ]
] call CBA_fnc_addPerFrameHandler;
