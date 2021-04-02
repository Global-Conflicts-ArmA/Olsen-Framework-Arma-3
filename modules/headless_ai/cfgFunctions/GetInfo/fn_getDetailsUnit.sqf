#include "..\..\script_macros.hpp"


params ["_unit", ["_pos",[],[[]]], "_vehicle"];
private _unitInit = GETVAR(_unit,Init,"");
if (typename _unitInit isEqualTo "STRING") then {_unitInit = compile _unitInit;};
private _vehAssigned = !((assignedVehicleRole _unit) isEqualTo []);
private _stance = if ((GETVAR(_unit,stance,"Auto")) isEqualTo "Auto") then {
    unitPos _unit
} else {
    GETVAR(_unit,stance,"Auto")
};
if (_pos isEqualTo []) then {
    _pos = (getposATL _unit) apply {parseNumber (_x toFixed 2)};
};
private _vectorDir = (vectorDir _unit) apply {parseNumber (_x toFixed 2)};
private _vectorUp = (vectorUp _unit) apply {parseNumber (_x toFixed 2)};
private _damage = parseNumber (damage _unit toFixed 2);
//private _pitch = parseNumber (pitch _unit toFixed 2);
private _identity = [
    name _unit,
    face _unit,
    speaker _unit,
    nameSound _unit,
    pitch _unit
];
private _name = GETVAR(_unit,varName,"");
private _olsenGearType = GETVAR(_unit,gearType,"");
private _vehArray = [
    _vehicle, 
    typeOf _vehicle,
    assignedVehicleRole _unit
];

[true,
typeOf _unit,
_pos,
_vectorDir,
_vectorUp,
_damage,
getUnitLoadout _unit,
_vehAssigned,
_vehArray,
_unit getVariable ["ACE_captives_isHandcuffed",false],
surfaceIsWater (getposATL _unit),
GETVAR(_unit,Persistent,true),
_stance,
_unitInit,
GETVAR(_unit,Name,""),
_identity,
GETVAR(_unit,storedVars,[]),
_name,
_olsenGearType]
