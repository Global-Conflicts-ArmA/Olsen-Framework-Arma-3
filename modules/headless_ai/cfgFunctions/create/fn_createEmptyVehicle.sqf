#include "..\..\script_macros.hpp"

params [
    ["_vehClass", "", [""]],
    ["_pos", [], [[]]],
    ["_vectorDir", [], [[]]],
    ["_vectorUp", [], [[]]],
    ["_damage", 0, [0]],
    ["_fuel", 100, [100]],
    ["_turretMags", [], [[]]],
    ["_locked", 0, [0]],
    ["_surfaceIsWater", false, [false]],
    ["_init", false, [false,{}]],
    ["_storedVars", [], [[]]],
    ["_vehCustomization", [], [[]]],
    ["_varName", "", [""]],
    ["_olsenGearType", "", [""]]
];

private _vehicle = createVehicle [_vehClass,_pos,[],0,"CAN_COLLIDE"];
_vehicle setVectorDirAndUp [_vectorDir, _vectorUp];
_vehicle setPosATL _pos;

if (_varName isNotEqualTo "") then {
    private _uniqueName = [_varName] call FUNC(findUniqueName);
    missionNamespace setVariable [_uniqueName, _vehicle, true];
};

if (_olsenGearType isNotEqualTo "") then {
    [_vehicle, _olsenGearType] call EFUNC(FW,VehGearScript);
};

_vehicle setDamage _damage;
_vehicle setFuel _fuel;
_turretMags apply {
    _x params [["_class","",[""]],["_path",[],[[]]],["_ammo",0,[0]]];
    _vehicle setMagazineTurretAmmo [_class,_ammo,_path];
};
_vehicle lock _locked;
_vehCustomization params ["_vehCustomSkin", "_vehCustomAnimations"];
[_vehicle, _vehCustomSkin, _vehCustomAnimations] call BIS_fnc_initVehicle;

if (_init isEqualType {}) then {
     //SETVAR(_vehicle,Init,_init);
     _vehicle call _init;
 };

if (_storedVars isNotEqualTo []) then {
    //LOG_1("Setting vars: %1",_storedVars);
    _storedVars apply {
        _x params ["_varName", "_varValue"];
        _vehicle setvariable [_varName,_varValue];
        //LOG_2("Setting _varName: %1 with: %2",_varName,_varValue);
    };
};

_vehicle
