#include "script_component.hpp"


params ["_group"];
{
    private _unit = _x;
    private _items = _unit weaponAccessories primaryWeapon _unit;
    _unit removePrimaryWeaponItem (_items select 1);
    private _nvg = hmd _unit;
    if (count _nvg > 2) then {
        _unit unassignItem "NVGoggles";
        _unit removeItem "NVGoggles";
    };
    _unit addPrimaryWeaponItem "acc_flashlight";
    _unit enablegunlights "forceOn";
} forEach (units _group);
true
