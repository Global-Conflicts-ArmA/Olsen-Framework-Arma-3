#include "..\..\script_macros.hpp"


params [
    "_assetArray",
    "_areaArray",
    "_areaIndex"
];
_assetArray params [
    "_group",
    "_position",
    "_hasradio",
    "_areaAssigned",
    "_assetType"
];
_areaArray params [
    "_marker",
    "_mission",
    "_min",
    "_max",
    "_threshold",
    "_QRFSupport",
    "_assetSupport",
    "_withdrawalEnabled",
    "_resourceUse",
    "_preferredTypes",
    "_terrainMode",
    "_importance",
    "_assignedAssets",
    "_control"
];

LOG_2("adding %1 to Area: %2",_group,_marker);

_areaAssigned = _marker;
SETVAR(_group,areaAssigned,_marker);
private _index = [GVAR(CommanderAssets),_group,0] call FUNC(searchNestedArray);
private _assetArray = [_group,_position,_hasradio,_areaAssigned,_assetType];
if (_index isEqualTo -1) then {
    GVAR(CommanderAssets) pushback _assetArray;
} else {
    GVAR(CommanderAssets) set [_index,_assetArray];
};


private _pos = _marker call BIS_fnc_randomPosTrigger;
private _taskSet = [
    _group,
    _pos,
    50,
    3,
    "UNCHANGED",
    "NO CHANGE",
    "UNCHANGED",
    "NO CHANGE"
];
_taskSet call FUNC(taskPatrol);

_assignedAssets pushBackUnique _assetArray;
private _areaArrayPass = [_marker,_mission,_min,_max,_threshold,_QRFSupport,_assetSupport,_withdrawalEnabled,_resourceUse,_preferredTypes,_terrainMode,_importance,_assignedAssets,_control];

GVAR(CommanderAreas) set [_areaIndex,_areaArrayPass];
