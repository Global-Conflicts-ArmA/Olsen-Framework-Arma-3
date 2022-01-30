#include "script_component.hpp"

params ["_unit"];

private _stanceVar = GETVAR(_unit,stance,"");
private _originalStance = if (_stanceVar isEqualTo "") then {
    [stance _unit] call FUNC(getStance)
} else {
    _stanceVar
};

//LOG_2("stanceMachine set: %1 with originalStance: %2",_unit,_originalStance);

SETVAR(_unit,originalStance,_originalStance);
SETVAR(_unit,US_SetStance,false);
