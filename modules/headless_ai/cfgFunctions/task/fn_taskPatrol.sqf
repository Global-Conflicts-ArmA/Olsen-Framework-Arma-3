#include "..\..\script_macros.hpp"

params [
    "_group",
    "_pos",
    ["_radius",30,[0]],
    ["_wait",3,[0]],
    ["_behaviour", "UNCHANGED", [""]],
    ["_combat", "NO CHANGE", [""]],
    ["_speed", "UNCHANGED", [""]],
    ["_formation", "NO CHANGE", [""]],
    ["_Type","MOVE",[""]],
    ["_oncomplete",QUOTE(this call FUNC(taskSearchNearby)),[""]],
    ["_compradius",0,[0]],
    ["_wpcount",10,[0]]
];

if (_radius < 30) then {
    ERROR_1("taskPatrol _group: %1 radius too small! Setting to default 30m",_group);
    _radius = 30;
};

LOG_1("taskPatrol started _this: %1",_this);
_group = _group call CBA_fnc_getGroup;
if !(local _group) exitWith {}; // Don't create waypoints on each machine

//_group call CBA_fnc_clearWaypoints;
//CBA backup
private _timeout = [(_wait*0.5),_wait,(_wait*1.5)];
//[_group, _pos] call CBA_fnc_taskPatrol;
//[_group, _pos, _radius, _wpcount, _Type, _behaviour, _combat, _speed, _formation, _oncomplete, _timeout] call CBA_fnc_taskPatrol;

//_pos = [_pos,_group] select (_pos isEqualTo []);
//_pos = _pos call CBA_fnc_getPos;
//for [{_i=0},{(_i < _wpcount)},{_i = _i + 1}] do {
//    _wp = _this call FUNC(createWaypoint);
//};
//_this2 =+ _this;
//_this2 set [(count _this2), "CYCLE"];
//_this2 call FUNC(createWaypoint);
//deleteWaypoint ((waypoints _group) select 0);

_pos = [_pos, _group] select (_pos isEqualTo []);
_pos = _pos call CBA_fnc_getPos;

// Clear existing waypoints first
[_group] call CBA_fnc_clearWaypoints;

// Using angles create better patrol patterns
// Also fixes weird editor bug where all WP are on same position
private _step = 360 / _wpcount;
private _offset = random _step;
for "_i" from 1 to _wpcount do {
    // Gaussian distribution avoids all waypoints ending up in the center
    private _rad = _radius * random [0.1, 0.75, 1];

    // Alternate sides of circle & modulate offset
    private _theta = (_i % 2) * 180 + sin (deg (_step * _i)) * _offset + _step * _i;

    private _wppos = _pos getPos [_rad, _theta];
    [_group,_wppos,_radius,_Type,_behaviour, _combat, _speed, _formation, _oncomplete, _timeout] call CBA_fnc_addWaypoint;
};

// Close the patrol loop
[_group,_pos,_radius,"CYCLE",_behaviour, _combat, _speed, _formation, _oncomplete, _timeout] call CBA_fnc_addWaypoint;

SETVAR(_group,InitialWPSet,true);
SETVAR(_group,Task,"PATROL");
[_group] call FUNC(taskForceSpeed);
true
