#include "script_component.hpp"

params [
    ["_unit", objnull, [objnull]]
];

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

_invisibleTarget
