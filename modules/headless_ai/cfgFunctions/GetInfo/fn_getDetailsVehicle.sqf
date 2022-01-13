#include "..\..\script_macros.hpp"

params [
    "_veh",
    ["_pos",[],[[]]]
];

private _vehInit = (GETVAR(_veh,Init,""));
if (_vehInit isEqualType "") then {
    if !(_vehInit isNotEqualTo "") then {
         _vehInit = compile _vehInit;
    } else {
         _vehInit = false;
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
private _fullCrew = fullCrew [_veh, "", false];
private _vehCrew = _fullCrew apply {
    _x params ["_u", "_role", "_cargoIndex", "_turretPath", "_personTurret"];
    _role = toLower _role;
    private _index = if (_role isEqualTo "cargo") then {
        _cargoIndex
    } else { _turretPath };
    private _roleInfo = [_role, _index];
    private _unitInfo = [_u] call FUNC(getDetailsUnit);
    [_roleInfo, _unitInfo]
};

[typeOf _veh,
_vehCrew,
_pos,
_vectorDir,
_vectorUp,
_damage,
_fuel,
magazinesAllTurrets _veh,
locked _veh,
_vehInit,
(GETVAR(_veh,Flying,false)),
(GETVAR(_veh,FlyInHeight,250)),
(GETVAR(_veh,StoredVars,[])),
_vehCustomization,
_name,
_olsenGearType]
