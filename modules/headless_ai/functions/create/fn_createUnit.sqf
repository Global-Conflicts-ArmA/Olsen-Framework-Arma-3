#include "script_component.hpp"

params [
    "_occupy",
    "_group",
    "_gpos",
    "_startBld",
    "_i",
    ["_unitArgs", [], [[]]]
];

_unitArgs params [
    ["_class", "", [""]],
    ["_pos", [], [[]]],
    ["_vectorDir", [], [[]]],
    ["_vectorUp", [], [[]]],
    ["_damage", 0, [0]],
    ["_gear", [], ["",[]]],
    ["_handcuffed", false, [false]],
    ["_stance", "AUTO", [""]],
    ["_init", false, [false, {}]],
    ["_identity", [], [[]]],
    ["_storedVars", [], [[]]],
    ["_varName", "", [""]]
];

private _placeMode = "CAN_COLLIDE";
if (_occupy || {_pos isEqualTo []}) then {
    _pos = _gpos;
    _placeMode = "NONE";
} else {
    if (_startBld) then {
        _pos = [_gpos,0,_i] call FUNC(getStartBuilding);
    };
};

private _unit = _group createUnit [_class, _pos, [], 0, _placeMode];
[_unit] joinSilent _group;
_unit disableAI "Path";
_unit setPosATL _pos;

if (_gear isEqualType "") then {
    [_unit, _gear] call EFUNC(FW,gearScript);
} else {
    _unit setUnitLoadout _gear;
};

if (_vectorDir isNotEqualTo []) then {
    private _VecDirUp = [_vectorDir,_vectorUp];
    _unit setVectorDirAndUp _VecDirUp;
    SETVAR(_unit,VecDirUp,_VecDirUp);
};
_unit setDamage _damage;
if (_handcuffed) then {
    [_unit,_handcuffed] call ACE_captives_fnc_setHandcuffed;
};

if (_varName isNotEqualTo "") then {
    private _uniqueName = [_varName] call FUNC(findUniqueName);
    missionNamespace setVariable [_uniqueName, _unit, true];
    SETVAR(_unit,customName,_uniqueName);
};

if (_storedVars isNotEqualTo []) then {
    _storedVars apply {
        _x params ["_varName", "_varValue"];
        _unit setvariable [_varName,_varValue];
    };
};
private _groupStance = GETVAR(group _unit,stance,"AUTO");
if (_stance != "AUTO" || {_groupStance != "AUTO"}) then {
    SETVAR(_unit,stance,_stance);
};
if (_identity isNotEqualTo []) then {
    SETVAR(_unit,identityArray,_identity);
};
if (_init isEqualType {}) then {
    SETVAR(_unit,Init,_init);
};
SETVAR(_unit,spawned,true);

_unit
