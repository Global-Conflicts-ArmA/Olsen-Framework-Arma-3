#include "script_component.hpp"

params ["_unit"];

private _stanceVar = GETVAR(_unit,stance,"");
// manual stance overrides this system
if (_stanceVar isNotEqualTo "") exitWith {};
private _originalStance = [stance _unit] call FUNC(getStance);

//LOG_2("stanceMachine set: %1 with originalStance: %2",_unit,_originalStance);

SETVAR(_unit,originalStance,_originalStance);
SETVAR(_unit,US_SetStance,false);
