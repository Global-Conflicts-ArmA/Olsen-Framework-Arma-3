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
    ["_compRadius",0,[0]],
    ["_wpcount",10,[0]],
    "_i"
];

_group call CBA_fnc_clearWaypoints;
private _wp1pos = (_pos vectorAdd((vectorDir (leader _group)) vectorMultiply _radius));
private _this1 =+ _this;
_this1 set [1, _wp1pos];
_this1 call FUNC(createWaypoint);
_this call FUNC(createWaypoint);
private _this2 =+ _this;
_this2 set [8, "CYCLE"];
_this2 call FUNC(createWaypoint);

SETVAR(_group,Task,"SENTRY");
[_group] call FUNC(taskRelease);
