#include "..\..\script_macros.hpp"


params [["_list",[],[[]]],["_object",objnull,[objnull]],["_randomSelect",false,[false]]];

if ("_object" isEqualTo objnull) exitWith {};
if ("_list" isEqualTo []) exitWith {};
	
private _DistanceArray = [];

{
	private _enemyUnit = _x;
	private _NewObjectDistance = _object distance2d _enemyUnit;
	_DistanceArray pushback [_NewObjectDistance,_enemyUnit];
} foreach _list;

_DistanceArray sort true;

private _selectIndex = if (_randomSelect) then {
	random ((count _DistanceArray) / 2)
} else {
	0
};

private _ClosestObject = ((_DistanceArray select _selectIndex) select 1);

if (isNil "_ClosestObject") exitWith {[0,0,0]};
_ClosestObject
