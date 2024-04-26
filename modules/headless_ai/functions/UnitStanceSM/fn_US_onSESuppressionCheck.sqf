#include "script_component.hpp"

params ["_unit"];

private _suppressionFactor = getSuppression(_unit);
if (_suppressionFactor isEqualTo 0) exitwith {};
private _stance = stance _unit;
//TRACE_5("",_unit,_stance,_suppressionFactor);
switch (_stance) do {
    case "CROUCH": {
        //TRACE_2("case CROUCH",_unit);
        if (_suppressionFactor > GVAR(stanceFeatureSuppressionThreshold) * 2) then {
			_unit setUnitPos "DOWN";
			SETVAR(_unit,US_SetStance,true);
			//TRACE_3("Set to DOWN",_unit);
        };
    };
    case "STAND": {
        //TRACE_1("case STAND",_unit);
        if (_suppressionFactor > GVAR(stanceFeatureSuppressionThreshold)) then {
            _unit setUnitPos "MIDDLE";
            SETVAR(_unit,US_SetStance,true);
            //TRACE_3("Set to MIDDLE",_unit);
        };
    };
    default {};
};

if (GVAR(stanceFeatureSuppressionResistance) > 0) then {
    [{
        params ["_unit"];
        SETVAR(_unit,suppressionImmunity,true);
        [{
            params ["_unit"];
            SETVAR(_unit,suppressionImmunity,false);
        }, [_unit], GVAR(stanceFeatureSuppressionResistance)] call CBA_fnc_waitAndExecute;
    }, [_unit], GVAR(stanceFeatureSuppressionDuration)] call CBA_fnc_waitAndExecute;
};
