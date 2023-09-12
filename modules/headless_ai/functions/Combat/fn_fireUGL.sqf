#include "script_component.hpp"

params ["_unit", "_muzzle", ["_target", objNull, [[], objNull]]];

_unit call FUNC(tempRemovePrimaryMags);

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
    private _unit = _this select 0;
    ({
        !([getPosATL _unit, getDir _unit, 5, getPosATL _x] call BIS_fnc_inAngleSector)
    } forEach ((units group _unit) - [_unit]))
    && {[_unit, false] call FUNC(isAimed)}
}, {
    _this params ["_unit", "_muzzle", "_invisibleTarget"];
    [_unit, _muzzle] call BIS_fnc_fire;
    private _relDir = _unit getDir _invisibleTarget;
    [{
        params ["_unit", "_invisibleTarget"];
        _unit reveal [_invisibleTarget, 0];
        _invisibleTarget setposASL [0,0,0];
        SETVAR(_unit,busy,false);
    }, [
        _unit,
        _invisibleTarget
    ], 3] call CBA_fnc_waitAndExecute;
    //TODO: move to optional param or put in existing functions that call this
    //[{
    //	_this params ["_unit", "_invisibleTarget", "_relDir"];
    //    _invisibleTarget setPosASL [0,0,0];
    //    _unit doTarget objNull;
    //    [_unit, _relDir, 2] call FUNC(SuppressDirection);
    //}, [_unit, _invisibleTarget, _relDir]] call CBA_fnc_execNextFrame;
}, [_unit, _muzzle, _invisibleTarget], 3, {
    _this params ["_unit", "", "_invisibleTarget"];
    _unit reveal [_invisibleTarget, 0];
    _invisibleTarget setposASL [0,0,0];
    SETVAR(_unit,busy,false);
}] call CBA_fnc_waitUntilAndExecute;
