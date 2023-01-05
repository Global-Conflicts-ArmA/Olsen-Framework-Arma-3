#include "script_component.hpp"


params ["_unit", ["_randomSelect", false, [false]]];

private _group = group _unit;
private _enemyArray = [_group] call FUNC(EnemyArray);

if (_enemyArray isEqualTo []) exitwith {objnull};

private _distanceArray = _enemyArray select {
    [_x] call EFUNC(FW,isAlive)
} apply {
	private _enemyDistance = _unit distance2d _x;
	[_enemyDistance, _x]
};

_distanceArray sort true;

private _selectIndex = if (_randomSelect) then {
	random ((count _distanceArray) / 2)
} else {
	0
};

private _closestEnemy = ((_distanceArray select _selectIndex) select 1);

_closestEnemy
