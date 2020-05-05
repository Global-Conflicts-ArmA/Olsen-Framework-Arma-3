#include "..\..\script_macros.hpp"

params ["_unit"];

private _enemyInRange = GETVAR(_unit,SA_enemyInRange,[]);
private _nearestEnemy = [_enemyInRange,(vehicle _unit),true] call FUNC(ClosestObject);
private _enemyCloseDistance = ((vehicle _unit) distance2d _nearestEnemy);
private _closeTargets = _enemyInRange select {(_unit distance2d _x) <= (_enemyCloseDistance * 1.2)};
private _chosenTarget = selectRandom _closeTargets;
private _enemyDistance = ((vehicle _unit) distance2d _chosenTarget);

SETVAR(_unit,SA_enemyTarget,_chosenTarget);
SETVAR(_unit,SA_enemyDistance,_enemyDistance);




