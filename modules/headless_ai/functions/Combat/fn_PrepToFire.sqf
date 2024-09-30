#include "script_component.hpp"

params [
    ["_unit", objNull, [objNull]],
    ["_target", objNull, [objNull, []]],
    ["_timer", 3, [3]]
];

if (_unit isEqualTo objNull || _target isEqualTo objNull || _target isEqualTo [0, 0, 0]) exitWith {
    ERROR_1("Error in PrepToFire function",_this);
};
if (_timer < 3) then {
    ERROR_1("PrepToFire timer to small, setting to minimum 3s",_this);
    _timer = 3;
};

private _invisibleTarget = [_unit] call FUNC(targetHelper);
//private _oldTarget = getAttackTarget _unit;
private _getposTarget = getposASL _target;
private _targetPos = [_getposTarget select 0, _getposTarget select 1,(_getposTarget select 2) + (GVAR(AimTargetHeightAdjust))];
_invisibleTarget setPosASL _targetPos;
_unit lookAt _invisibleTarget;
_unit doWatch _invisibleTarget;
_unit doTarget _invisibleTarget;
_unit reveal [_invisibleTarget, 4];
_unit setVariable [QGVAR(Busy), true];

private _startTime = CBA_MissionTime;

[{
    params ["_argNested", "_idPFH"];
    _argNested params [
        ["_timeStart", 0, [0]],
        ["_timer", 2, [2]],
        ["_unit", objNull, [objNull]],
        ["_target", objNull, [objNull]],
        ["_invisibleTarget", objNull, [objNull]]
    ];
    if (
        CBA_MissionTime > _timeStart + _timer || 
        _unit getVariable [QGVAR(Busy), false] ||
        _unit isEqualTo objNull ||
        _target isEqualTo objNull ||
        !([_unit] call EFUNC(FW,isAlive)) ||
        !([_target] call EFUNC(FW,isAlive)) 
    ) exitWith {
        [_unit, true] call FUNC(targetHelper);
        _unit setVariable [QGVAR(Busy), false];
        [_idPFH] call CBA_fnc_removePerFrameHandler;
    };
    if (
        (INVEHICLE(_unit) && {(vehicle _unit aimedAtTarget [_invisibleTarget] > 0.1)}) ||
        (!(INVEHICLE(_unit)) && {[_unit] call FUNC(isAimed)})
    ) then {
        [_unit] call FUNC(fireWeapon)
    } else {
        private _getposTarget = getposASL _target;
        private _targetPos = [_getposTarget select 0, _getposTarget select 1,(_getposTarget select 2) + (GVAR(AimTargetHeightAdjust))];
        _invisibleTarget setPosASL _targetPos;
    };
}, 0.15, [
    _startTime,
    _timer,
    _unit,
    _target,
    _invisibleTarget
]] call CBA_fnc_addPerFrameHandler;



    				
