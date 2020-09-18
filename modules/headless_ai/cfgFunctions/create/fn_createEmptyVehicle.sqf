#include "..\..\script_macros.hpp"


params [
    "_vehClass",
    "_vehPos",
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
    "_storedVars",
    ["_vehCustomization", [], [[]]],
    "_name",
    ["_olsenGearType", "", [""]]
];

private _vehicle = createVehicle [_vehClass,_vehPos,[],0,"CAN_COLLIDE"];
_vehicle setVectorDirAndUp [_vectorDir, _vectorUp];
_vehicle setPosATL _vehPos;

if !(_name isEqualTo "") then {
    private _uniqueName = [_name] call FUNC(findUniqueName);
    missionNamespace setVariable [_uniqueName, _vehicle, true];
};

if !(_olsenGearType isEqualTo "") then {
    [_vehicle, _olsenGearType] call FUNC(VehicleGearScript);
};

_vehicle setDamage _damage;
_vehicle setFuel _fuel;
{
    _x params [["_class",
"",[""]],["_path",[],[[]]],["_ammo",0,[0]]];
    _vehicle setMagazineTurretAmmo [_class,_ammo,_path];
} forEach _turretMags;
_vehicle lock _locked;
_vehCustomization params ["_vehCustomSkin", "_vehCustomAnimations"];
[_vehicle, _vehCustomSkin, _vehCustomAnimations] call BIS_fnc_initVehicle;
[_vehicle,_persistent] call FUNC(setPersistent);
_vehicle call _vehInit;
if !(_storedVars isEqualTo []) then {
    //LOG_1("Setting vars: %1",_storedVars);
    {
        _x params ["_varName", "_varValue"];
        _vehicle setvariable [_varName,_varValue];
        //LOG_2("Setting _varName: %1 with: %2",_varName,_varValue);
    } forEach _storedVars;
};

_vehicle
