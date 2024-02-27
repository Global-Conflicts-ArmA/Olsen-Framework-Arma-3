#include "script_component.hpp"

params ["_unit"];

private _suppressionFactor = getSuppression(_unit);
if (_suppressionFactor isEqualTo 0) exitwith {};
private _stance = stance _unit;
private _unitPos = unitPos _unit;
private _combatMode = combatMode _unit;
//TRACE_5("",_unit,_stance,_unitPos,_combatMode,_suppressionFactor);
switch (_stance) do {
    case "CROUCH": {
        //TRACE_2("case CROUCH",_unit);
        if (_suppressionFactor > 0.7) then {
			_unit setUnitPos "DOWN";
			SETVAR(_unit,US_SetStance,true);
			//TRACE_3("Set to DOWN",_unit, _unitPos,_combatMode);
        };
    };
    case "STAND": {
        //TRACE_1("case STAND",_unit);
        if (_suppressionFactor > 0.35) then {
            if (_suppressionFactor > 0.7) then {
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
	}, [_unit], 3] call CBA_fnc_waitAndExecute;
}, [_unit], 5] call CBA_fnc_waitAndExecute;
