#include "..\..\script_macros.hpp"

params [
    "_group",
    "_gpos",
    "_vehArgs",
    ["_taskRadius", 0, [0]]
];

_vehArgs params [
    ["_vehClass", "", [""]],
    ["_vehCrew", [], [[]]],
    ["_pos", [], [[]]],
    ["_vectorDir", [], [[]]],
    ["_vectorUp", [], [[]]],
    ["_damage", 0, [0]],
    ["_fuel", 100, [100]],
    ["_turretMags", [], [[]]],
    ["_locked", 0, [0]],
    ["_init", false, [false,{}]],
    ["_fly", false, [false]],
    ["_flyInHeight", 200, [200]],
    ["_storedVars", [], [[]]],
    ["_vehCustomization", [], [[]]],
    ["_varName", "", [""]],
    ["_olsenGearType", "", [""]]
];

private _placeMode = "NONE";
if (_pos isEqualTo []) then {
    _pos = [_gpos, 1, 150, 3, 0, 20, 0] call BIS_fnc_findSafePos;
};
if (_fly) then {
    if (_vehClass isKindOf "Air") then {
        _placeMode = "FLY";
        if (_pos select 2 < _flyInHeight) then {
            _pos = [_pos select 0, _pos select 1, _flyInHeight];
        };
        //_pos = ([_pos select 0, _pos select 1, _flyInHeight] vectorAdd [0,0,150]);
    };
} else {
    if (_pos select 2 > 100 && {_vehClass isKindOf "Air"}) then {
        _placeMode = "FLY";
        _flyInHeight = _pos select 2;
    };
};

private _vehicle = createVehicle [_vehClass, _pos, [], 0, _placeMode];
_vehicle setVectorDirAndUp [_vectorDir,_vectorUp];
_vehicle setPosATL _pos;

{
    _x params ["_vehRole", "_userInfo"];
    _vehRole params ["_role", "_index"];
    private _unit = [false, _group, _gpos, false, _foreachIndex, _userInfo, _taskRadius] call FUNC(createUnit);
    [_unit, _vehicle, _role, _index] call FUNC(setAssignedVehicle);
} forEach _vehCrew;

if !(_varName isEqualTo "") then {
    private _uniqueName = [_varName] call FUNC(findUniqueName);
    missionNamespace setVariable [_uniqueName, _vehicle, true];
};

if !(_olsenGearType isEqualTo "") then {
    [_vehicle, _olsenGearType] call FUNC(VehicleGearScript);
};

if (_fly) then {
    _vehicle flyInHeight _flyInHeight;
    _vehicle setVelocity [
        (velocity _vehicle select 0) + (sin (getDir _vehicle) * 80),
        (velocity _vehicle select 1) + (cos (getDir _vehicle) * 80),
        velocity _vehicle select 2
    ];
};

_vehicle setDamage _damage;
_vehicle setFuel _fuel;
_vehicle lock _locked;
_vehCustomization params ["_vehCustomSkin", "_vehCustomAnimations"];
[_vehicle, _vehCustomSkin, _vehCustomAnimations] call BIS_fnc_initVehicle;

if !(_turretMags isEqualTo []) then {
    _turretMags apply {
        _x params [["_class", "", [""]], ["_path", [], [[]]], ["_ammo", 0, [0]]];
        _vehicle setMagazineTurretAmmo [_class,_ammo,_path];
    };
};

if (_init isEqualType {}) then {
    //SETVAR(_vehicle,Init,_init);
    _vehicle call _init;
};

if !(_storedVars isEqualTo []) then {
    //LOG_1("Setting vars: %1",_storedVars);
    _storedVars apply {
        _x params ["_varName", "_varValue"];
        _vehicle setvariable [_varName,_varValue];
        //LOG_2("Setting _varName: %1 with: %2",_varName,_varValue);
    };
};

_vehicle
