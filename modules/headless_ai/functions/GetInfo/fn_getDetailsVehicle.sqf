#include "script_component.hpp"

params [
    "_veh",
    ["_pos",[],[[]]]
];

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
private _fullCrew = fullCrew [_veh, "", false];
private _vehCrew = [];
private _cargoCrew = [];
private _cargoGroup = [];

 _fullCrew apply {
    _x params ["_u", "_role", "_cargoIndex", "_turretPath", "_personTurret"];
    _role = toLower _role;
    private _index = if (_role isEqualTo "cargo") then {
        _cargoIndex
    } else { _turretPath };
    private _roleInfo = [_role, _index];
    private _unitInfo = [_u] call FUNC(getDetailsUnit);
    private _group = group _u;
    private _isCargoGroup = GETVAR(_group,vehCargo,false);
    if (_isCargoGroup) then {
        if (leader _u isEqualTo _u) then {
            _cargoGroup = [_u, getPosATL _u] call FUNC(getDetailsGroup);
        };
         _cargoCrew pushBackUnique [_roleInfo, _unitInfo];
    } else {
        _vehCrew pushBackUnique [_roleInfo, _unitInfo];
    };
};

if (GETMVAR(VerboseDebug,false)) then {
    TRACE_3("",typeOf _veh,count _vehCrew, count _cargoCrew);
};

private _cargo = [_cargoGroup, _cargoCrew];

[typeOf _veh,
_vehCrew,
_cargo,
_pos,
_vectorDir,
_vectorUp,
_damage,
_fuel,
magazinesAllTurrets _veh,
locked _veh,
_init,
(GETVAR(_veh,Flying,false)),
(GETVAR(_veh,FlyInHeight,250)),
(GETVAR(_veh,StoredVars,[])),
_vehCustomization,
_name,
_olsenGearType]
