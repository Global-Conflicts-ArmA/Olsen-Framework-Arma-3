#include "script_component.hpp"


//FUNC(CombatMode)

params ["_unit","_LastCStance"];

private _NearestEnemy = _unit call FUNC(ClosestEnemy);
if (isNil "_NearestEnemy") exitwith {};
if (_NearestEnemy isEqualTo [0,0,0]) exitwith {};

private _TimeShot = GETVAR(_unit,FiredTime,0);

if ((CBA_MissionTime - _TimeShot) > 120 && {((_NearestEnemy distance _unit) > 1000)}) then
{
	_unit setBehaviour (_LastCStance);
};
