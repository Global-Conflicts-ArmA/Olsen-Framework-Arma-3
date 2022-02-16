#include "script_component.hpp"

params ["_unit"];

private _enemyInRange = GETVAR(_unit,enemyInRange,[]);
_enemyInRange resize (GETMVAR(BunkerEnemyLOSChecks,20));
private _enemyInView = _enemyInRange select {!(isNull _x) && {[_unit, _x] call FUNC(LOSCheck)}};

SETVAR(_unit,enemyInView,_enemyInView);





