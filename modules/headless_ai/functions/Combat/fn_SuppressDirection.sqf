#include "script_component.hpp"

params [
    ["_unit", objNull, [objNull]], 
    ["_direction", 0, [0]], 
    ["_timeToSuppress", 3, [3]]
];

private _invisibleTarget = GETVAR(_unit,InvisibleTarget,objnull);
if (_invisibleTarget isEqualTo objnull) then {
    private _targetClass = "CBA_O_InvisibleTarget";
    private _side = side _unit;
    if ([_side, east] call BIS_fnc_sideIsEnemy) then {
        _targetClass = "CBA_O_InvisibleTarget";
    } else {
        if ([_side, west] call BIS_fnc_sideIsEnemy) then {
            _targetClass = "CBA_B_InvisibleTarget";
        } else {
            if ([_side, independent] call BIS_fnc_sideIsEnemy) then {
                _targetClass = "CBA_I_InvisibleTarget";
            };
        };
    };
    _invisibleTarget = _targetClass createVehicleLocal [0,0,0];
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

private _relpos = _unit getPos [40, _direction];
private _laserPos = [(_relpos) select 0, (_relpos) select 1, (((getposASL _unit)) select 2) + 1.5];
_invisibleTarget setposASL _laserPos;
_unit reveal [_invisibleTarget, 4];
_unit doWatch _laserPos;
_unit doTarget _invisibleTarget;
_unit doSuppressiveFire _laserPos;

[{
    params ["_argNested", "_idPFH"];
    _argNested params ["_unit", "_timeStart", "_timeToSuppress"];
    if (CBA_MissionTime >= _timeStart + _timeToSuppress) exitWith {
        private _invisibleTarget = GETVAR(_unit,InvisibleTarget,objNull);
        _invisibleTarget setPosASL [0,0,0];
        _unit doTarget objNull;
        _unit doWatch objNull;
        [_idPFH] call CBA_fnc_removePerFrameHandler;
    };
    private _otherFriendlies = (units group _unit) - [_unit];
    if (({
            !([getPosATL _unit, getDir _unit, 5, getPosATL _x] call BIS_fnc_inAngleSector)
        } forEach _otherFriendlies) && {_unit call FUNC(isAimed)}) then {
        [_unit] call FUNC(fireWeapon);
        [{
            params ["_unit"];
            [_unit] call FUNC(fireWeapon);
        }, [_unit], 0.15] call CBA_fnc_waitAndExecute;
    };
}, 0.25, [_unit, CBA_MissionTime, _timeToSuppress]] call CBA_fnc_addPerFrameHandler;



