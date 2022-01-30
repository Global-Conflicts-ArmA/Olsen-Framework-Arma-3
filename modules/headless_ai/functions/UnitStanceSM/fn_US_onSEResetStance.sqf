#include "script_component.hpp"

params ["_unit"];

private _originalStance = GETVAR(_unit,originalStance,"");
if (
    (_originalStance isNotEqualTo "")
    && {!(GETVAR(_unit,reloading,false))}
    ) then {
    _unit setUnitPos _originalStance;
    SETVAR(_unit,US_SetStance,false);
};
