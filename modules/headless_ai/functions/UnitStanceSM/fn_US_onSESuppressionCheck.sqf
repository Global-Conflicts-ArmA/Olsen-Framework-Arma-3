#include "script_component.hpp"

params ["_unit"];

private _suppressionFactor = GETVAR(_unit,suppressionFactor,0);
if (_suppressionFactor isEqualTo 0) exitwith {};
private _stance = stance _unit;
//TRACE_3("",_unit,_stance,_assignedEnemy);
switch (_stance) do {
    case "CROUCH": {
        //TRACE_1("case CROUCH",_unit);
        if (_suppressionFactor > 40) then {
			_unit setUnitPos "DOWN";
			SETVAR(_unit,US_SetStance,true);
			//TRACE_1("Set to DOWN",_unit);
        };
    };
    case "STAND": {
        //TRACE_1("case STAND",_unit);
        if (_suppressionFactor > 20) then {
            if (_suppressionFactor > 40) then {
                _unit setUnitPos "DOWN";
                SETVAR(_unit,US_SetStance,true);
                //TRACE_1("Set to DOWN",_unit);
            } else {
                _unit setUnitPos "MIDDLE";
                SETVAR(_unit,US_SetStance,true);
                //TRACE_1("Set to MIDDLE",_unit);
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
