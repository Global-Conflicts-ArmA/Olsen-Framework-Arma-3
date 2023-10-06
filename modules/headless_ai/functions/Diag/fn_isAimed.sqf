#include "script_component.hpp"

params ["_unit", ["_offset", false, [false]]];

private _invisibleTarget = GETVAR(_unit,InvisibleTarget,objNull);

if (_invisibleTarget isEqualTo objNull) exitwith {
    if (GETMVAR(VerboseDebug,false)) then {
    	LOG_1("_unit: %1 cannot find invisible target",_unit);
    };
    false
};

private _isAimed = false;
private _vehicleUnit = vehicle _unit;

private _targetPos = if (_offset) then {
    private _heightAdjustMult = GETVAR(_unit,HeightAdjustMult,(GETMVAR(HeightAdjustMult,0.25)));
    private _invisibleTargetPos = getposASL _invisibleTarget;
    private _adjustedHeight = (_invisibleTargetPos select 2) + ((_unit distance2D _invisibleTarget) * _heightAdjustMult);
    [_invisibleTargetPos select 0, _invisibleTargetPos select 1, _adjustedHeight]
} else {
    getposASL _invisibleTarget
};

private _AimedAdjust = GETVAR(_unit,AimedAdjust,(GETMVAR(AimedAdjust,0.999)));
private _AimConeAdjust = GETVAR(_unit,AimConeAdjust,(GETMVAR(AimConeAdjust,0.975)));
private _AimDistAdjust = GETVAR(_unit,AimDistAdjust,(GETMVAR(AimDistAdjust,0.00024)));
private _vectorCosResult = ((_vehicleUnit weaponDirection (currentWeapon _vehicleUnit)) vectorCos (_targetPos vectorDiff (eyepos _unit)));
private _aimedAdjustResult = (_AimedAdjust min (_AimConeAdjust + (_AimDistAdjust * (_vehicleUnit distance _invisibleTarget))));
_isAimed = (
    _vectorCosResult >=
    _aimedAdjustResult
);
if (GETMVAR(VerboseDebug,false)) then {
    LOG_4("%1 aimCheck with vectorCos: %2 and aimedAdjust: %3 result: %4",_unit,_vectorCosResult,_aimedAdjustResult,_isAimed);
};

_isAimed
