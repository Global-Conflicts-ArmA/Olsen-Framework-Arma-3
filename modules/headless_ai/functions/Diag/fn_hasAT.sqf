#include "script_component.hpp"


params ["_unit"];

private _response = (
    secondaryWeapon _unit isNotEqualTo "" &&
    {secondaryWeaponMagazine _unit isNotEqualTo []} &&
    {[secondaryWeapon _unit] call FUNC(getWeaponType) isEqualTo 4}
);

_response
