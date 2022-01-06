#include "..\..\script_macros.hpp"

params [
    "_unit",
    ["_pos",[],[[]]]
];

private _unitInit = GETVAR(_unit,Init,"");
if (_unitInit isEqualType "") then {
    if (_unitInit isNotEqualTo "") then {
        _unitInit = compile _unitInit;
    } else {
        _unitInit = false;
    };
};
private _stance = if ((GETVAR(_unit,stance,"Auto")) isEqualTo "Auto") then {
     unitPos _unit
} else {
     GETVAR(_unit,unitStance,"Auto")
};
if (_pos isEqualTo []) then {
     _pos = (getposATL _unit) apply {parseNumber (_x toFixed 2)};
};
private _vectorDir = (vectorDir _unit) apply {parseNumber (_x toFixed 2)};
private _vectorUp = (vectorUp _unit) apply {parseNumber (_x toFixed 2)};
private _damage = parseNumber (damage _unit toFixed 2);
private _identity = [
     name _unit,
     face _unit,
     speaker _unit,
     nameSound _unit,
     pitch _unit
];
private _name = GETVAR(_unit,varName,"");
private _gear = if (GETVAR(_unit,Gear,"") isEqualTo "") then {
    getUnitLoadout _unit;
} else {
    GETVAR(_unit,Gear,"")
};

[typeOf _unit,
_pos,
_vectorDir,
_vectorUp,
_damage,
_gear,
_unit getVariable ["ACE_captives_isHandcuffed",false],
_stance,
_unitInit,
_identity,
GETVAR(_unit,storedVars,[]),
_name]
