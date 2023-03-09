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
    ["_oncomplete","",[""]],
    ["_compradius",0,[0]],
    ["_wpcount",10,[0]]
];

_group setBehaviour _behaviour;
_group setCombatMode _combat;
_group setSpeedMode _speed;
_group setFormation _formation;
private _units = units _group;
_units apply {
    _x doWatch ((getPosATL _x) vectorAdd((vectorDir _x) vectorMultiply 100));
    _x disableAI "PATH";
    SETVAR(_x,stationary,true);
};

SETVAR(_group,Task,"STATIONARY");
