#include "script_component.hpp"

params [
    ["_group", grpNull, [grpNull]],
    ["_gpos", [0,0,0], [[]]],
    ["_vehArgs", [], [[]]],
    ["_initial", false, [false]]
];

_vehArgs params [
    ["_vehClass", "", [""]],
    ["_vehCrew", [], [[]]],
    ["_cargo", [], [[]]],
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

_cargo params [
    ["_groupInfo", [], [[]]],
    ["_cargoCrew", [], [[]]]
];

private _placeMode = "NONE";
if (GETMVAR(SaferVehSpawning,false)) then {
    private _safePos = [_gpos, 0, 60, ((sizeOf _vehClass) * 2.5) min 10, 0, 10, 0] call BIS_fnc_findSafePos;
    if (count _safePos isEqualTo 3 && {(_safePos select 2) isEqualTo 0}) exitWith {
        ERROR_2("Could not find safe position for: %1 group: %2",_vehClass,_group);
    };
    _pos = [_safePos select 0, _safePos select 1, 0];
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

if (_varName isNotEqualTo "") then {
    private _uniqueName = [_varName] call FUNC(findUniqueName);
    missionNamespace setVariable [_uniqueName, _vehicle, true];
};

if (_olsenGearType isNotEqualTo "") then {
    [_vehicle, _olsenGearType] call FUNC(VehGearScript);
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
if (_vehCustomization isNotEqualTo []) then {
    _vehCustomization params ["_vehCustomSkin", "_vehCustomAnimations"];
    [_vehicle, _vehCustomSkin, _vehCustomAnimations] call BIS_fnc_initVehicle;
};

if (_turretMags isNotEqualTo []) then {
    _turretMags apply {
        _x params [["_class", "", [""]], ["_path", [], [[]]], ["_ammo", 0, [0]]];
        _vehicle setMagazineTurretAmmo [_class,_ammo,_path];
    };
};

private _cargoGroup = grpNull;
if (_cargoCrew isNotEqualTo []) then {
    _groupInfo params [
        /* 0 */  ["_side", west, [west]],
        /* 1 */  ["_groupPos", [], [[]]],
        /* 2 */  ["_behaviour", "AWARE", [""]],
        /* 3 */  ["_combat", "YELLOW", [""]],
        /* 4 */  ["_speed", "normal", [""]],
        /* 5 */  ["_formation", "wedge", [""]],
        /* 6 */  ["_groupStance", "AUTO", [""]],
        /* 7 */  ["_groupInit", false, [false, {}, ""]],
        /* 8 */  ["_createRadius", 0, [0]],
        /* 9 */  ["_taskRadius", 30, [0]],
        /* 10 */ ["_taskWait", 3, [0]],
        /* 11 */ ["_startBuilding", false, [false]],
        /* 12 */ ["_task", "PATROL", [""]],
        /* 13 */ ["_taskTimer", 0, [0]],
        /* 14 */ ["_multi", 1, [1]],
        /* 15 */ ["_occupy", "Off", ["", 0]],
        /* 16 */ ["_vehAssigned", false, [false]],
        /* 17 */ ["_waypoints", [], [[]]],
        /* 18 */ ["_surfaceWater", false, [false]],
        /* 19 */ ["_fl", false, [false]],
        /* 20 */ ["_surrender", false, [false]],
        /* 21 */ ["_cargoStoredVars", [], [[]]],
        /* 22 */ ["_name", "", [""]],
        /* 23 */ ["_groupID", "", [""]],
        /* 24 */ ["_areaAssigned", "NONE", [""]],
        /* 25 */ ["_assetType", "INFANTRY", [""]]
    ];
    createCenter _side;
    _cargoGroup = createGroup _side;
    if (_name isNotEqualTo "") then {
        private _uniqueName = [_name] call FUNC(findUniqueName);
        missionNamespace setVariable [_uniqueName, _cargoGroup, true];
    };
    if (_groupID isNotEqualTo "") then {
        _cargoGroup setGroupIdGlobal [_groupID];
    };
    if (_cargoStoredVars isNotEqualTo []) then {
        _cargoStoredVars apply {
            _x params ["_varName", "_varValue"];
            _cargoGroup setvariable [_varName, _varValue];
        };
    };
};

if (_initial) then {
    {
        _x params ["_vehRole", "_userInfo"];
        private _unit = [false, _group, _gpos, false, _foreachIndex, _userInfo] call FUNC(createUnit);
        [{_this select 0 isNotEqualTo objNull}, {
            _this call FUNC(setAssignedVehicle);
        }, [_unit, _vehicle, _vehRole]] call CBA_fnc_waitUntilAndExecute;
    } forEach _vehCrew;
    if (_cargoCrew isNotEqualTo []) then {
        {
            _x params ["_vehRole", "_userInfo"];
            private _unit = [false, _cargoGroup, _gpos, false, _foreachIndex, _userInfo] call FUNC(createUnit);
            [{_this select 0 isNotEqualTo objNull}, {
                _this call FUNC(setAssignedVehicle);
            }, [_unit, _vehicle, _vehRole]] call CBA_fnc_waitUntilAndExecute;
        } forEach _cargoCrew;
        [_cargoGroup, _groupInfo] call FUNC(finishGroupSpawn);
    };
    [_vehicle, _init, _storedVars] call FUNC(finishVehicleSpawn);
} else {
    private _vehArray = [_group, _gpos, _vehicle, _vehCrew, _cargoGroup, _groupInfo, _cargoCrew, _init, _storedVars];
    TRACE_1("sending to spawn veh pfh",_vehArray);
    [FUNC(spawnUnitsVehiclePFH), 0.1, _vehArray] call CBA_fnc_addPerFrameHandler;
};

_vehicle
