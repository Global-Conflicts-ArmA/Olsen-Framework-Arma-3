#include "..\..\script_macros.hpp"


//FUNC(CombatAttack)

params ["_group", "_targetPos", ["_forceAttack", false, [false]]];

private _enemydir = getposATL leader _group getDir _targetPos;
private _radius = 100;

private _formation = if ((random 2) > 1) then {"LINE"} else {"WEDGE"};
_group setformation _formation;
_group setformdir _enemydir;

if (_forceAttack) then {
	[_Group] call CBA_fnc_clearWaypoints;
	SETVAR(_group,Task,"ATTACK");
	[_group, _targetPos, _radius, "SAD", "COMBAT", "RED"] call CBA_fnc_addWaypoint;
} else {
	SETVAR(_group,Task,"FLANK");
	[_Group,false] spawn FUNC(FlankManeuver);
};
