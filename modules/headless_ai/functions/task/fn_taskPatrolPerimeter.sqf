#include "script_component.hpp"


params [
    "_group",
    "_pos",
    ["_radius",30,[0]],
    ["_wait",3,[0]],
    ["_behaviour","SAFE",[""]],
    ["_combat","RED",[""]],
    ["_speed","LIMITED",[""]],
    ["_formation","WEDGE",[""]],
    ["_Type","MOVE",[""]],
    ["_oncomplete",QUOTE(this call FUNC(taskSearchNearby)),[""]],
    ["_compradius",0,[0]],
    ["_wpcount",10,[0]],
    "_i"
];

_group call CBA_fnc_clearWaypoints;
_pos = [_pos,_group] select (_pos isEqualTo []);
_pos = _pos call CBA_fnc_getPos;
private _forwards = (vectorDir (leader _group)) vectorMultiply _radius;
private _sideways = [_forwards select 1, -(_forwards select 0), 0];
private _poswp1 = _pos vectorAdd _sideways;
private _poswp2 = _poswp1 vectorAdd _forwards;
private _poswp4 = _pos vectorAdd (_sideways vectormultiply -1);
private _poswp3 = _poswp4 vectorAdd _forwards;
{
    private _this1 =+ _this;
    _this1 set [1,_x];
    _this1 set [2,0];
    _this1 call FUNC(createWaypoint);
} foreach [_poswp1,_poswp2,_poswp3,_poswp4];
private _this2 =+ _this;
_this2 set [1,_poswp1];
_this2 set [2,0];
_this2 set [8, "CYCLE"];
_this2 call FUNC(createWaypoint);
deleteWaypoint ((waypoints _group) select 0);
SETVAR(_group,InitialWPSet,true);
_group setVariable [QGVAR(Mission),"PERIMPATROL"];
[_group] call FUNC(taskRelease);
true
