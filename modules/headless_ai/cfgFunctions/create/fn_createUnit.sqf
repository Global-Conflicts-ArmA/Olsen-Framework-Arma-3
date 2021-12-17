#include "..\..\script_macros.hpp"


params [
    "_occupy",
    "_group",
    "_gpos",
    "_startBld",
    "_i",
    "_unitArgs",
    "_taskRadius"
];
_unitArgs params [
    "_uv",
    "_unitClass",
    "_unitPos",
    "_unitVectorDir",
    "_unitVectorUp",
    "_damage",
    "_editorGear",
    "_vehicleAssigned",
    "_vehArray",
    "_handcuffed",
    "_unitOnWater",
    "_unitIsPersistent",
    "_unitStance",
    "_unitInit",
    "_name",
    "_identity",
    "_storedVars",
    ["_varName", "", [""]],
    ["_olsenGearType", "", [""]]
];

_vehArray params [
    ["_veh", objNull, [objNull]],
    ["_vehType", "", [""]],
    ["_vehRole", [], [[]]]
];

if (_occupy) then {
    LOG_1("%1 set to occupy",_unitClass);
    _unitPos = _gpos;
} else {
    if (_startBld && {!_vehicleAssigned}) then {
        _unitPos = [_gpos,_taskRadius,_i] call FUNC(getStartBuilding);
    };
};
private _unit = _group createUnit [_unitClass,_unitPos,[],0,"CAN_COLLIDE"];
[_unit] join _group;
_unit disableAI "Path";
//_unit forcespeed 0;
_unit setPosATL _unitPos;
//LOG_2("_unit: %1 _unitPos: %2",_unit,_unitPos);
_unit setUnitLoadout _editorGear;
private _VecDirUp = [_unitVectorDir,_unitVectorUp];
_unit setVectorDirAndUp _VecDirUp;
SETVAR(_unit,VecDirUp,_VecDirUp);
_unit setDamage _damage;
if (_handcuffed) then {
    [_unit,_handcuffed] call ACE_captives_fnc_setHandcuffed;
};

if !(_varName isEqualTo "") then {
    private _uniqueName = [_varName] call FUNC(findUniqueName);
    missionNamespace setVariable [_uniqueName, _unit, true];
};

if !(_olsenGearType isEqualTo "") then {
    [_unit, _olsenGearType] call EFUNC(FW,gearScript);
};

[{
    params ["_unit", "_identity"];
    [[_unit, _identity], {
        params ["_unit", "_identity"];
        _identity params ["_unitName", "_face", "_speaker", "_nameSound", "_pitch"];
        if !(_unitName isEqualTo "") then {
            _unit setName _unitName;
        };
        if !(_face isEqualTo "") then {
            _unit setFace _face;
        };
        if !(_speaker isEqualTo "") then {
            _unit setSpeaker _speaker;
        };
        if !(_nameSound isEqualTo "") then {
            _unit setNameSound _nameSound;
        };
        if !(_pitch isEqualTo 0.99) then {
            _unit setPitch _pitch;
        };
    }] remoteExec ["BIS_fnc_call", 0, true];
}, [_unit, _identity]] call CBA_fnc_execNextFrame;

[_unit,_unitIsPersistent] call FUNC(setPersistent);
_unit call _unitInit;

if (_vehicleAssigned) then {
    if (isNull _veh) then {
        private _vehSearch = _unitPos nearEntities [_vehType, 5];
        if !(_vehSearch isEqualTo []) then {
            _veh = _vehSearch select 0;
        };
    };
    [_unit, _vehRole, _veh, _unitPos, _vehType] call FUNC(setAssignedVehicle);
};

if !(_storedVars isEqualTo []) then {
    {
        _x params ["_varName", "_varValue"];
        _unit setvariable [_varName,_varValue];
    } forEach _storedVars;
};

private _groupStance = GETVAR(_group,Stance,"Auto");

//["FW_eventSpawned", [_unit]] call CBA_fnc_serverEvent;

//[_unit, "Killed", {
//    _thisArgs params ["_unit"];
//    ["FW_eventKilled", _unit] call CBA_fnc_serverEvent;
//}, [_unit]] call CBA_fnc_addBISEventHandler;

[{!isNull (_this select 0)}, {
	params ["_unit", "_groupStance", "_unitStance"];
    [QGVAR(StanceChangeEvent), [_unit, _groupStance, _unitStance], _unit] call CBA_fnc_targetEvent;
}, [_unit, _groupStance, _unitStance]] call CBA_fnc_waitUntilAndExecute;

_unit
