#include "..\..\script_macros.hpp"


params ["_unit",["_randomSelect",true,[true]]];

private _UnitSide = (side _unit);
private _enemyArray = allUnits select {
	!(_x isKindOf "TargetSoldierBase") && 
	{[_UnitSide, (side _x)] call BIS_fnc_sideIsEnemy}
};

private _distanceArray = [];

{
	private _enemyUnit = _x;
	private _enemyDistance = _unit distance2d _enemyUnit;
	_distanceArray pushback [_enemyDistance,_enemyUnit];
} foreach _enemyArray;

_distanceArray sort true;

private _selectIndex = if (_randomSelect) then {
	random ((count _distanceArray) / 2)
} else {
	0
};

private _ClosestEnemy = ((_distanceArray select _selectIndex) select 1);

_ClosestEnemy
