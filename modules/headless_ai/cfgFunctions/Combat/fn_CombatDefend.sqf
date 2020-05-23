#include "..\..\script_macros.hpp"


//FUNC(CombatDefend)

params ["_group", ["_currenttarget", objnull, [objnull]]];

if (_currenttarget isEqualTo objnull) then {_currenttarget = [leader _group] call FUNC(ClosestEnemy)};
private _enemydir = leader _group getdir _currenttarget;
[_group] call CBA_fnc_clearWaypoints;
private _formation = if ((random 2) > 1) then {"LINE"} else {"WEDGE"};
_group setformation _formation;
_group setformdir _enemydir;
SETVAR(_group,Task,"DEFEND");
