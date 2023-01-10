#include "script_component.hpp"

LOG("Starting CommanderHandler Function");

GVAR(AreaMarkerArray) = [];

GVAR(CommanderAreasHandlerPFH) = [{
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
            _debugMarkerName setmarkercolor _markerColour;
            _debugMarkerName setmarkerpos (getmarkerpos _marker);
            _debugMarkerName setmarkeralpha 0.55;
            private _debugMarkerBorderName = format ["PZAI_Area_M_%1_Border",_marker];
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
            private _debugMarkerIconName = format ["PZAI_Area_M_%1_Icon",_marker];
            if !(_debugMarkerIconName in GVAR(AreaMarkerArray)) then {
                private _markerAreaIcon = createMarker [_debugMarkerIconName,[0,0]];
                GVAR(AreaMarkerArray) pushback _markerAreaIcon;
            };
            _debugMarkerIconName setmarkercolor _markerColour;
            _debugMarkerIconName setMarkerShape "ICON";
            _debugMarkerIconName setMarkerType "hd_dot";
            _debugMarkerIconName setMarkerPos (getmarkerpos _marker);
            _debugMarkerIconName setMarkerText (format ["Area: %1 Mission: %2 Assigned: %3 Control: %4 Importance: %5 Terrain: %6",_displayName,_mission,(count _assignedAssets),_controlStatus,_importance,_terrainMode]);
        };
    } foreach GVAR(CommanderAreasParsed);
}, 3] call CBA_fnc_addPerFrameHandler;
