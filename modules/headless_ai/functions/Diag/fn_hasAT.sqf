#include "script_component.hpp"


params ["_unit"];

private _response = (((secondaryWeapon _unit) isNotEqualTo "") && {secondaryWeaponMagazine _unit isNotEqualTo []});

_response
