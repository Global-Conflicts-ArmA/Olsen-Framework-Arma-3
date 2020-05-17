#include "..\..\script_macros.hpp"


LOG("Starting CommanderHandler Function");

GVAR(AreaMarkerArray) = [];


//private _markercolour = (switch (GVAR(CommanderSide)) do {
//    case "west": {"ColorBlue"};
//    case "east": {"ColorRed"};
//    case "independent": {"ColorGreen"};
//    case "civilian": {"ColorYellow"};
//    default {"ColorBlack"};
//});

{
    private _area = _x;
    _area params [
        "_marker",
        "_mission",
        ["_min",0,[0]],
        ["_max",10,[10]],
        ["_threshold",1,[1]],
        ["_QRFSupport",true,[true]],
        ["_assetSupport",true,[true]],
        ["_withdrawalEnabled",true,[true]],
        ["_resourceUse",true,[true]],
        ["_preferredTypes",["Infantry", "Snipers", "Motorized", "Mechanized", "Armor"],[[]]],
        ["_terrainMode","AUTO",[""]],
        ["_importance",_foreachIndex,[0]],
        ["_assignedAssets",[],[[]]],
        ["_control",0,[0]]
    ];
    TRACE_1("",_area);
    if ((getMarkerColor _marker) isEqualTo "") then {
        ERROR_1("%1 does not exist!",_marker);
    } else {
        if !((markerShape _marker) in ["RECTANGLE", "ELLIPSE"]) then {
            ERROR_1("%1 is not an area marker!",_marker);
        } else {
            LOG_1("passed check for area: %1",_marker);
            //hide marker
            _marker setMarkerAlpha 0;
        };
    };
    if (_min < 0) then {
        ERROR_2("%1 min value below minimum! _min: %2",_marker,_min);
        _min = 0;
    };
    if (_max < 1) then {
        ERROR_2("%1 max value below minimum! max: %2",_marker,_max);
        _max = 10;
    };
    if (_threshold > _max) then {
        ERROR_2("%1 threshold value above maximum! threshold: %2 max: %3",_marker,_threshold,_max);
        _threshold = 1;
    };
    if (_preferredTypes isEqualTo []) then {
        ERROR_2("%1 preferredTypes value empty! preferredTypes: %2",_marker,_preferredTypes);
        _preferredTypes = ["ALL"];
    };
    if !(_terrainMode in ["URBAN","COAST","FOREST HILL","FOREST","HILL","OPEN","AUTO"]) then {
        ERROR_2("%1 invalid terrainMode: %2",_marker,_terrainMode);
        _terrainMode = "AUTO";
    };
    if (_terrainMode isEqualTo "AUTO") then {
        private _markerPos = getMarkerPos _marker;
        private _markerSize = (getMarkerSize _marker) select 0;
        private _buildings =  _markerPos nearObjects ["House", _markerSize];
        private _neededBuildings = (2 + ((_markerSize / 100) * 2));
        TRACE_2("",_marker,_neededBuildings);
        private _buildingCount = {(count ([_x, 3] call CBA_fnc_buildingPositions)) > 2} count _buildings;
        if (_buildingCount >= _neededBuildings) then {
			_terrainMode = "URBAN";
        } else {
            private _coast = {_x select 1 > 0.8} count selectBestPlaces [_markerPos, _markerSize, "sea - waterDepth", 8, 5];
            if (_coast isEqualTo 5) then {
                 _terrainMode = "COAST";
            } else {
                private _treecount = {_x select 1 > 0.6} count selectBestPlaces [_markerPos, _markerSize, "forest", 8, 5];
				if (_treecount isEqualTo 5) then {
					private _hillcount = {_x select 1 > 0.2} count selectBestPlaces [_markerPos, _markerSize, "2* hills", 8, 5];
					if (_hillcount isEqualTo 5) then {
						_terrainMode = "FOREST HILL";
					} else {
						_terrainMode = "FOREST";
					};
                } else {
                    private _hillcount = {_x select 1 > 0.2} count selectBestPlaces [_markerPos, _markerSize, "2* hills", 8, 5];
                    if (_hillcount isEqualTo 5) then {
						_terrainMode = "HILL";
					} else {
                        _terrainMode = "OPEN";
                    };
                };
            };
        };
    };
    private _areaArrayPass = [_marker,_mission,_min,_max,_threshold,_QRFSupport,_assetSupport,_withdrawalEnabled,_resourceUse,_preferredTypes,_terrainMode,_importance,_assignedAssets,_control];
    GVAR(CommanderAreas) set [_foreachIndex,_areaArrayPass];
} foreach GVAR(CommanderAreas);

