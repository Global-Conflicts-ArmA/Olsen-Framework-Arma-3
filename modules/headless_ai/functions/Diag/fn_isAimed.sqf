#include "script_component.hpp"

params ["_unit", ["_offset", false, [false]]];

private _invisibleTarget = GETVAR(_unit,InvisibleTarget,objnull);

if (_invisibleTarget isEqualTo objnull) exitwith {
    if (GETMVAR(VerboseDebug,false)) then {
    	LOG_1("_unit: %1 cannot find invisible target",_unit);
    };
    false
};

private _isAimed = false;
private _vehicleUnit = vehicle _unit;

private _targetPos = if (_offset) then {
    private _heightAdjustMult = (GETMVAR(HeightAdjustMult,0.25));
    private _invisibleTargetPos = getposASL _invisibleTarget;
    private _adjustedHeight = (_invisibleTargetPos select 2) + ((_unit distance2D _invisibleTarget) * _heightAdjustMult);
    [_invisibleTargetPos select 0, _invisibleTargetPos select 1, _adjustedHeight]
} else {
    getposASL _invisibleTarget
};

private _vectorCosResult = ((_vehicleUnit weaponDirection (currentWeapon _vehicleUnit)) vectorCos (_targetPos vectorDiff (eyepos _unit)));
private _aimedAdjustResult = ((GETMVAR(AimedAdjust,0.999)) min ((GETMVAR(AimConeAdjust,0.975)) + ((GETMVAR(AimDistAdjust,0.00024)) * (_vehicleUnit distance _invisibleTarget))));
_isAimed = (
    _vectorCosResult >=
    _aimedAdjustResult
);
if (GETMVAR(VerboseDebug,false)) then {
    LOG_4("%1 aimCheck with vectorCos: %2 and aimedAdjust: %3 result: %4",_unit,_vectorCosResult,_aimedAdjustResult,_isAimed);
};

_isAimed
