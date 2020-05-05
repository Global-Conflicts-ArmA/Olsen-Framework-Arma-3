#include "..\..\script_macros.hpp"

params [["_group",grpNull,[grpNull]]];

LOG_1("%1 added to GroupHandler State Machine",_group);

if (GETMVAR(GroupArray,[]) isEqualTo []) then {
    GVAR(GroupArray) = [];
};

private _units = units _group;
private _aliveUnits = _units select {alive _x};
private _index = [GVAR(GroupArray),_group,1] call FUNC(searchNestedArray);
private _inArray = !(_index isEqualTo -1);
private _leader = leader _group;
private _side = side _leader;
private _behaviourtasking = GETVAR(_group,Mission,"NONE");
private _groupcount = {alive _x} count _aliveUnits;
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

