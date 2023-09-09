#include "script_component.hpp"

params ["_group", "_groupcaller", "_distanceToCaller", "_reportedLocation", "_timeCalled", "_nearbyEnemy", "_enemyHasArmored"];

private _return = false;
private _lastReinforcmentTime = GETVAR(_group,lastReinforcmentTime,-120);
private _task = GETVAR(_group,task,"Patrol");
private _assetType = GETVAR(_group,assetType,"INFANTRY");
private _knownEnemy = (_nearbyEnemy isNotEqualTo []);
//if (GETMVAR(CommanderEnabled,false)) then {
//    private _areaAssigned = GETVAR(_group,areaAssigned,"NONE");
//    if (_areaAssigned isNotEqualTo "NONE") then {
//        private _namespaceName = format ["PZAI_Area_%1", _areaAssigned];
//        private _namespace = missionNamespace getVariable [_namespaceName, locationNull];
//        if (_namespace isNotEqualTo locationNull) then {
//            private _mission = GETVAR(_namespace,mission,"Patrol");
//            private _marker = GETVAR(_namespace,marker,"");
//            //private _min = GETVAR(_namespace,min,0);
//            //private _max = GETVAR(_namespace,max,10);
//            //private _threshold = GETVAR(_namespace,threshold,1);
//            //private _QRFSupport = GETVAR(_namespace,QRFSupport,true);
//            //private _assetSupport = GETVAR(_namespace,assetSupport,true);
//            //private _withdrawalEnabled = GETVAR(_namespace,withdrawalEnabled,true);
//            //private _resourceUse = GETVAR(_namespace,resourceUse,true);
//            //private _preferredTypes = GETVAR(_namespace,preferredTypes,"ALL");
//            private _terrainMode = GETVAR(_namespace,terrainMode,"Auto");
//            private _importance = GETVAR(_namespace,importance,_forEachIndex);
//            private _assignedAssets = GETVAR(_namespace,assignedAssets,[]);
//            private _assetCount = count _assignedAssets;
//            private _controlStatus = GETVAR(_namespace,control,"Unknown");
//        };
//    };
//} else {
    if (_task in ["GARRISON", "STATIONARY", "BUNKER"]) exitwith {
        TRACE_2("exiting response with task",_group,_task);
        false
    };
    if (_lastReinforcmentTime + 120 >= CBA_missionTime) exitwith {
        TRACE_2("exiting response with time",_group,_lastReinforcmentTime);
        false
    };
    private _groupReinforcement = GETVAR(_group,Reinforce,GVAR(Reinforce));
    private _groupQRF = GETVAR(_group,QRF,false);
    private _groupReinforcementDistance = GETVAR(_group,ReinforceDistance,GVAR(ReinforceDistance));
    if ((!(_groupReinforcement) && {!(_groupQRF)})) exitwith {
        TRACE_3("exiting response with vars",_group,_groupReinforcement,_groupQRF);
        false
    };
    if (_distanceToCaller > _groupReinforcementDistance) exitwith {
        TRACE_3("exiting response with distance",_group,_distanceToCaller,_groupReinforcementDistance);
        false
    };
    if (
        _enemyHasArmored &&
        {_assetType in ["MOTORIZED"] ||
        {_assetType in ["SNIPERS", "INFANTRY"]}//&&
        //{!(_group call FUNC(hasAT))}}
        }
    ) exitwith {
        TRACE_2("exiting response with enemy armored no AT",_group,_enemyHasArmored);
        false
    };
    private _currenttarget = GETVAR(_group,CurrentTarget,objnull);
    if (_currenttarget isEqualTo objnull) exitWith {
        TRACE_1("exiting response true with null currenttarget",_group);
        true
    };
    private _distanceTarget = (leader _group) distance2d _currenttarget;
    if (_distanceTarget >= (_reportedLocation * 2) || {((CBA_MissionTime >= (_lastReinforcmentTime + 600)) && {_distanceTarget > 300})}) then {
        _return = true;
    };
//};

if (GVAR(Debug)) then {
	TRACE_5("reinforcement response params",_groupcaller,_nearbyEnemy,_timeCalled,_group,_return);
};

_return
