#include "..\..\script_macros.hpp"

//unit 1, unit 2
params [
    ["_unit", objnull, [objnull]],
    ["_engageMode", false, [false]],
    ["_target", objnull, [objnull]]
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

private _getposTarget = getposASL _target;
_unit doWatch objnull;
_unit doTarget objnull;

if (_engageMode) then {
    if (GETMVAR(VerboseDebug,false)) then {
    	LOG_2("_unit: %1 targeting: %2 in normal mode",_unit,_target);
    };
    private _targetPos = [_getposTarget select 0, _getposTarget select 1,(_getposTarget select 2) + (GVAR(AimTargetHeightAdjust))];
    private _laserTarget = GETVAR(_unit,laserTarget,objnull);
    _laserTarget setposASL _getposTarget;
    _invisibleTarget setposASL _targetPos;
    _unit reveal [_invisibleTarget,4];
    _unit doWatch _targetPos;
    _unit doTarget _invisibleTarget;
} else {
    if (GETMVAR(VerboseDebug,false)) then {
    	LOG_1("_unit: %1 targeting laserTarget",_unit);
    };
    _unit reveal [_target, 4];
    _unit doWatch _getposTarget;
    _unit doTarget _target;
    _unit reveal [_invisibleTarget, 0];
    _invisibleTarget setposASL [0,0,0];
};

true
