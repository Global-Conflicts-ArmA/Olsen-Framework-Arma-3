#include "..\..\script_macros.hpp"
AI_EXEC_CHECK(SERVERHC);

//unit 1, unit 2
params ["_unit","_target",["_engageMode",false,[false]]];

private _return = true;
private _targetpos = position _target;

private _assignedtarget = assignedtarget _unit;
_unit reveal [_assignedtarget,0];
_unit dowatch objnull;
if (_engageMode) then {
    private _class = "O_TargetSoldier";
    private _side = side _unit;
    if ([_side, east] call BIS_fnc_sideIsEnemy) then {
        _class = "O_TargetSoldier";
    } else {
        if ([_side, west] call BIS_fnc_sideIsEnemy) then {
            _class = "B_TargetSoldier";
        } else {
            if ([_side, independent] call BIS_fnc_sideIsEnemy) then {
                _class = "I_TargetSoldier";
            }
        };
    };
    private _invisibleTarget = _class createVehicle [0,0,0];
    createVehicleCrew _invisibleTarget;
    _invisibleTarget allowdamage false;
    _invisibleTarget attachTo [_target, [0,0,5]];
    [{deletevehicle (_this select 0)}, [_invisibleTarget], 5] call CBA_fnc_waitAndExecute;
    _unit doWatch _invisibleTarget;
    _unit doTarget _invisibleTarget;
} else {
    _unit reveal [_target,4];
    _unit glanceat _targetpos;
    private _targetdir = (vehicle _unit) getdir _targetpos;
    if (vehicle _unit == _unit) then {
        _unit setformdir _targetdir;
    };
    _unit doWatch _targetpos;
    [{(_this select 0) doWatch (_this select 1)}, [_unit,_targetpos]] call CBA_fnc_execNextFrame;
};

_return
