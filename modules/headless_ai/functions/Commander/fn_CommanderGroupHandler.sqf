#include "script_component.hpp"

params [
    ["_group", grpNull, [grpNull]],
    ["_areaAssigned", "NONE", [""]],
    ["_assetType", "Infantry", [""]]
];

//commander handling
if (_areaAssigned isEqualTo "NONE") then {
    //check zones for assignments
    private _assigned = false;
    if (GETMVAR(CommanderAssignStartZone,false)) then {
        private _index = GVAR(CommanderAreasParsed) findIf {
            private _namespace = missionNamespace getVariable _x;
            private _marker = GETVAR(_namespace,marker,"");
            leader _group inArea _marker
        };
        if (_index isNotEqualTo -1) then {
            private _namespace = missionNamespace getVariable (GVAR(CommanderAreasParsed) select _index);
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
            //private _importance = GETVAR(_namespace,importance,_forEachIndex);
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
