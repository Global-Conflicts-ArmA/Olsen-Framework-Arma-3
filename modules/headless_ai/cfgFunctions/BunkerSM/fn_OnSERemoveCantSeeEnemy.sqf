#include "..\..\script_macros.hpp"

params ["_unit"];

private _enemyTarget = GETVAR(_unit,enemyTarget,_chosenTarget);
private _enemyInRange = GETVAR(_unit,enemyInRange,[]);
if (!(_enemyInRange isEqualTo []) && {count _enemyInRange > 1}) then {
    _enemyInRange - [_enemyTarget];
    SETVAR(_unit,enemyInRange,_enemyInRange);
    private _seeChecks = GETVAR(_unit,seeChecks,0);
    SETVAR(_unit,seeChecks,(_seeChecks + 1));
} else {
    SETVAR(_unit,enemyInRange,[]);
};

