#include "..\..\script_macros.hpp"


//FUNC(CombatMode)

params ["_unit","_LastCStance"];

private _NearestEnemy = _Unit call FUNC(ClosestEnemy);
if (isNil "_NearestEnemy") exitwith {};
if (_NearestEnemy isEqualTo [0,0,0]) exitwith {};

private _TimeShot = GETVAR(_Unit,FiredTime,0);

if ((CBA_MissionTime - _TimeShot) > 120 && {((_NearestEnemy distance _Unit) > 1000)}) then
{
	_Unit setBehaviour (_LastCStance);
};
