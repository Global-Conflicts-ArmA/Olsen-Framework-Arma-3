#include "script_component.hpp"

params [["_side", blufor, [blufor]], ["_forced", false, [false]]];

private _sideEnemies = QGVAR(bluforEnemyArray);
private _enemySides = GVAR(bluforEnemies);
private _sideUpdateTime = QGVAR(bluforEnemyArrayUpdateTime);
switch (_side) do {
    case east: {
        _sideEnemies = QGVAR(opforEnemyArray);
        _enemySides = GVAR(opforEnemies);
        _sideUpdateTime = QGVAR(opforEnemyArrayUpdateTime);
    };
    case independent: {
        _sideEnemies = QGVAR(indforEnemyArray);
        _enemySides = GVAR(indforEnemies);
        _sideUpdateTime = QGVAR(indforEnemyArrayUpdateTime);
    };
    case civilian: {
        _sideEnemies = QGVAR(civforEnemyArrays);
        _enemySides = GVAR(bluforEnemies);
        _sideUpdateTime = QGVAR(civEnemyArrayUpdateTime);
    };
    default {
        _sideEnemies = QGVAR(bluforEnemyArray);
        _enemySides = GVAR(bluforEnemies);
        _sideUpdateTime = QGVAR(bluforEnemyArrayUpdateTime);
    };
};

private _enemyArray = missionNamespace getVariable [_sideEnemies, []];

if (
    _forced ||
    {_enemyArray isEqualTo []} ||
    {CBA_MissionTime >= (missionNamespace getVariable [_sideUpdateTime, CBA_MissionTime - 5]) + (GETMVAR(EnemyUpdateFrequency,5))}
) then {
    //_enemyArray = ((allUnits + vehicles) - allCurators) select {
    private _list = [];
    _enemySides apply {_list append units _x};
    _enemyArray = _list select {
        !isNull _x &&
        {[_x] call EFUNC(FW,isAlive)} &&
        {!(_x isKindOf "TargetSoldierBase")} &&
        {!(_x isKindOf "HeadlessClient_F")} &&
        {!(_x isKindOf "B_UAV_AI")} &&
        {!(_x isKindOf "O_UAV_AI")} &&
        {!(_x isKindOf "I_UAV_AI")}
    };
    missionNamespace setVariable [_sideUpdateTime, CBA_MissionTime];
    missionNamespace setVariable [_sideEnemies, _enemyArray];
};

_enemyArray
