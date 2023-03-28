#include "script_component.hpp"


params [
    "_group",
    "_namespace"
];


//private _position = GETVAR(_group,position,getposATL leader _group);
//private _hasRadio = (_group call FUNC(hasRadioGroup)) select 0;
//private _areaAssigned = GETVAR(_group,areaAssigned,"NONE");
//private _assetType = GETVAR(_group,assetType,"Infantry");

//private _areaMission = GETVAR(_namespace,mission,"Patrol");
private _areaDisplayName = GETVAR(_namespace,displayName,"");
private _areaMarker = GETVAR(_namespace,marker,"");
//private _areaMin = GETVAR(_namespace,min,0);
//private _areaMax = GETVAR(_namespace,max,10);
//private _areaThreshold = GETVAR(_namespace,threshold,1);
//private _areaQRFSupport = GETVAR(_namespace,QRFSupport,true);
//private _areaAssetSupport = GETVAR(_namespace,assetSupport,true);
//private _areaWithdrawalEnabled = GETVAR(_namespace,withdrawalEnabled,true);
//private _areaResourceUse = GETVAR(_namespace,resourceUse,true);
//private _areaPreferredTypes = GETVAR(_namespace,preferredTypes,"ALL");
//private _areaTerrainMode = GETVAR(_namespace,terrainMode,"Auto");
//private _areaImportance = GETVAR(_namespace,importance,_forEachIndex);
private _areaAssignedAssets = GETVAR(_namespace,assignedAssets,[]);
//private _areaControlStatus = GETVAR(_namespace,control,"Unknown");

LOG_2("assigning %1 to Area: %2",_group,_areaDisplayName);
SETVAR(_group,areaAssigned,_areaMarker);

private _pos = [_areaMarker] call CBA_fnc_randPosArea;
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

_areaAssignedAssets pushBackUnique _group;
SETVAR(_namespace,assignedAssets,_areaAssignedAssets);
