#include "script_component.hpp"

params ["_unit"];

private _mags = [primaryWeapon _unit] call CBA_fnc_compatibleMagazines;
_mags apply {
    _unit removeMagazines _x
};
SETVAR(_unit,tempRemovedPrimaryMags,_mags);
