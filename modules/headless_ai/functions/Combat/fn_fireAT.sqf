#include "script_component.hpp"

params ["_unit", ["_target", objNull, [[], objNull]]];

//[_unit, 5] call FUNC(tempRemovePrimaryMags);

private _invisibleTarget = GETVAR(_unit,InvisibleTarget,objnull);
if (_invisibleTarget isEqualTo objnull) then {
    private _targetClass = "CBA_O_InvisibleTargetVehicle";
    private _side = side _unit;
    if ([_side, east] call BIS_fnc_sideIsEnemy) then {
        _targetClass = "CBA_O_InvisibleTargetVehicle";
    } else {
        if ([_side, west] call BIS_fnc_sideIsEnemy) then {
            _targetClass = "CBA_B_InvisibleTargetVehicle";
        } else {
            if ([_side, independent] call BIS_fnc_sideIsEnemy) then {
                _targetClass = "CBA_I_InvisibleTargetVehicle";
            };
        };
    };
    _invisibleTarget = _targetClass createVehicleLocal [0,0,0];
    createVehicleCrew _invisibleTarget;
    _invisibleTarget allowdamage false;
    private _invisibleTargetHelper = "Sign_Sphere100cm_F" createVehicleLocal [0,0,0];
    if (GETMVAR(UseMarkers,false)) then {
        _invisibleTargetHelper setobjecttexture [0,"#(rgb,8,8,3)color(1,0,0,1)"];
    } else {
        _invisibleTargetHelper setobjecttexture [0,""];
    };
    _invisibleTargetHelper attachTo [_invisibleTarget, [0,0,0]];
    SETVAR(_unit,InvisibleTarget,_invisibleTarget);
};

SETVAR(_unit,busy,true);

//private _heightAdjustMult = (GETMVAR(HeightAdjustMult,0.25));
private _targetPos = [_target, 5] call CBA_fnc_randPos;
private _laserPos = ATLToASL [_targetPos select 0, _targetPos select 1, (_targetPos select 2) - 1];
_invisibleTarget setPosASL [_laserPos select 0, _laserPos select 1, (_laserPos select 2) + 1];
_unit selectWeapon (secondaryWeapon _unit);
_unit reveal [_invisibleTarget, 4];
_unit doTarget _invisibleTarget;

[{
    private _unit = _this select 0;
    [_unit] call FUNC(clearSight) &&
    {[_unit, false] call FUNC(isAimed)} &&
    {currentWeapon _unit isEqualTo secondaryWeapon _unit}
}, {
    _this params ["_unit", "_invisibleTarget"];
    _unit forceWeaponFire [weaponState _unit select 1, weaponState _unit select 2];
    //private _relDir = _unit getDir _invisibleTarget;
    [{
        params ["_unit", "_invisibleTarget"];
        _unit reveal [_invisibleTarget, 0];
        _invisibleTarget setposASL [0,0,0];
        SETVAR(_unit,busy,false);
    }, [
        _unit,
        _invisibleTarget
    ], 5] call CBA_fnc_waitAndExecute;
    //TODO: move to optional param or put in existing functions that call this
    //[{
    //	_this params ["_unit", "_invisibleTarget", "_relDir"];
    //    _invisibleTarget setPosASL [0,0,0];
    //    _unit doTarget objNull;
    //    [_unit, _relDir, 2] call FUNC(SuppressDirection);
    //}, [_unit, _invisibleTarget, _relDir]] call CBA_fnc_execNextFrame;
}, [_unit, _invisibleTarget], 5, {
    _this params ["_unit", "_invisibleTarget"];
    _unit reveal [_invisibleTarget, 0];
    _invisibleTarget setposASL [0,0,0];
    SETVAR(_unit,busy,false);
}] call CBA_fnc_waitUntilAndExecute;
