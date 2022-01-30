#include "script_component.hpp"


//FUNC(CombatMoveTo)

params ["_group","_currenttarget","_enemydir"];

private _position = getposASL _currenttarget;
private _radius = 100;

if ((random 2) > 1) then {_group setformation "LINE";} else {_group setformation "WEDGE";};
_group setformdir _enemydir;

[_Group] call CBA_fnc_clearWaypoints;
SETVAR(_group,Task,"ATTACK");
[_group, _position, _radius, "SAD", "AWARE", "RED"] call CBA_fnc_addWaypoint;

//_NoFlanking = GETVAR(_Group,REINFORCE,false);
//if (_NoFlanking) then {
//	[_Group] call CBA_fnc_clearWaypoints;
//	SETVAR(_group,Task,"ATTACK");
//	[_group, _position, _radius, "SAD", "COMBAT", "RED"] call CBA_fnc_addWaypoint;
//} else {
//	SETVAR(_group,Task,"FLANK");
//	[_Group,false] spawn FUNC(FlankManeuver);
//};
