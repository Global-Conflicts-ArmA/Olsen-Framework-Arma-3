#include "..\..\script_macros.hpp"

params ["_unit"];

private _stanceVar = GETVAR(_unit,stance,"");
private _originalStance = if (_stanceVar isEqualTo "") then {
    [stance _unit] call FUNC(getStance)
} else {
    _stanceVar
};

SETVAR(_unit,originalStance,_originalStance);
SETVAR(_unit,US_SetStance,false);

