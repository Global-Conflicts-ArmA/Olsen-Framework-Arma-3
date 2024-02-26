#include "script_component.hpp"

params ["_unit"];

private _suppressionFactor = GETVAR(_unit,suppressionFactor,0);
if (_suppressionFactor isEqualTo 0) exitwith {};
private _stance = stance _unit;
private _unitPos = unitPos _unit;
private _combatMode = combatMode _unit;
//TRACE_5("",_unit,_stance,_unitPos,_combatMode,_suppressionFactor);
switch (_stance) do {
    case "CROUCH": {
        //TRACE_2("case CROUCH",_unit);
        if (_suppressionFactor > 40) then {
            if (combatMode _unit isNotEqualTo "BLUE") then {
                _unit setCombatMode "BLUE";
                _unit doWatch objNull;
                [{
                    params ["_unit", "_combatMode"];
                    _unit setCombatMode _combatMode;
                }, [_unit, _combatMode], 2] call CBA_fnc_waitAndExecute;
            };
			_unit setUnitPos "DOWN";
			SETVAR(_unit,US_SetStance,true);
			//TRACE_3("Set to DOWN",_unit, _unitPos,_combatMode);
        };
    };
    case "STAND": {
        //TRACE_1("case STAND",_unit);
        if (_suppressionFactor > 20) then {
            if (_suppressionFactor > 40) then {
                if (combatMode _unit isNotEqualTo "BLUE") then {
                    _unit setCombatMode "BLUE";
                    _unit doWatch objNull;
                    [{
                        params ["_unit", "_combatMode"];
                        _unit setCombatMode _combatMode;
                    }, [_unit, _combatMode], 2] call CBA_fnc_waitAndExecute;
                };
                _unit setUnitPos "DOWN";
                SETVAR(_unit,US_SetStance,true);
                //TRACE_3("Set to DOWN",_unit, _unitPos,_combatMode);
            } else {
                _unit setUnitPos "MIDDLE";
                SETVAR(_unit,US_SetStance,true);
                //TRACE_3("Set to MIDDLE",_unit, _unitPos,_combatMode);
            };
        };
    };
    default {};
};

[{
	params ["_unit"];
	SETVAR(_unit,suppressionImmunity,true);
	[{
		params ["_unit"];
		SETVAR(_unit,suppressionImmunity,false);
	}, [_unit], 10] call CBA_fnc_waitAndExecute;
}, [_unit], 10] call CBA_fnc_waitAndExecute;
