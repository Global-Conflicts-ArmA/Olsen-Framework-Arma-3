#include "script_component.hpp"

LOG("Starting CommanderHandler Function");

GVAR(AreaMarkerArray) = [];
GVAR(CommanderThreats) = [];

GVAR(CommanderHandlerPFH) = [{
    // Handle Assets (groups)
    {
        private _group = _x;
        private _assetType = GETVAR(_group,assetType,"NONE");
        if (_assetType isEqualTo "NONE") then {
            _assetType = "INFANTRY";
        };
        private _areaAssigned = GETVAR(_group,areaAssigned,"NONE");
        if (_areaAssigned isNotEqualTo "NONE") then {
            private _index = GVAR(CommanderAreasParsed) findIf {
                private _namespace = missionNamespace getVariable _x;
                private _marker = GETVAR(_namespace,marker,"");
                _areaAssigned isEqualTo _marker
            };
            if (_index isEqualTo -1) then {
                ERROR_2("Group %1 assigned to a null area with value %2",_group,_areaAssigned);
            } else {
                private _namespace = missionNamespace getVariable (GVAR(CommanderAreasParsed) select _index);
                private _assetsAssigned = GETVAR(_namespace,assignedAssets,[]);
                if !(_group in _assetsAssigned) then {
                    LOG_2("Sending group %1 to area %2",_group,_areaAssigned);
                    [_group,_namespace] call FUNC(assignToArea);
                };
            };
        } else {
            //check zones for assignments
            private _assigned = false;
            private _inAreaIndex = GVAR(CommanderAreasParsed) findIf {
                private _namespace = missionNamespace getVariable _x;
                private _marker = GETVAR(_namespace,marker,"");
                leader _group inArea _marker
            };
            if (
                (GETMVAR(CommanderAssignStartZone,false)) &&
                {_inAreaIndex isNotEqualTo -1}
            ) then {
                private _namespace = missionNamespace getVariable (GVAR(CommanderAreasParsed) select _inAreaIndex);
                private _displayName = GETVAR(_namespace,displayName,"");
                private _max = GETVAR(_namespace,max,10);
                private _assignedAssets = GETVAR(_namespace,assignedAssets,[]);
                private _assetCount = count _assignedAssets;
                private _controlStatus = GETVAR(_namespace,control,"Unknown");
                private _preferredTypes = GETVAR(_namespace,preferredTypes,"ALL");
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
            } else {
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
                    private _importance = GETVAR(_namespace,importance,_forEachIndex);
                    private _assignedAssets = GETVAR(_namespace,assignedAssets,[]);
                    private _controlStatus = GETVAR(_namespace,control,"Unknown");
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
            };
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
                    private _controlStatus = GETVAR(_namespace,control,"Unknown");
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
    } forEach GVAR(CommanderAssets);
    // Handle Areas
    {
        private _namespace = missionNamespace getVariable _x;
        private _displayName = GETVAR(_namespace,displayName,"");
        private _mission = GETVAR(_namespace,mission,"Patrol");
        private _marker = GETVAR(_namespace,marker,"");
        //private _min = GETVAR(_namespace,min,0);
        //private _max = GETVAR(_namespace,max,10);
        //private _threshold = GETVAR(_namespace,threshold,1);
        //private _QRFSupport = GETVAR(_namespace,QRFSupport,true);
        //private _assetSupport = GETVAR(_namespace,assetSupport,true);
        //private _withdrawalEnabled = GETVAR(_namespace,withdrawalEnabled,true);
        //private _resourceUse = GETVAR(_namespace,resourceUse,true);
        //private _preferredTypes = GETVAR(_namespace,preferredTypes,"ALL");
        private _terrainMode = GETVAR(_namespace,terrainMode,"Auto");
        private _importance = GETVAR(_namespace,importance,_forEachIndex);
        private _assignedAssets = GETVAR(_namespace,assignedAssets,[]);
        private _knownEnemies = [GVAR(CommanderSide)] call FUNC(enemyArray);
        private _enemiesInArea = {_x inArea _marker} count _knownEnemies;
        private _assetsInArea = {leader _x inArea _marker} count _assignedAssets;
        private _controlStatus = if (_assetsInArea > 0) then {
            if (_enemiesInArea isEqualTo 0) then {
                "Friendly"
            } else {
                "Contested"
            };
        } else {
            if (_enemiesInArea isEqualTo 0) then {
                "Unknown"
            } else {
                "Enemy"
            };
        };

        if (GVAR(CommanderDebug)) then {
            private _markerColour = switch (_terrainMode) do {
                case "OPEN": {"BH_CheckLOS_khaki"};
                case "URBAN": {"ColorUnknown"};
                case "COAST": {"BH_CheckLOS_Gray"};
                case "FOREST HILL": {"ColorGreen"};
                case "FOREST": {"ColorGUER"};
                case "HILL": {"ColorWhite"};
                default {"ColorGrey"};
            };
            private _debugMarkerName = format ["PZAI_Area_M_%1",_marker];
            if !(_debugMarkerName in GVAR(AreaMarkerArray)) then {
                private _markerArea = createMarker [_debugMarkerName,[0,0]];
                GVAR(AreaMarkerArray) pushback _markerArea;
            };
            _debugMarkerName setMarkerShape (markerShape _marker);
            _debugMarkerName setMarkerSize (getMarkerSize _marker);
            _debugMarkerName setMarkerDir (markerDir _marker);
            _debugMarkerName setMarkerBrush "FDiagonal";
            _debugMarkerName setMarkerColor _markerColour;
            _debugMarkerName setMarkerPos (getmarkerpos _marker);
            _debugMarkerName setMarkerAlpha 0.55;
            private _debugMarkerBorderName = format ["PZAI_Area_M_%1_Border",_marker];
            if !(_debugMarkerBorderName in GVAR(AreaMarkerArray)) then {
                private _markerAreaBorder = createMarker [_debugMarkerBorderName,[0,0]];
                GVAR(AreaMarkerArray) pushback _markerAreaBorder;
            };
            _debugMarkerBorderName setMarkerShape (markerShape _marker);
            _debugMarkerBorderName setMarkerSize (getMarkerSize _marker);
            _debugMarkerBorderName setMarkerDir (markerDir _marker);
            _debugMarkerBorderName setMarkerBrush "Border";
            _debugMarkerBorderName setMarkerColor _markerColour;
            _debugMarkerBorderName setMarkerPos (getmarkerpos _marker);
            _debugMarkerBorderName setMarkerAlpha 0.85;
            private _debugMarkerIconName = format ["PZAI_Area_M_%1_Icon",_marker];
            if !(_debugMarkerIconName in GVAR(AreaMarkerArray)) then {
                private _markerAreaIcon = createMarker [_debugMarkerIconName,[0,0]];
                GVAR(AreaMarkerArray) pushback _markerAreaIcon;
            };
            _debugMarkerIconName setMarkerColor _markerColour;
            _debugMarkerIconName setMarkerShape "ICON";
            _debugMarkerIconName setMarkerType "hd_dot";
            _debugMarkerIconName setMarkerPos (getmarkerpos _marker);
            _debugMarkerIconName setMarkerText (format ["Area: %1 Mission: %2 Assigned: %3 Control: %4 Importance: %5 Terrain: %6",_displayName,_mission,(count _assignedAssets),_controlStatus,_importance,_terrainMode]);
        };
    } forEach GVAR(CommanderAreasParsed);
    // Handle Threats
    private _updatedThreats = [];
    GVAR(CommanderThreats) apply {
        _x params [
            ["_targetGroup", grpNull, [grpNull,[]]],
            ["_targetMarkers", ["", ""], [[]]],
            ["_reportedLocation", [0,0,0], [[]]],
            ["_lastTimeUpdated", -1, [0]],
            ["_enemyType", "Infantry", [""]],
            ["_enemyInfantryCount", 0, [0]],
            ["_enemyHasVehicles", false, [false]],
            ["_enemyHasArmored", false, [false]],
            ["_lastTimeAddressed", -1, [0]],
            ["_threatLevel", -1, [0]],
            ["_nearestArea", "", [""]]
        ];
        _targetMarkers params [
            ["_areaMarker", "", [""]],
            ["_textMarker", "", [""]]
        ];
        private _groupMembers = if (_targetGroup isEqualType []) then {
            private _tempCount = 0;
            {
                _tempCount = _tempCount + count units _x;
            } forEach _targetGroup;
        } else {
            count units _targetGroup
        };
        // remove empty/dead threats before iteration
        if (_groupMembers == 0) then {
            if (
                (_areaMarker isNotEqualTo "") &&
                {markerColor _areaMarker isNotEqualTo ""}
            ) then {
                deleteMarker _areaMarker;
                deleteMarker _textMarker;
            };
        } else {
            // check for other nearby threats and combine
            private _searchIndex = GVAR(CommanderThreats) findIf {
                private _otherThreat = _x;
                if (_otherThreat select 0 isEqualTo _targetGroup) then {
                    // exclude same group obviously
                    false
                } else {
                    private _otherPos = _otherThreat select 2;
                    _reportedLocation distance2D _otherPos <= 50
                };
            };
            if (_searchIndex isNotEqualTo -1) then {
                // "add" to other threat
                (GVAR(CommanderThreats) select _searchIndex) params [
                    ["_otherTargetGroup", grpNull, [grpNull, []]],
                    ["_otherTargetMarkers", "", [""]],
                    ["_otherReportedLocation", [0,0,0], [[]]],
                    ["_otherLastTimeUpdated", -1, [0]],
                    ["_otherEnemyType", "Infantry", [""]],
                    ["_otherEnemyInfantryCount", 0, [0]],
                    ["_otherEnemyHasVehicles", false, [false]],
                    ["_otherEnemyHasArmored", false, [false]],
                    ["_otherLastTimeAddressed", -1, [0]],
                    ["_otherThreatPriority", -1, [0]],
                    ["_otherNearestArea", "", [""]]
                ];
                // delete one of the markers
                if (
                    (_areaMarker isNotEqualTo "") &&
                    {markerColor _areaMarker isNotEqualTo ""}
                ) then {
                    deleteMarker _areaMarker;
                    deleteMarker _textMarker;
                };
                // _g + _g2
                // [] + _g2
                // _g + []
                // [] + []
                // merge groups/arrays of groups
                if (_otherTargetGroup isEqualType grpNull) then {
                    if (_targetGroup isEqualType grpNull) then {
                        _targetGroup = [_targetGroup, _otherTargetGroup];
                    } else {
                        _targetGroup pushBackUnique _otherTargetGroup;
                    };
                } else {
                    if (_targetGroup isEqualType grpNull) then {
                        _targetGroup = _otherTargetGroup + _targetGroup;
                    } else {
                        _targetGroup append _otherTargetGroup;
                    };
                };
                // get last updated time
                if (_otherLastTimeUpdated > _lastTimeUpdated) then {
                    _lastTimeUpdated = _otherLastTimeUpdated;
                };
                if (_otherLastTimeAddressed > _lastTimeAddressed) then {
                    _lastTimeAddressed = _otherLastTimeAddressed;
                };
                // merge other values
                _enemyInfantryCount = _enemyInfantryCount + _otherEnemyInfantryCount;
                if (!_enemyHasVehicles && _otherEnemyHasVehicles) then {
                    _enemyHasVehicles = true;
                };
                if (!_enemyHasArmored && _otherEnemyHasArmored) then {
                    _enemyHasArmored = true;
                };
                // set values for other threat and do not add this threat to updated threat array
                private _setArray = [
                    _targetGroup,
                    _otherTargetMarkers,
                    _otherReportedLocation,
                    _lastTimeUpdated,
                    _otherEnemyType,
                    _enemyInfantryCount,
                    _enemyHasVehicles,
                    _enemyHasArmored,
                    _lastTimeAddressed,
                    _otherThreatPriority,
                    _otherNearestArea
                ];
                TRACE_2("merged threats",_targetGroup,_otherTargetGroup);
                GVAR(CommanderThreats) set [_searchIndex, _setArray];
            } else {
                // iterate through threat
                private _targetSide = side _targetGroup;
                private _threatMarkerSize = if (_enemyHasArmored || _enemyHasVehicles) then {
                    "LARGE"
                } else {
                    if (_enemyInfantryCount > 8) then {
                        "MEDIUM"
                    } else {
                        "SMALL"
                    };
                };
                // debug marker for threat
                if (GETMVAR(CommanderDebug,false)) then {
                    private _size = switch _threatMarkerSize do {
                        case "LARGE": {
                            [15,15]
                        };
                        case "MEDIUM": {
                            [8,8]
                        };
                        default {
                            [3,3]
                        };
                    };
                    private _markerText = format [" Report: %1 at: %2 type: %3",_targetGroup,_lastTimeUpdated,_enemyType];
                    if (
                        (_areaMarker isEqualTo "") ||
                        markerColor _areaMarker isEqualTo ""
                    ) then {
                        // create marker
                        private _markerColour = switch (_targetSide) do {
                            case west: {"ColorBlue"};
                            case east: {"ColorRed"};
                            case independent: {"ColorGreen"};
                            case civilian: {"ColorYellow"};
                            default {"ColorBlack"};
                        };
                        _areaMarker = format ["report_area_%1",_targetGroup];
                        createMarker [_areaMarker, [0,0]];
                        _areaMarker setMarkerShapeLocal "ELLIPSE";
                        _areaMarker setMarkerBrushLocal "Border";
                        _areaMarker setMarkerSizeLocal _size;
                        _areaMarker setMarkerColorLocal _markerColour;
                        _areaMarker setMarkerPos _reportedLocation;

                        private _textMarker = format ["report_text_%1",_targetGroup];
                        createMarker [_textMarker, [0,0]];
                        _textMarker setMarkerShapeLocal "ICON";
                        _textMarker setMarkerTypeLocal "mil_objective";
                        _textMarker setMarkerSizeLocal [0.5,0.5];
                        _textMarker setMarkerColorLocal _markerColour;
                        _textMarker setMarkerTextLocal _markerText;
                        _textMarker setMarkerPos _reportedLocation;
                    } else {
                        // update marker
                        _areaMarker setMarkerTextLocal _markerText;
                        _areaMarker setMarkerSizeLocal _size;
                        _areaMarker setMarkerPos _reportedLocation;
                        _textMarker setMarkerPos _reportedLocation;
                    };
                };
                //detemine closest area
                private _areaDistances = GVAR(CommanderAreasParsed) select {
                    private _namespace = missionNamespace getVariable _x;
                    !(GETVAR(_namespace,deactivated,false))
                } apply {
                    private _namespace = missionNamespace getVariable _x;
                    private _marker = GETVAR(_namespace,marker,"");
                    private _markerPos = getMarkerPos _marker;
                    private _importance = GETVAR(_namespace,importance,0);
                    [_reportedLocation distance2D _markerPos, _x, _importance]
                };
                _areaDistances sort true;
                _nearestArea = _areaDistances select 0 select 1;
                private _importance = _areaDistances select 0 select 2;
                //TRACE_3("nearestArea calc",_targetGroup,_nearestArea,_importance);
                // detemine effective threat level - threat equation
                // threat level base (marker size calc) + importance of area zone (0 is highest)
                private _size = switch _threatMarkerSize do {
                    case "LARGE": {15};
                    case "MEDIUM": {8};
                    default {3};
                };
                private _threatLevel = _size + (10 - (_importance * 2));
                TRACE_2("threat level calc",_targetGroup,_threatLevel);
                // address with assets

                private _setArray = [
                    _targetGroup,
                    [_areaMarker, _textMarker],
                    _reportedLocation,
                    _lastTimeUpdated,
                    _enemyType,
                    _enemyInfantryCount,
                    _enemyHasVehicles,
                    _enemyHasArmored,
                    _lastTimeAddressed,
                    _threatLevel,
                    _nearestArea
                ];
                _updatedThreats pushBack _setArray;
            };
        };
    };
    //update GVAR with updated array
    GVAR(CommanderThreats) = _updatedThreats;
}, 3] call CBA_fnc_addPerFrameHandler;
