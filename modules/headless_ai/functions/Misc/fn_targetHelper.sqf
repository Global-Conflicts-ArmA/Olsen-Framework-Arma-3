#include "script_component.hpp"

params [
    ["_unit", objNull, [objNull]],
    ["_deleteMode", false, [false]]
];

private _return = false;

private _target = _unit getVariable [QGVAR(InvisibleTarget), objNull];
private _targetHelper = _unit getVariable [QGVAR(InvisibleTargetHelper), objNull];
private _targetCrew = _unit getVariable [QGVAR(InvisibleTargetCrew), grpNull];
if (_targetCrew isNotEqualTo grpNull) then {
    units _targetCrew apply {
        deleteVehicle _x;
    };
    deleteGroup _targetCrew;
};
[_target, _targetHelper] select {_x isNotEqualTo objNull} apply {
    deleteVehicle _x;
};

if (_deleteMode) then {
    _return = true;
} else {
    private _side = side _unit;
    private _targetClass = GVAR(sideEnemyTargets) getOrDefault [_side, ""];
    if (_targetClass isEqualTo "") then {
        if ([_side, east] call BIS_fnc_sideIsEnemy) then {
            GVAR(sideEnemyTargets) set [_side, "CBA_O_InvisibleTargetVehicle"];
            _targetClass = "CBA_O_InvisibleTargetVehicle";
        } else {
            if ([_side, west] call BIS_fnc_sideIsEnemy) then {
                GVAR(sideEnemyTargets) set [_side, "CBA_B_InvisibleTargetVehicle"];
                _targetClass = "CBA_B_InvisibleTargetVehicle";
            } else {
                if ([_side, independent] call BIS_fnc_sideIsEnemy) then {
                    GVAR(sideEnemyTargets) set [_side, "CBA_I_InvisibleTargetVehicle"];
                    _targetClass = "CBA_I_InvisibleTargetVehicle";
                };
            };
        };
    };
    private _invisibleTarget = _targetClass createVehicleLocal [0,0,0];
    private _targetCrew = createVehicleCrew _invisibleTarget;
    _invisibleTarget allowDamage false;
    private _invisibleTargetHelper = "Sign_Sphere100cm_F" createVehicleLocal [0,0,0];
    private _texture = ["", "#(rgb,8,8,3)color(1,0,0,1)"] select (GETMVAR(UseMarkers,false));
    _invisibleTargetHelper setobjecttexture [0, _texture];
    _invisibleTargetHelper attachTo [_invisibleTarget, [0,0,0]];
    SETVAR(_unit,InvisibleTarget,_invisibleTarget);
    SETVAR(_unit,InvisibleTargetCrew,_targetCrew);
    SETVAR(_unit,InvisibleTargetHelper,_invisibleTargetHelper);
    _return = _invisibleTarget;
};

_return
