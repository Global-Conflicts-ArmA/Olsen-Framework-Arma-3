#include "script_component.hpp"

params ["_unit", "_muzzle", ["_target", objNull, [[], objNull]]];

//[_unit, 3] call FUNC(tempRemovePrimaryMags);

private _invisibleTarget = [_unit] call FUNC(targetHelper);

SETVAR(_unit,busy,true);

//private _heightAdjustMult = (GETMVAR(HeightAdjustMult,0.25));
private _targetPos = [_target, 5] call CBA_fnc_randPos;
private _laserPos = ATLToASL [_targetPos select 0, _targetPos select 1, (_targetPos select 2) + 2];
_invisibleTarget setPosASL [_laserPos select 0, _laserPos select 1, (_laserPos select 2)];
_unit selectWeapon _muzzle;
_unit reveal [_invisibleTarget, 4];
_unit doTarget _invisibleTarget;

[{
    params ["_unit", "_muzzle", "_invisibleTarget"];
    (weaponState _unit select 1 isEqualTo _muzzle) &&
    [_unit] call FUNC(clearSight) &&
    {[_unit] call FUNC(isAimed)}
}, {
    params ["_unit", "_muzzle", "_invisibleTarget"];
    //[_unit, _muzzle] call BIS_fnc_fire;
    _unit forceWeaponFire [_muzzle, weaponState _unit select 2];
    //private _relDir = _unit getDir _invisibleTarget;
    [{
        params ["_unit"];
        [_unit, true] call FUNC(targetHelper);
        _unit setVariable [QGVAR(Busy), false];
    }, [
        _unit
    ], 1] call CBA_fnc_waitAndExecute;
}, [_unit, _muzzle, _invisibleTarget], 3, {
    private _unit = _this select 0;
    [_unit, true] call FUNC(targetHelper);
    _unit setVariable [QGVAR(Busy), false];
}] call CBA_fnc_waitUntilAndExecute;
