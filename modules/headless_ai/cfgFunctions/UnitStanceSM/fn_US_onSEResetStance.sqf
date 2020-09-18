#include "..\..\script_macros.hpp"

params ["_unit"];

private _originalStance = GETVAR(_unit,originalStance,"");
if ( 
    !(_originalStance isEqualTo "")
    && {!(GETVAR(_unit,reloading,false))}
    ) then {
    _unit setUnitPos _originalStance;
    SETVAR(_unit,US_SetStance,false);
};




