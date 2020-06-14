#include "..\..\script_macros.hpp"

params ["_group", ["_forced", false, [false]]];

private _enemyArray = GETVAR(_group,enemyArray,[]);
private _enemyUpdateTime = CBA_MissionTime - (GETVAR(_group,enemyArrayUpdateTime,CBA_MissionTime - (GETMVAR(EnemyUpdateFrequency,5))));
if (_forced || {_enemyArray isEqualTo []} || {_enemyUpdateTime >= (GETMVAR(EnemyUpdateFrequency,5))}) then {
    private _unitSide = side _group;
    _enemyArray = ((allUnits + vehicles) - allCurators) select {
        !(_x isKindOf "TargetSoldierBase") &&
        !(_x isKindOf "HeadlessClient_F") &&
        {[_unitSide, (side _x)] call BIS_fnc_sideIsEnemy}
    };
    SETVAR(_group,enemyArrayUpdateTime,CBA_MissionTime);
    SETVAR(_group,enemyArray,_enemyArray);
};

_enemyArray