#include "script_component.hpp"

params ["_unit"];

if (_unit getVariable [QGVAR(busy), false]) exitWith {false};

private _nearestEnemies = _unit getVariable [QGVAR(SA_nearestEnemies), []];
if (_nearestEnemies isEqualTo []) exitWith {false};
private _canSeeEnemy = _nearestEnemies findIf {
    [_unit, _x select 1, false, false] call FUNC(LOSCheck)
};

if (_canSeeEnemy isEqualTo -1) exitWith {
    //TRACE_1("sightAid targets can't see",_unit);
    _unit setVariable [QGVAR(SA_Target), objNull];
    false
};

private _target = (_nearestEnemies select _canSeeEnemy) select 1;
_unit setVariable [QGVAR(SA_Target), _target];
//TRACE_2("sightAid target chosen",_unit,_target);
true