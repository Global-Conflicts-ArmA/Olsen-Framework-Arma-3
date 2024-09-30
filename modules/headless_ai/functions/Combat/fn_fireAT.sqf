#include "script_component.hpp"

params ["_unit", ["_target", objNull, [[], objNull]]];

//[_unit, 5] call FUNC(tempRemovePrimaryMags);

private _invisibleTarget = [_unit] call FUNC(targetHelper);

SETVAR(_unit,busy,true);

//private _heightAdjustMult = (GETMVAR(HeightAdjustMult,0.25));
private _targetPos = [_target, 5] call CBA_fnc_randPos;
private _laserPos = ATLToASL [_targetPos select 0, _targetPos select 1, (_targetPos select 2)];
_invisibleTarget setPosASL [_laserPos select 0, _laserPos select 1, (_laserPos select 2)];
_unit selectWeapon (secondaryWeapon _unit);
_unit reveal [_invisibleTarget, 4];
_unit doTarget _invisibleTarget;

[{
    private _unit = _this select 0;
    (currentWeapon _unit isEqualTo secondaryWeapon _unit) &&
    {[_unit] call FUNC(clearSight)} &&
    {[_unit] call FUNC(isAimed)}
}, {
    _this params ["_unit", "_invisibleTarget"];
    _unit forceWeaponFire [weaponState _unit select 1, weaponState _unit select 2];
    [{
        params ["_unit"];
        [_unit, true] call FUNC(targetHelper);
        _unit setVariable [QGVAR(Busy), false];
    }, [
        _unit
    ], 1] call CBA_fnc_waitAndExecute;
}, [_unit, _invisibleTarget], 5, {
    _this params ["_unit", "_invisibleTarget"];
    [_unit, true] call FUNC(targetHelper);
    _unit setVariable [QGVAR(Busy), false];
}] call CBA_fnc_waitUntilAndExecute;
