#include "..\..\script_macros.hpp"


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
    ["_wpcount",10,[0]]
];

_group call CBA_fnc_clearWaypoints;
_group setBehaviour _behaviour;
_group setCombatMode _combat;
_group setSpeedMode _speed;
_group setFormation _formation;
private _units = units _group;
for "_i" from 0 to (count _units) do {
    private _u = _units select _i;
    _u doWatch ((getPosATL _u) vectorAdd((vectorDir _u) vectorMultiply 100));
    doStop _u;
};
SETVAR(_Group,InitialWPSet,true);
_group setVariable [QGVAR(Mission),"HOLD"];
[_group] call FUNC(taskForceSpeed);
true
