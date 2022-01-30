#include "script_component.hpp"

params ["_unit"];

[_unit] call FUNC(fireWeapon);

SETVAR(_unit,LastFiredTime,CBA_MissionTime);
private _burstCount = (GETVAR(_unit,burstCount,0)) + 1;
SETVAR(_unit,burstCount,_burstCount);

private _enemyTarget = GETVAR(_unit,enemyTarget,objnull);

if (GETMVAR(VerboseDebug,false)) then {
    LOG_2("%1 Attempting to fire bunker mode at %2",_unit,_enemyTarget);
};

private _targetPos = getposASL _enemyTarget;
private _lastKnownTargetPos = [_targetPos select 0, _targetPos select 1,(_targetPos select 2) + (GVAR(AimTargetHeightAdjust))];

//private _delayTime = 1;

[{
    params ["_unit"];
    [_unit] call FUNC(fireWeapon);
    
    [{
        params ["_unit"];
        [_unit] call FUNC(fireWeapon);
        [{
            params ["_unit"];
            [_unit] call FUNC(fireWeapon);
        }, [_unit], 0.6] call CBA_fnc_waitAndExecute;
    }, [_unit], 0.6] call CBA_fnc_waitAndExecute;
}, [_unit], 0.6] call CBA_fnc_waitAndExecute;

SETVAR(_unit,lastKnownTargetPos,_lastKnownTargetPos);
