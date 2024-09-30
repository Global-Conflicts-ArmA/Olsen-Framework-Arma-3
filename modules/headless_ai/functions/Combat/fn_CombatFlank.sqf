#include "script_component.hpp"

params ["_Group", "_targetPos"];

private _enemyDir = leader _group getDir _targetPos;

[_Group] call CBA_fnc_clearWaypoints;
if ((random 2) > 1) then {_group setformation "LINE";} else {_group setformation "WEDGE";};
_group setformdir _enemydir;
SETVAR(_group,Task,"DEFEND");
