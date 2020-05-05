#include "..\..\script_macros.hpp"

params ["_unit"];

private _targets = _unit targets [true];
if (_targets isEqualTo []) exitwith {};
private _assignedEnemy = _targets select 0;
private _stance = stance _unit;
private _enemyDir = _unit getDir _assignedEnemy;
TRACE_3("",_unit,_stance,_assignedEnemy);
switch (_stance) do {
    case "PRONE": {
        TRACE_1("case PRONE",_unit);
        if !([_unit, _enemyDir, 0.2, _assignedEnemy] call FUNC(checkView)) then {
            if ([_unit, _enemyDir, 1, _assignedEnemy] call FUNC(checkView)) then {
                _unit setUnitPos "MIDDLE";
                SETVAR(_unit,US_SetStance,true);
                TRACE_1("Set to MIDDLE",_unit);
            } else {
                if ([_unit, _enemyDir, 1.7, _assignedEnemy] call FUNC(checkView)) then {
                    _unit setUnitPos "UP";
                    SETVAR(_unit,US_SetStance,true);
                    TRACE_1("Set to UP",_unit);
                };
            };
        };
    };
    case "CROUCH": {
        TRACE_1("case CROUCH",_unit);
        if !([_unit, _enemyDir, 1, _assignedEnemy] call FUNC(checkView)) then {
            if ([_unit, _enemyDir, 1.7, _assignedEnemy] call FUNC(checkView)) then {
                _unit setUnitPos "UP";
                SETVAR(_unit,US_SetStance,true);
                TRACE_1("Set to UP",_unit);
            };
        };
    };
    case "STAND": {
        TRACE_1("case STAND",_unit);
        if ([_unit, _enemyDir, 1, _assignedEnemy] call FUNC(checkView)) then {
            if ([_unit, _enemyDir, 0.2, _assignedEnemy] call FUNC(checkView)) then {
                _unit setUnitPos "DOWN";
                SETVAR(_unit,US_SetStance,true);
                TRACE_1("Set to DOWN",_unit);
            } else {
                _unit setUnitPos "MIDDLE";
                SETVAR(_unit,US_SetStance,true);
                TRACE_1("Set to MIDDLE",_unit);
            };
        };
    };
    default {};
};
