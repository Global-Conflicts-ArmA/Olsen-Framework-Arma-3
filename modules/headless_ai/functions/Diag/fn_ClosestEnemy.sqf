#include "script_component.hpp"


params [
    ["_unit", objNull, [objNull]],
    ["_randomSelect", false, [false]]
];

if (_unit isEqualTo objNull) exitwith {objNull};

private _enemyArray = [side _unit] call FUNC(EnemyArray);
if (_enemyArray isEqualTo []) exitwith {objNull};

private _distanceArray = _enemyArray select {
    !isNull _x &&
    {[_x] call EFUNC(FW,isAlive)}
} apply {
	private _enemyDistance = _unit distance2d _x;
	[_enemyDistance, _x]
};

_distanceArray sort true;

private _selectIndex = if (_randomSelect) then {
	floor random (count _distanceArray / 2)
} else {
	0
};

private _closestEnemy = ((_distanceArray select _selectIndex) select 1);

_closestEnemy
