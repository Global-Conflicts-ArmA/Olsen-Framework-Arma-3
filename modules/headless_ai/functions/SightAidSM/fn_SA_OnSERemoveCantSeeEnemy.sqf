#include "script_component.hpp"

params ["_unit"];

private _enemyTarget = GETVAR(_unit,SA_enemyTarget,objnull);
private _enemyInRange = GETVAR(_unit,SA_enemyInRange,[]);
if ((_enemyTarget isNotEqualTo objnull) && {(_enemyInRange isNotEqualTo [])} && {count _enemyInRange > 1}) then {
    _enemyInRange - [_enemyTarget];
    SETVAR(_unit,SA_enemyInRange,_enemyInRange);
    private _seeChecks = GETVAR(_unit,SA_seeChecks,0);
    SETVAR(_unit,SA_seeChecks,(_seeChecks + 1));
} else {
    SETVAR(_unit,SA_enemyInRange,[]);
};

