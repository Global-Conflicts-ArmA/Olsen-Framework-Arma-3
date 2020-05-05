#include "..\..\script_macros.hpp"

params ["_unit"];

if (leader _unit == _unit) then {
	SETVAR(group _unit,CurrentTarget,_enemyTarget);
};
SETVAR(_unit,TargetSet,true);
SETVAR(_unit,LastFiredTime,CBA_MissionTime);

private _enemyTarget = GETVAR(_unit,enemyTarget,objnull);

if (GETMVAR(VerboseDebug,false)) then {
    LOG_2("%1 Targeted %2 in bunker mode",_unit,_enemyTarget);
};

[_unit, true, _enemyTarget] call FUNC(WatchEnemy);
[{
	_this call FUNC(WatchEnemy);
}, [_unit, true, _enemyTarget]] call CBA_fnc_execNextFrame;

