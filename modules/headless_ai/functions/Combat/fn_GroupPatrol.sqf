#include "script_component.hpp"


//This script will dictate how the loiter WP works for the AI
params ["_unit","_Group","_wp","_thisFSM"];

_Unitleader = leader _unit;
_wpPos = waypointPosition [_group, _wp];

//mission var
SETVAR(_group,Task,"PATROL");

//CBA backup
//[_Unitleader, _wpPos, PZAI_PatrolDistance] call CBA_fnc_taskPatrol;

_usemarker = false;

if (isNil "PZAI_PatrolDistance") then {PZAI_PatrolDistance = 200;};
_radius = _Unitleader getvariable ["PatrolDistance",PZAI_PatrolDistance];
//if (!isNil (_Unitleader getvariable "AreaMarker")) then {
//	_areamarker = _Unitleader getvariable "AreaMarker";
//	if (!(getMarkerColor _areamarker == "")) then {
//		_usemarker = true;
//	};
//};

//clear waypoints
[_Group] call CBA_fnc_clearWaypoints;

_Group setBehaviour "SAFE";
_Group setCombatMode "YELLOW";

//!((behaviour _Unitleader) in ["AWARE","COMBAT","STEALTH"])
//Move to separate function?
//_randomposition = [_unit,_wpPos] call FUNC(getRandomPos);
private _count = 6;
private _step = 360 / _count;
private _offset = random _step;

for "_i" from 1 to _count do {
	//if (_usemarker) then {
	//	private _randompositiontemp = _areamarker call BIS_fnc_randomPosTrigger;
	//} else {
		private _rad = _radius * random [0.1, 0.75, 1];
		private _theta = (_i % 2) * 180 + sin (deg (_step * _i)) * _offset + _step * _i;
		private _randompositiontemp = _wpPos getPos [_rad, _theta];
	//};
	_randomposition = _randompositiontemp;
	//_randomposition = [_randompositiontemp, 1, 20, -1, 0, 35] call BIS_fnc_findSafePos;
	[_Group, _randomposition, 10, "MOVE", "UNCHANGED", "NO CHANGE", "FULL", "FILE", "", [3,6,9], 20] call CBA_fnc_addWaypoint;
};


[_Group, _wpPos, 10, "CYCLE", "UNCHANGED", "NO CHANGE", "FULL", "FILE", "", [3,6,9], 20] call CBA_fnc_addWaypoint;

[_Group,_Unitleader] spawn {
	params ["_Group","_Unitleader"];
	waituntil {((behaviour _Unitleader) in ["AWARE","COMBAT","STEALTH"])};
	[_Group] call FUNC(CombatResponse);
};
