#include "..\..\script_macros.hpp"

params ["_unit"];

private _enemyInRange = GETVAR(_unit,enemyInRange,[]);
//private _nearestEnemy = [_enemyInRange,(vehicle _unit),true] call FUNC(ClosestObject);
//private _enemyCloseDistance = ((vehicle _unit) distance2d _nearestEnemy);
//private _closeTargets = _enemyInRange select {(_unit distance2d _x) <= (_enemyCloseDistance * 1.2)};
//private _chosenTarget = objnull;

_enemyInRange resize (GETMVAR(BunkerEnemyLOSChecks,20));
private _enemyInView = _enemyInRange select {!(isNull _x) && {[_unit, _x] call FUNC(LOSCheck)}};
//_enemyInRange = _enemyInRange select {[_unit, _x] call FUNC(LOSCheck)} apply {[_x distance _unit, _x]};

SETVAR(_unit,enemyInView,_enemyInView);





