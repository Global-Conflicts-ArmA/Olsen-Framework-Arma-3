#include "..\..\script_macros.hpp"

params ["_unit"];

private _invisibleTarget = GETVAR(_unit,InvisibleTarget,objnull);

if (_invisibleTarget isEqualTo objnull) exitwith {
    if (GETMVAR(VerboseDebug,false)) then {
    	LOG_1("_unit: %1 cannot find invisible target",_unit);
    };
    false
};

private _vehicleUnit = vehicle _unit;
//private _isAimed = (
//    (((_vehicleUnit weaponDirection (currentWeapon _vehicleUnit)) vectorCos ((getposASL _invisibleTarget) vectorDiff (eyepos _unit))) > (0.999 min ((GETMVAR(AimConeAdjust,0.975)) + ((GETMVAR(AimDistAdjust,0.00024)) * (_vehicleUnit distance _invisibleTarget))))) && 
//    {((units _unit) isEqualTo []) || 
//    ({
//        !([getPosATL _vehicleUnit, getDir _vehicleUnit, 5, getPosATL _x] call BIS_fnc_inAngleSector)
//    } foreach (units _unit))}
//);

private _vectorCosResult = ((_vehicleUnit weaponDirection (currentWeapon _vehicleUnit)) vectorCos ((getposASL _invisibleTarget) vectorDiff (eyepos _unit)));
private _aimedAdjustResult = ((GETMVAR(AimedAdjust,0.999)) min ((GETMVAR(AimConeAdjust,0.975)) + ((GETMVAR(AimDistAdjust,0.00024)) * (_vehicleUnit distance _invisibleTarget))));

private _isAimed = (
    _vectorCosResult >=
    _aimedAdjustResult
);

if (GETMVAR(VerboseDebug,false)) then {
    LOG_4("%1 aimCheck with vectorCos: %2 and aimedAdjust: %3 result: %4",_unit,_vectorCosResult,_aimedAdjustResult,_isAimed);
};

_isAimed
