#include "script_component.hpp"
params [["_type", "", [""]], ["_valueName", "", [""]]];

if ("" in [_type,_valueName]) exitwith {};

private _cachedArray = GVAR(ConfigCache) getvariable [_type, []];

private _index = switch _valueName do {
    case "size": {
        0
    };
    case "onPlaceCancel": {
        1
    };
    case "objDemolitionTime": {
        2
    };
    case "canDemolish": {
        3
    };
    case "canPackUp": {
        4
    };
    case "objPackUpTime": {
        5
    };
    case "objBuildTime": {
        6
    };
    case "onBuildStart": {
        7
    };
    case "onBuildComplete": {
        8
    };
    case "boundingBoxSize": {
        9
    };
    case "boundingBoxOffset": {
        10
    };
    case "minHeight": {
        11
    };
    case "maxHeight": {
        12
    };
    case "canFloat": {
        13
    };
    case "canCollide": {
        14
    };
    case "canPlaceOnRoad": {
        15
    };
    case "surfaceNormal": {
        16
    };
    case "surfaceNormalForced": {
        17
    };
    case "onPlaceStart": {
        18
    };
    default {0};
};

private _return = nil;

if !(_cachedArray isEqualTo []) then {
    _return = _cachedArray select _index;
} else {
    private _size = [(missionConfigFile >> "CfgGradFortifications" >> "Fortifications" >> _type >> "size"),"number",[_type] call FUNC(getObjectSize)] call CBA_fnc_getConfigEntry;
    private _onPlaceCancel = [(missionConfigFile >> "CfgGradFortifications" >> "Fortifications"  >> _type >> "onPlaceCancel"),"text",([(missionConfigFile >> "CfgGradFortifications" >> "onPlaceCancel"),"text",""] call CBA_fnc_getConfigEntry)] call CBA_fnc_getConfigEntry;
    private _objDemolitionTime = [(missionConfigFile >> "CfgGradFortifications" >> "Fortifications" >> _type >> "demolitionTime"),"number",(([_type] call FUNC(getObjectSize)) * 10)] call CBA_fnc_getConfigEntry;
    private _canDemolish = ([(missionConfigFile >> "CfgGradFortifications" >> "Fortifications" >> _type >> "canDemolish"),"number",1] call CBA_fnc_getConfigEntry) == 1;
    private _canPackUp = ([(missionConfigFile >> "CfgGradFortifications" >> "Fortifications" >> _type >> "canPackUp"),"number",1] call CBA_fnc_getConfigEntry) == 1;
    private _objPackUpTime = [(missionConfigFile >> "CfgGradFortifications" >> "Fortifications" >> _type >> "packUpTime"),"number",(([_type] call FUNC(getObjectSize)) * 15)] call CBA_fnc_getConfigEntry;
    private _objBuildTime = [(missionConfigFile >> "CfgGradFortifications" >> "Fortifications" >> _type >> "buildTime"),"number",(([_type] call FUNC(getObjectSize)) * 3)] call CBA_fnc_getConfigEntry;
    private _onBuildStart = [(missionConfigFile >> "CfgGradFortifications" >> "Fortifications"  >> _type >> "onBuildStart"),"text",([(missionConfigFile >> "CfgGradFortifications" >> "onBuildStart"),"text",""] call CBA_fnc_getConfigEntry)] call CBA_fnc_getConfigEntry;
    private _onBuildComplete = [(missionConfigFile >> "CfgGradFortifications" >> "Fortifications"  >> _type >> "onBuildComplete"),"text",([(missionConfigFile >> "CfgGradFortifications" >> "onBuildComplete"),"text",""] call CBA_fnc_getConfigEntry)] call CBA_fnc_getConfigEntry;
    private _boundingBoxSize = [(missionConfigFile >> "CfgGradFortifications" >> "Fortifications" >> _type >> "boundingBoxSize"),"number",1] call CBA_fnc_getConfigEntry;
    private _boundingBoxOffset = [(missionConfigFile >> "CfgGradFortifications" >> "Fortifications" >> _type >> "boundingBoxOffset"),"array",[0,0,0]] call CBA_fnc_getConfigEntry;
    private _minHeight = [(missionConfigFile >> "CfgGradFortifications" >> "Fortifications" >> _type >> "minHeight"),"number",-0.8] call CBA_fnc_getConfigEntry;
    private _maxHeight = [(missionConfigFile >> "CfgGradFortifications" >> "Fortifications" >> _type >> "maxHeight"),"number",3] call CBA_fnc_getConfigEntry;
    private _canFloat = ([(missionConfigFile >> "CfgGradFortifications" >> "Fortifications" >> _type >> "canFloat"),"number",0] call CBA_fnc_getConfigEntry) == 1;
    private _canCollide = ([(missionConfigFile >> "CfgGradFortifications" >> "Fortifications"  >> _type >> "canCollide"),"number",0] call CBA_fnc_getConfigEntry) == 1;
    private _canPlaceOnRoad = ([(missionConfigFile >> "CfgGradFortifications" >> "Fortifications"  >> _type >> "canPlaceOnRoad"),"number",1] call CBA_fnc_getConfigEntry) == 1;
    private _surfaceNormal = ([(missionConfigFile >> "CfgGradFortifications" >> "Fortifications"  >> _type >> "surfaceNormal"),"number",1] call CBA_fnc_getConfigEntry) == 1;
    private _surfaceNormalForced = ([(missionConfigFile >> "CfgGradFortifications" >> "Fortifications"  >> _type >> "surfaceNormalForced"),"number",0] call CBA_fnc_getConfigEntry) == 1;
    private _onPlaceStart = [(missionConfigFile >> "CfgGradFortifications" >> "Fortifications"  >> _type >> "onPlaceStart"),"text",([(missionConfigFile >> "CfgGradFortifications" >> "onPlaceStart"),"text",""] call CBA_fnc_getConfigEntry)] call CBA_fnc_getConfigEntry;
    
    _cachedArray = [
        /* 0 */ _size,
        /* 1 */ _onPlaceCancel,
        /* 2 */ _objDemolitionTime,
        /* 3 */ _canDemolish,
        /* 4 */ _canPackUp,
        /* 5 */ _objPackUpTime,
        /* 6 */ _objBuildTime,
        /* 7 */ _onBuildStart,
        /* 8 */ _onBuildComplete,
        /* 9 */ _boundingBoxSize,
        /* 10 */ _boundingBoxOffset,
        /* 11 */ _minHeight,
        /* 12 */ _maxHeight,
        /* 13 */ _canFloat,
        /* 14 */ _canCollide,
        /* 15 */ _canPlaceOnRoad,
        /* 16 */ _surfaceNormal,
        /* 17 */ _surfaceNormalForced,
        /* 18 */ _onPlaceStart
    ];
    
    GVAR(ConfigCache) setvariable [_type, _cachedArray, true];
    
    _return = _cachedArray select _index;
};

TRACE_3("",_type,_valueName,_return);

_return



