#include "..\..\script_macros.hpp"

params ["_unit"];

_unit setCombatMode "RED";
_unit setBehaviour "COMBAT";

private _enemyInView = GETVAR(_unit,enemyInView,[]);
private _chosenTarget = selectRandom _enemyInView;
private _enemyDistance = ((vehicle _unit) distance2d _chosenTarget);

SETVAR(_unit,enemyTarget,_chosenTarget);
SETVAR(_unit,enemyDistance,_enemyDistance);

