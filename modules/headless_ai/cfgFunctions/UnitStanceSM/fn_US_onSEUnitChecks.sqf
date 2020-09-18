#include "..\..\script_macros.hpp"

params ["_unit"];

if (
    (stance _unit isEqualTo "PRONE")
    && {canStand _unit}
    && {!(GETVAR(_unit,reloading,false))}
    && {!([_unit, getDir _unit, 0.2] call FUNC(checkView))}
) then {
    _unit setUnitPos "MIDDLE";
};



