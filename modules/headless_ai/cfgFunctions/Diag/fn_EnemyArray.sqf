#include "..\..\script_macros.hpp"

params ["_unit", ["_forced", false, [false]]];

private _enemyArray = GETVAR(_unit,enemyArray,[]);
private _updateDefaultTime = CBA_MissionTime - (GETMVAR(EnemyUpdateFrequency,5));
private _enemyUpdateTime = CBA_MissionTime - (GETVAR(_unit,enemyArrayUpdateTime,_updateDefaultTime));
if (_forced || _enemyArray isEqualTo [] || _enemyUpdateTime >= (GETMVAR(EnemyUpdateFrequency,5))) then {
    private _unitSide = side _unit;
    _enemyArray = ((allUnits + vehicles) - allCurators) select {
        !(_x isKindOf "TargetSoldierBase") &&
        !(_x isKindOf "HeadlessClient_F") &&
        {[_unitSide, (side _x)] call BIS_fnc_sideIsEnemy}
    };
    SETVAR(_unit,enemyArrayUpdateTime,CBA_MissionTime);
    SETVAR(_unit,enemyArray,_enemyArray);
};

_enemyArray