#include "script_component.hpp"

params ["_unit"];

private _nearestEnemies = [_unit, false, true] call FUNC(ClosestEnemy);
_unit setVariable [QGVAR(SA_nearestEnemies), _nearestEnemies];
if (_nearestEnemies isEqualTo []) exitWith {false};
private _enemyDistance = vehicle _unit distance2d (_nearestEnemies select 0 select 1);
private _return = _enemyDistance <= GETMVAR(SightAidDistance,800);
//TRACE_3("sightAid check distances",_unit,_enemyDistance,_return);

_return