#include "..\..\script_macros.hpp"

params ["_veh",["_pos",[],[[]]]];

private _init = (GETVAR(_veh,Init,""));
if (_init isEqualType "") then {
    if (_init isNotEqualTo "") then {
         _init = compile _init;
    } else {
         _init = false;
    };
};
if (_pos isEqualTo []) then {
    _pos = (getposATL _veh) apply {parseNumber (_x toFixed 2)};
};
private _vectorDir = (vectorDir _veh) apply {parseNumber (_x toFixed 2)};
private _vectorUp = (vectorUp _veh) apply {parseNumber (_x toFixed 2)};
private _damage = parseNumber (damage _veh toFixed 2);
private _fuel = parseNumber (fuel _veh toFixed 2);
private _vehCustomization = _veh call BIS_fnc_getVehicleCustomization;
private _name = GETVAR(_veh,varName,"");
private _olsenGearType = GETVAR(_veh,gearType,"");

[typeOf _veh,
_pos,
_vectorDir,
_vectorUp,
_damage,
_fuel,
magazinesAllTurrets _veh,
locked _veh,
surfaceIsWater (getposATL _veh),
_init,
(GETVAR(_veh,StoredVars,[])),
_vehCustomization,
_name,
_olsenGearType]
