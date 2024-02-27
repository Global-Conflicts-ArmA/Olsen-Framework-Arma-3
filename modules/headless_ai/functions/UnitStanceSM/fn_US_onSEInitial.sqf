#include "script_component.hpp"

params ["_unit"];

private _stance = GETVAR(_unit,stance,"");
private _stanceGroup = GETVAR(group _unit,stance,"");
// manual stance overrides this system
if (_stance isNotEqualTo "" || {_stanceGroup isNotEqualTo ""}) exitWith {};
private _originalStance = [stance _unit] call FUNC(getStance);

//LOG_2("stanceMachine set: %1 with originalStance: %2", _unit,_originalStance);

SETVAR(_unit,originalStance,_originalStance);
SETVAR(_unit,US_SetStance,false);
