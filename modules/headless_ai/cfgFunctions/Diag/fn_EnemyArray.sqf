#include "..\..\script_macros.hpp"

params ["_group", ["_forced", false, [false]]];

private _side = side _group;
private _sideEnemies = switch (_side) do {
    case west: {QGVAR(EnemyArray_West)};
    case east: {QGVAR(EnemyArray_East)};
    case independent: {QGVAR(EnemyArray_Ind)};
    case civilian: {QGVAR(EnemyArray_Civ)};
    default {QGVAR(EnemyArray_West)};
};
private _sideUpdateTime = switch (_side) do {
    case west: {QGVAR(enemyArrayUpdateTime_West)};
    case east: {QGVAR(enemyArrayUpdateTime_East)};
    case independent: {QGVAR(enemyArrayUpdateTime_Ind)};
    case civilian: {QGVAR(enemyArrayUpdateTime_Civ)};
    default {QGVAR(enemyArrayUpdateTime_West)};
};
private _enemyArray = GETMVAR(_sideEnemies,[]);
private _enemyUpdateTime = CBA_MissionTime - (GETMVAR(_sideUpdateTime,CBA_MissionTime - (GETMVAR(EnemyUpdateFrequency,5))));
if (_forced || {_enemyArray isEqualTo []} || {_enemyUpdateTime >= (GETMVAR(EnemyUpdateFrequency,5))}) then {
    private _unitSide = side _group;
    _enemyArray = ((allUnits + vehicles) - allCurators) select {
        !(_x isKindOf "TargetSoldierBase") &&
        !(_x isKindOf "HeadlessClient_F") &&
        {[_unitSide, (side _x)] call BIS_fnc_sideIsEnemy}
    };
    SETMVAR(_sideUpdateTime,CBA_MissionTime);
    SETMVAR(_sideEnemies,_enemyArray);
};

_enemyArray