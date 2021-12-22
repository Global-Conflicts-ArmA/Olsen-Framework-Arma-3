#include "..\..\script_macros.hpp"

params ["_group"];

private _leader = leader _group;
private _enemyInRange = false;
private _enemyArray = if (GETMVAR(CacheAllPlayers,true)) then {
	[] call BIS_fnc_listPlayers;
} else {
	_group call FUNC(EnemyArray);
};

if (_enemyArray isNotEqualTo []) then {
	_enemyInRange = !((_enemyArray select {((vehicle _leader) distance2d _x) <= (GETMVAR(CacheDisableDistance,3000))}) isEqualTo []);
};

SETVAR(_group,CH_enemyInRange,_enemyInRange);