#include "..\..\script_macros.hpp"


params ["_unit",["_bld",objNull,[objNull]],["_bldPos",[],[[]]],["_wpWait",5,[0]],["_uSet",[],[[]]],["_sec",[],[[]]],["_error",false,[false]],["_m",0,[0]],"_i"];
_uSet params [["_behaviour","safe",[""]],["_combat","red",[""]],["_speed","limited",[""]],["_formation","wedge",[""]]];
if (isNull _bld || _bldPos isEqualTo []) then {
    if (isNull _bld) then {
        _bld = [(getposATL _unit),100,false] call FUNC(getNearestBuilding);
    };
    _bldPos = _bld buildingPos -1;
};
if (isNull _bld) then {_error = true};
_unit setBehaviour _behaviour;
_unit setCombatMode _combat;
_unit setSpeedMode _speed;
_unit setFormation _formation;
_unit setvariable[QGVAR(Occupy),true];
_unit setvariable[QGVAR(OccupiedBuilding),_bld];
private _pos = _bldPos select (floor (random (count _bldPos)));
private _stopped = false;
while {alive _unit && !_error && ((getPosATL _unit) distance _pos) > 2 && (_unit getvariable[QGVAR(Occupy),true]) && !_stopped && (_unit getvariable[QGVAR(OccupiedBuilding),objNull]) isEqualTo _bld} do {
    _unit doMove _pos;
    sleep 5;
    if ((_unit getvariable[QGVAR(Occupy),true]) && !_stopped && (_unit getvariable[QGVAR(OccupiedBuilding),objNull]) isEqualTo _bld && ((getPosATL _unit) distance _pos) < 2) then {
        _stopped = true;
    };
};
doStop _unit;
_unit disableAI "Path";
private _group = (group _unit);
SETVAR(_group,InitialWPSet,true);
SETVAR(_group,Task,"BLDDEFEND");
[_group] call FUNC(taskForceSpeed);
true
