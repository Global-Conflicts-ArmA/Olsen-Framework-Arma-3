#include "script_component.hpp"

params [["_group", grpNull, [grpNull]]];

private _currentTarget = GETVAR(_group,CurrentTarget,objNull);
if (_currentTarget isEqualTo objNull) then {
    _currentTarget =  [leader _group] call FUNC(closestEnemy);
};
private _enemydir = leader _group getdir _currentTarget;
[_group] call CBA_fnc_clearWaypoints;
private _formation = if (RNG(0.5)) then {"LINE"} else {"WEDGE"};
_group setformation _formation;
_group setformdir _enemydir;