GVAR(CommanderAreasHandlerPFH) = [{
    {
        private _area = _x;
        _area params [
            "_marker",
            "_mission",
            ["_min",0,[0]],
            ["_max",10,[10]],
            ["_threshold",1,[1]],
            ["_QRFSupport",true,[true]],
            ["_assetSupport",true,[true]],
            ["_withdrawalEnabled",true,[true]],
            ["_resourceUse",true,[true]],
            ["_preferredTypes",["Infantry", "Snipers", "Motorized", "Mechanized", "Armor"],[[]]],
            ["_terrainMode","OPEN",[""]],
            ["_importance",0,[0]],
            ["_assignedAssets",[],[[]]],
            ["_control",0,[0]]
        ];

        private _controlStatus = "Neutral";
        //pass new info to var
        private _areaArrayPass = [_marker,_mission,_min,_max,_threshold,_QRFSupport,_assetSupport,_withdrawalEnabled,_resourceUse,_preferredTypes,_terrainMode,_importance,_assignedAssets,_control];
        GVAR(CommanderAreas) set [_foreachIndex,_areaArrayPass];
        if (GVAR(CommanderDebug)) then {
            private _markerColour = switch (_terrainMode) do {
                case "OPEN": {"BH_CheckLOS_khaki"};
                case "URBAN": {"ColorUnknown"};
                case "COAST": {"BH_CheckLOS_Gray"};
                case "FOREST HILL": {"ColorGreen"};
                case "FOREST": {"ColorGUER"};
                case "HILL": {"ColorWhite"};
                default {"colorDefault"};
            };
            private _debugMarkerName = format ["Area_%1",_marker];
            if !(_debugMarkerName in GVAR(AreaMarkerArray)) then {
                private _markerArea = createMarker [_debugMarkerName,[0,0]];
                GVAR(AreaMarkerArray) pushback _markerArea;
            };
            _debugMarkerName setMarkerShape (markerShape _marker);
            _debugMarkerName setMarkerSize (getMarkerSize _marker);
            _debugMarkerName setMarkerDir (markerDir _marker);
            _debugMarkerName setMarkerBrush "FDiagonal";
            _debugMarkerName setmarkercolor _markerColour;
            _debugMarkerName setmarkerpos (getmarkerpos _marker);
            _debugMarkerName setmarkeralpha 0.55;
            private _debugMarkerBorderName = format ["Area_%1_Border",_marker];
            if !(_debugMarkerBorderName in GVAR(AreaMarkerArray)) then {
                private _markerAreaBorder = createMarker [_debugMarkerBorderName,[0,0]];
                GVAR(AreaMarkerArray) pushback _markerAreaBorder;
            };
            _debugMarkerBorderName setMarkerShape (markerShape _marker);
            _debugMarkerBorderName setMarkerSize (getMarkerSize _marker);
            _debugMarkerBorderName setMarkerDir (markerDir _marker);
            _debugMarkerBorderName setMarkerBrush "Border";
            _debugMarkerBorderName setmarkercolor _markerColour;
            _debugMarkerBorderName setmarkerpos (getmarkerpos _marker);
            _debugMarkerBorderName setmarkeralpha 0.85;
            private _debugMarkerIconName = format ["Area_%1_Icon",_marker];
            if !(_debugMarkerIconName in GVAR(AreaMarkerArray)) then {
                private _markerAreaIcon = createMarker [_debugMarkerIconName,[0,0]];
                GVAR(AreaMarkerArray) pushback _markerAreaIcon;
            };
            _debugMarkerIconName setmarkercolor _markerColour;
            _debugMarkerIconName setMarkerShape "ICON";
            _debugMarkerIconName setMarkerType "hd_dot";
            _debugMarkerIconName setMarkerPos (getmarkerpos _marker);
            _debugMarkerIconName setMarkerText (format ["Area: %1 Mission: %2 Assigned Count: %3 Control: %4 Terrain: %5",_marker,_mission,(count _assignedAssets),_controlStatus,_terrainMode]);
        };
    } foreach GVAR(CommanderAreas);
}, 3] call CBA_fnc_addPerFrameHandler;

GVAR(CommanderAssets) = [];

GVAR(CommanderAssetsHandlerPFH) = [{
    {
        private _assetArray = _x;
        _assetArray params ["_group","_position","_hasradio","_areaAssigned","_assetType"];
        if (_areaAssigned isEqualTo "NONE") then {
            //check zones for assignments
            private _assigned = false;
            {
                private _areaArray = _x;
                _areaArray params ["_marker","_mission","_min","_max","_threshold","_QRFSupport","_assetSupport","_withdrawalEnabled","_resourceUse","_preferredTypes","_terrainMode","_importance","_assignedAssets","_control"];
                private _assetCount = (count _assignedAssets);
                LOG_4("Area: %1 _assetCount: %2 _max: %4 _assignedAssets: %3",_marker,_assetCount,_assignedAssets,_max);
                if (
                    (_assetCount < _max) &&
                    {_control > -2} &&
                    {!_assigned} &&
                    {(_assetType in _preferredTypes) || ("ALL" in _preferredTypes)}
                ) then {
                    LOG_3("Sending group %1 to area %2 with array: %3",_group,_marker,_areaArray);
                    _assigned = true;
                    [_assetArray,_areaArray,_forEachIndex] call FUNC(assignToArea);
                };
            } foreach GVAR(CommanderAreas);
            if !(_assigned) then {
                ERROR_1("Could not find area suitable for: %1 type %2 ignoring preferred types",_group,_assetType);
                {
                    private _areaArray = _x;
                    _areaArray params ["_marker","_mission","_min","_max","_threshold","_QRFSupport","_assetSupport","_withdrawalEnabled","_resourceUse","_preferredTypes","_terrainMode","_importance","_assignedAssets","_control"];
                    private _assetCount = (count _assignedAssets);
                    LOG_4("Area: %1 _assetCount: %2 _max: %4 _assignedAssets: %3",_marker,_assetCount,_assignedAssets,_max);
                    if (
                        (_assetCount < _max) &&
                        {_control > -2} &&
                        {!_assigned}
                    ) then {
                        LOG_3("Sending group %1 to area %2 with array: %3",_group,_marker,_areaArray);
                        _assigned = true;
                        [_assetArray,_areaArray,_forEachIndex] call FUNC(assignToArea);
                    };
                } foreach GVAR(CommanderAreas);
                if !(_assigned) then {
                    ERROR_1("Could not find area suitable for: %1 sending to default zone",_assetArray);
                    [_assetArray,(GVAR(CommanderAssets) select 0),0] call FUNC(assignToArea);
                };
            };
        };
    } foreach GVAR(CommanderAssets);

}, 3] call CBA_fnc_addPerFrameHandler;
