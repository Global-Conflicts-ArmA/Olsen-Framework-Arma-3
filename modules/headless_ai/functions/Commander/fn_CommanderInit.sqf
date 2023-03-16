#include "script_component.hpp"

LOG("Starting Commander Init");

GVAR(CommanderAreasParsed) = [];

{
    private _area = _x;
    _area params [
    /*1*/ ["_displayName", "", [""]],
    /*2*/ ["_marker", "", [""]],
    /*3*/ ["_mission", "Patrol", [""]],
    /*4*/ ["_min",0,[0]],
    /*5*/ ["_max",10,[10]],
    /*6*/ ["_threshold",1,[1]],
    /*7*/ ["_QRFSupport",true,[true]],
    /*8*/ ["_assetSupport",true,[true]],
    /*9*/ ["_withdrawalEnabled",true,[true]],
   /*10*/ ["_resourceUse",true,[true]],
   /*11*/ ["_preferredTypes",["ALL"],[[]]],
   /*12*/ ["_terrainMode","Auto",[""]],
   /*13*/ ["_importance",_foreachIndex,[0]],
   /*14*/ ["_assignedAssets",[],[[]]],
   /*15*/ ["_control","Neutral",["Neutral"]]
    ];
    TRACE_1("",_area);
    private _markerSuccess = false;
    if (_displayName isEqualTo "") then {
        _displayName = _marker;
        ERROR_1("%1 has no display name! defaulting to marker name",_displayName);
    };
    if ((getMarkerColor _marker) isEqualTo "") then {
        ERROR_2("%1 marker: %2 does not exist!",_displayName,_marker);
    } else {
        if !((markerShape _marker) in ["RECTANGLE", "ELLIPSE"]) then {
            ERROR_1("%1 is not an area marker!",_marker);
        } else {
            LOG_1("passed check for area: %1",_displayName);
            //hide marker
            _marker setMarkerAlpha 0;
            _markerSuccess = true;
        };
    };
    if !(_markerSuccess) then {
        continue;
    };
    if (_min < 0) then {
        ERROR_2("%1 min value below minimum! _min: %2",_displayName,_min);
        _min = 0;
    };
    if (_max < 1) then {
        ERROR_2("%1 max value below minimum! max: %2",_displayName,_max);
        _max = 10;
    };
    if (_threshold > _max) then {
        ERROR_2("%1 threshold value above maximum! threshold: %2 max: %3",_displayName,_threshold,_max);
        _threshold = 1;
    };
    if (_preferredTypes isEqualTo []) then {
        ERROR_2("%1 preferredTypes value empty! preferredTypes: %2",_displayName,_preferredTypes);
        _preferredTypes = ["ALL"];
    };
    if !(_terrainMode in ["URBAN","COAST","FOREST HILL","FOREST","HILL","OPEN","Auto"]) then {
        ERROR_2("%1 invalid terrainMode: %2",_displayName,_terrainMode);
        _terrainMode = "Auto";
    };
    if (_terrainMode isEqualTo "Auto") then {
        private _markerPos = getMarkerPos _marker;
        (getMarkerSize _marker) params ["_markerSizeX", "_markerSizeY"];
        private _markerSizeLarge = [_markerSizeX,_markerSizeY] select (_markerSizeY >= _markerSizeX);
        private _markerSizeSmall = [_markerSizeX,_markerSizeY] select (_markerSizeY <= _markerSizeX);
        private _buildings =  (_markerPos nearObjects ["House", _markerSizeLarge]) select {_x inArea _marker};
        private _neededBuildings = (2 + ((_markerSizeLarge / 100) * 2));
        private _buildingCount = {(count ([_x, 3] call CBA_fnc_buildingPositions)) > 2} count _buildings;
        TRACE_3("",_marker,_neededBuildings,_buildingCount);
        if (_buildingCount >= _neededBuildings) then {
			_terrainMode = "URBAN";
        } else {
            private _coast = {_x select 1 > 0.8} count selectBestPlaces [_markerPos, _markerSizeSmall, "sea - waterDepth", 8, 5];
            if (_coast isEqualTo 5) then {
                 _terrainMode = "COAST";
            } else {
                private _treecount = {_x select 1 > 0.6} count selectBestPlaces [_markerPos, _markerSizeSmall, "forest", 8, 5];
				if (_treecount isEqualTo 5) then {
					private _hillcount = {_x select 1 > 0.2} count selectBestPlaces [_markerPos, _markerSizeSmall, "2* hills", 8, 5];
					if (_hillcount isEqualTo 5) then {
						_terrainMode = "FOREST HILL";
					} else {
						_terrainMode = "FOREST";
					};
                } else {
                    private _hillcount = {_x select 1 > 0.2} count selectBestPlaces [_markerPos, _markerSizeSmall, "2* hills", 8, 5];
                    if (_hillcount isEqualTo 5) then {
						_terrainMode = "HILL";
					} else {
                        _terrainMode = "OPEN";
                    };
                };
            };
        };
    };
    TRACE_3("",_displayName,_terrainMode);
    private _namespaceName = format ["PZAI_Area_%1", _marker];
    if (_namespaceName in ([] call CBA_fnc_allNamespaces)) then {
        ERROR_2("Area: %1 has duplicate marker name: %2",_displayName,_marker);
    } else {
        private _namespaceTemp = [] call CBA_fnc_createNamespace;
        SETVAR(_namespaceTemp,displayName,_displayName);
        SETVAR(_namespaceTemp,marker,_marker);
        SETVAR(_namespaceTemp,mission,_mission);
        SETVAR(_namespaceTemp,min,_min);
        SETVAR(_namespaceTemp,max,_max);
        SETVAR(_namespaceTemp,threshold,_threshold);
        SETVAR(_namespaceTemp,QRFSupport,_QRFSupport);
        SETVAR(_namespaceTemp,assetSupport,_assetSupport);
        SETVAR(_namespaceTemp,withdrawalEnabled,_withdrawalEnabled);
        SETVAR(_namespaceTemp,resourceUse,_resourceUse);
        SETVAR(_namespaceTemp,preferredTypes,_preferredTypes);
        SETVAR(_namespaceTemp,terrainMode,_terrainMode);
        SETVAR(_namespaceTemp,importance,_importance);
        SETVAR(_namespaceTemp,assignedAssets,_assignedAssets);
        SETVAR(_namespaceTemp,control,_control);
        missionNamespace setVariable [_namespaceName, _namespaceTemp];
        GVAR(CommanderAreasParsed) pushBackUnique _namespaceName;
    };
} foreach GVAR(CommanderAreas);

[{
    (GVAR(CommanderAreasParsed) isNotEqualTo []) &&
    {((missionNamespace getVariable [(GVAR(CommanderAreasParsed) select 0), locationNull]) isNotEqualTo locationNull)} &&
    {(((missionNamespace getVariable (GVAR(CommanderAreasParsed) select 0)) getVariable [QGVAR(marker), ""]) isNotEqualTo "")}
},{
    [] call FUNC(CommanderHandler);
}, []] call CBA_fnc_waitUntilAndExecute;
