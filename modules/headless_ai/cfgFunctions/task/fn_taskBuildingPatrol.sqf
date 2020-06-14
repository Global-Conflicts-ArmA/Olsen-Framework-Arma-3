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
_unit setvariable[QGVAR(OccupiedBuilding),_bld];
while {alive _unit && {!_error} && {(_unit getvariable[QGVAR(Occupy),true])} && {(_unit getvariable[QGVAR(OccupiedBuilding),objNull]) isEqualTo _bld}} do {
    private _pos = _bldPos select (floor (random (count _bldPos)));
    private _timer = 60;
    _unit doMove _pos;
    sleep 5;
    while {alive _unit && {_timer > 0} && {((getPosATL _unit) distance _pos) > 2} && {(_unit getvariable[QGVAR(Occupy),true])} && {(_unit getvariable[QGVAR(OccupiedBuilding),objNull]) isEqualTo _bld}} do {

        _timer = _timer - 1;
    };
    if (_unit getvariable [QGVAR(Occupy),true] && {(_unit getvariable[QGVAR(OccupiedBuilding),objNull]) isEqualTo _bld}) then {
        doStop _unit;
        private _wait = floor random [(_wpWait*0.5), _wpWait, (_wpWait*1.2)];
        sleep _wait;
    };
};
private _group = (group _unit);
SETVAR(_group,InitialWPSet,true);
SETVAR(_group,Task,"BLDPATROL");
[_group] call FUNC(taskRelease);
true
