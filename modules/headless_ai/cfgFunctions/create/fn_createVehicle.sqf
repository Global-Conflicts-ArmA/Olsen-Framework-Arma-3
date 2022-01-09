#include "..\..\script_macros.hpp"


params [
    "_pos",
    "_vehArgs",
    "_side"
];
_vehArgs params [
    "_uv",
    "_vehClass",
    "_vehpos",
    "_vectorDir",
    "_vectorUp",
    "_damage",
    "_fuel",
    "_turretMags",
    "_locked",
    "_vehInWater",
    "_vehName",
    "_persistent",
    "_vehInit",
    "_fly",
    "_flyInHeight",
    "_storedVars",
    ["_vehCustomization", [], [[]]],
    "_name",
    ["_olsenGearType", "", [""]]
];

if (GETMVAR(Debug,false)) then {
    LOG_1("_vehArgs: %1",_vehArgs);
};

private _flying = "NONE";
if (_fly) then {
    if (_vehClass isKindOf "Air") then {
        _flying = "FLY";
        if (_pos select 2 < _flyInHeight) then {
            _pos = [_pos select 0, _pos select 1, _flyInHeight];
        };
        //_pos = ([_pos select 0, _pos select 1, _flyInHeight] vectorAdd [0,0,150]);
    };
} else {
    if ((_pos select 2) > 100 && {(_vehClass isKindOf "Air")}) then {
        _flying = "FLY";
        _flyInHeight = (_pos select 2);
    };
};
private _vehicle = createVehicle [_vehClass, _pos, [], 0, _flying];
_vehicle setVectorDirAndUp [_vectorDir,_vectorUp];
_vehicle setPosATL _pos;

if (_name isNotEqualTo "") then {
    private _uniqueName = [_name] call FUNC(findUniqueName);
    missionNamespace setVariable [_uniqueName, _vehicle, true];
};

if (_olsenGearType isNotEqualTo "") then {
    [_vehicle, _olsenGearType] call EFUNC(FW,VehGearScript);
};

if (_fly) then {
    _vehicle flyInHeight _flyInHeight;
    _vehicle setVelocity [((velocity _vehicle) select 0) + (sin (getDir _vehicle) * 80),((velocity _vehicle) select 1) + (cos (getDir _vehicle) * 80),((velocity _vehicle) select 2)];
};
_vehicle setDamage _damage;
_vehicle setFuel _fuel;
_vehicle lock _locked;
_vehCustomization params ["_vehCustomSkin", "_vehCustomAnimations"];
[_vehicle, _vehCustomSkin, _vehCustomAnimations] call BIS_fnc_initVehicle;
{
    _x params [["_class", "", [""]], ["_path", [], [[]]], ["_ammo", 0, [0]]];
    _vehicle setMagazineTurretAmmo [_class,_ammo,_path];
} forEach _turretMags;

[_vehicle,_persistent] call FUNC(setPersistent);
_vehicle call _vehInit;
if (_storedVars isNotEqualTo []) then {
    //LOG_1("Setting vars: %1",_storedVars);
    {
        _x params ["_varName", "_varValue"];
        _vehicle setvariable [_varName,_varValue];
        //LOG_2("Setting _varName: %1 with: %2",_varName,_varValue);
    } forEach _storedVars;
};

_vehicle
