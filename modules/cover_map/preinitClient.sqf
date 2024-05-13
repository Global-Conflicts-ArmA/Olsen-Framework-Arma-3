#include "script_component.hpp"

if (!hasinterface) exitwith {};

private _version = 1.0;

["Cover Map", "Covers map except specified area, allows switching between multiple AOs", "PIZZADOX", _version] call FUNC(RegisterModule);

if (isNil QGVAR(AONamespace)) then {
    GVAR(AONamespace) = createHashMap;
};
private _lastMarkerAdded = "";

//populate AOs from config
"true" configClasses (missionConfigFile >> QGVAR(Settings) >> "AOs") apply {
    private _isCentered = ([_x, "isCentered", 1] call BIS_fnc_returnConfigEntry) isEqualTo 1;
    private _zoomLevel = [_x, "zoomLevel", 0.4] call BIS_fnc_returnConfigEntry;
    private _name = [_x, "name", ""] call BIS_fnc_returnConfigEntry;
    if (_name isEqualTo "") then {
        _name = configName _x;
    };
    private _bgColour = [_x, "backgroundColour", "ColorBlack"] call BIS_fnc_returnConfigEntry;
    private _condition = [_x, "condition", ""] call BIS_fnc_returnConfigEntry;
    if (_condition isEqualTo "") then {
        _condition = true
    } else {
        _condition = compile _condition;
    };
    private _AOArray = [_isCentered, _zoomLevel, _name, _bgColour, _condition];
    TRACE_2("adding area to AO array",configName _x,_AOArray);
    GVAR(AONamespace) set [configName _x, _AOArray];
    _lastMarkerAdded = configName _x;
};

//initial marker array define
GVAR(map_cover) = [];
GVAR(map_currentAO) = "";

[{(getMarkerColor _this) isNotEqualTo ""},{

    switch (side player) do {
        case west: {
            GVAR(AOList) = [missionConfigFile >> QGVAR(settings) >> "west" >> "areas", "array", []] call CBA_fnc_getConfigEntry;
            GVAR(DefaultAO) = [missionConfigFile >> QGVAR(settings) >> "west" >> "defaultArea", "string", ""] call CBA_fnc_getConfigEntry;
        };
        case east: {
            GVAR(AOList) = [missionConfigFile >> QGVAR(settings) >> "east" >> "areas", "array", []] call CBA_fnc_getConfigEntry;
            GVAR(DefaultAO) = [missionConfigFile >> QGVAR(settings) >> "east" >> "defaultArea", "string", ""] call CBA_fnc_getConfigEntry;
        };
        case independent: {
            GVAR(AOList) = [missionConfigFile >> QGVAR(settings) >> "independent" >> "areas", "array", []] call CBA_fnc_getConfigEntry;
            GVAR(DefaultAO) = [missionConfigFile >> QGVAR(settings) >> "independent" >> "defaultArea", "string", ""] call CBA_fnc_getConfigEntry;
        };
        default {
            GVAR(AOList) = [missionConfigFile >> QGVAR(settings) >> "civilian" >> "areas", "array", []] call CBA_fnc_getConfigEntry;
            GVAR(DefaultAO) = [missionConfigFile >> QGVAR(settings) >> "civilian" >> "defaultArea", "string", ""] call CBA_fnc_getConfigEntry;
        };
    };

    //print errors
    if (GVAR(AOList) isEqualTo []) then {
        ERROR_1("No covermap AOs entered for side", side player);
    };

    if (GVAR(DefaultAO) isEqualTo "") then {
        ERROR_1("No default covermap AOs entered for side, defaulting to first AO", side player);
    };
    // set markers invisible
    {
        _x setMarkerAlphaLocal 0;
    } forEach GVAR(AONamespace);
    // add main self interact action
    private _MapChangeMenu = ["MapChangeMenu", "Switch Map", "", {}, {true}] call ace_interact_menu_fnc_createAction;
    [player, 1, ["ACE_SelfActions", "ACE_Equipment"], _MapChangeMenu] call ace_interact_menu_fnc_addActionToObject;

    // add individual actions
    {
        private _AOArray = GVAR(AONamespace) getOrDefault [_x, []];
        _AOArray params [
            ["_isCentered", true, [true]],
            ["_zoomLevel", 0.4, [0]],
            ["_name", "", [""]],
            ["_bgColour", "ColorBlack", [""]],
            ["_condition", false, [false, {}]]
        ];
        private _text = "Switch Map to " + _name;
        private _MapChangeAction = ["switch_MapAO", _text, "", {
            _this select 2 call FUNC(live);
        },{
            _this select 2 params [
                "_marker",
                ["_isCentered", true, [true]],
                ["_zoomLevel", 0.4, [0]],
                ["_name", "", [""]],
                ["_bgColour", "ColorBlack", [""]],
                ["_condition", true, [true, {}]]
            ];
            visibleMap &&
            {
                GVAR(map_currentAO) isNotEqualTo _marker
            } &&
            _condition
        }, {}, [_x, _isCentered, _zoomLevel, _name, _bgColour, _condition]] call ace_interact_menu_fnc_createAction;
        [player, 1, ["ACE_SelfActions", "ACE_Equipment", "MapChangeMenu"], _MapChangeAction] call ace_interact_menu_fnc_addActionToObject;
    } forEach GVAR(AOList);

    private _AOArray = GVAR(AONamespace) getOrDefault [GVAR(DefaultAO), []];
    _AOArray params [
        ["_isCentered", true, [true]],
        ["_zoomLevel", 0.4, [0]],
        ["_name", "", [""]],
        ["_bgColour", "ColorBlack", [""]],
        ["_condition", true, [true, {}]]
    ];
    [
        GVAR(DefaultAO),
        _isCentered,
        _zoomLevel,
        _name,
        _bgColour,
        _condition
    ] call FUNC(bordersToMap);
    if (_isCentered) then {
        ((uiNamespace getVariable "RscDiary") displayCtrl 51) ctrlMapAnimAdd [0, _zoomlevel, getMarkerPos GVAR(DefaultAO)];
        ctrlMapAnimCommit ((uiNamespace getVariable "RscDiary") displayCtrl 51);
    };

    [{visibleMap},{
        _this params [
            ["_isCentered", true, [true]],
            ["_zoomLevel", 0.4, [0]],
            ["_name", "", [""]],
            ["_bgColour", "ColorBlack", [""]],
            ["_condition", true, [true, {}]]
        ];
        if (_isCentered) then {
            MapAnimAdd [0, _zoomlevel, getMarkerPos GVAR(DefaultAO)];
            MapAnimCommit;
        };
    }, _AOArray] call CBA_fnc_waitUntilAndExecute;
}, _lastMarkerAdded] call CBA_fnc_waitUntilAndExecute;
