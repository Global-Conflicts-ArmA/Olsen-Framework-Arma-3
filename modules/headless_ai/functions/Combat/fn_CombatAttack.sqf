#include "script_component.hpp"

params ["_group", "_targetPos"];

private _enemyDir = getposATL leader _group getDir _targetPos;
private _radius = 100;

//private _formation = if ((random 2) > 1) then {"LINE"} else {"WEDGE"};
//_group setFormation _formation;
//_group setFormDir _enemyDir;

[_group] call CBA_fnc_clearWaypoints;
SETVAR(_group,Task,"ATTACK");
[_group, _targetPos, _radius, "SAD", "COMBAT", "RED"] call CBA_fnc_addWaypoint;
