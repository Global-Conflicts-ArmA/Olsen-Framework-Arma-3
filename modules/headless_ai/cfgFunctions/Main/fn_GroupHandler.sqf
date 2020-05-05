//Handles Group States, communications between friendly groups, and command structure
#include "..\..\script_macros.hpp"


LOG("Starting GroupArray Function");

GVAR(GroupArray) = [];

GVAR(GroupHandlerPFH) = [{
    {
        private _group = _x;
        private _units = units _group;
        private _aliveUnits = _units select {alive _x};
        if (GETMVAR(GroupDebug,false)) then {
            LOG_2("group: %1 units: %2",_group,_aliveUnits);
        };
        if (_aliveUnits isEqualTo []) then {
            if (GETMVAR(GroupDebug,false)) then {
                LOG_1("deleting empty group: %1",_group);
            };
            deleteGroup _group;
        } else {
            private _index = [GVAR(GroupArray),_group,1] call FUNC(searchNestedArray);
            private _inArray = !(_index isEqualTo -1);
            //TRACE_2("checking group",_group,_inArray);
            private _leader = _aliveUnits select 0;
            private _leaderAlive = alive _leader;
            if (GETMVAR(GroupDebug,false)) then {
                //LOG_3("group: %1 leader: %2 alive: %3",_group,_leader,_leaderAlive);
            };
            if (!(isNull _leader) &&
                {!(isPlayer _leader)} &&
                {(alive _leader)} &&
                {(side _leader) in GVAR(SideBasedExecution)} &&
                {!(GETVAR(_leader,NOAI,false))}
            ) then {
                private _side = side _leader;
                private _behaviourtasking = (_Group getVariable [QGVAR(Mission),"NONE"]);
                private _groupcount = {alive _x} count (units _group);
                private _behaviour = behaviour _leader;
                private _target = GETVAR(_group,CurrentTarget,objnull);
                private _position = getposATL _leader;
                private _hasradio = GETVAR(_group,HasRadio,false);
                private _areaAssigned = GETVAR(_group,areaAssigned,"NONE");
                private _assetType = "Infantry";
                private _groupArray = [_side, _group, _leader, _groupcount, _behaviourtasking, _behaviour, _target, _position, _hasradio, _areaAssigned, _assetType];
                if (_inArray) then {
                    GVAR(GroupArray) set [_index,_groupArray];
                } else {
                    GVAR(GroupArray) pushback _groupArray;
                };
                if (GVAR(CommanderEnabled)) then {
                    private _index = [GVAR(CommanderAssets),_group,0] call FUNC(searchNestedArray);
                    if (_areaAssigned isEqualTo "NONE") then {
                        {
                            private _areaArray = _x;
                            _areaArray params ["_marker","_mission","_min","_max","_threshold","_QRFSupport","_assetSupport","_withdrawalEnabled","_resourceUse","_preferredTypes","_terrainMode","_importance","_assignedAssets","_control"];
                            private _assetCount = (count _assignedAssets);
                            //LOG_3("Area %1 is group inside? %2 within max count? %3",_marker,(_position inArea _marker),(_max > _assetCount));
                            if (
                                (GETMVAR(CommanderAssignStartZone,false)) &&
                                {(_position inArea _marker)} &&
                                {(_max > _assetCount)} &&
                                {(_assetType in _preferredTypes) || ("ALL" in _preferredTypes)}
                            ) exitwith {
                                _areaAssigned = _marker;
                                SETVAR(_group,areaAssigned,_marker);
                                if (GETMVAR(CommanderDebug,false)) then {
                                    LOG_2("Assigning group %1 to starting area %2",_group,_marker);
                                };
                                [[_group,_position,_hasradio,_areaAssigned,_assetType],_areaArray,_forEachIndex] call FUNC(assignToArea);
                            };
                        } foreach GVAR(CommanderAreas);
                    };
                    private _assetArray = [_group,_position,_hasradio,_areaAssigned,_assetType];
                    if (_index isEqualTo -1) then {
                        GVAR(CommanderAssets) pushback _assetArray;
                    } else {
                        GVAR(CommanderAssets) set [_index,_assetArray];
                    };
                };
            } else {
                if (_inArray) then {
                    LOG_1("group invalid removing from array: %1",_group);
                    GVAR(GroupArray) deleteAt _index;
                };
            };
        };
    } forEach allGroups;
}, 1] call CBA_fnc_addPerFrameHandler;
