#include "script_component.hpp"


params ["_unit"];

private _weapon = currentWeapon _unit;

// create namespace to store cache
if (isNil QGVAR(weaponMuzzleNamespace)) then {
    GVAR(weaponMuzzleNamespace) = createHashMap;
};

// see if weapon is already cached in hashmap
private _return = GVAR(weaponMuzzleNamespace) getOrDefault [_weapon, "NA"];
TRACE_2("r1",_unit,_return);

if (_return isEqualTo "NA") then {
    // otherwise generate info and store in hashmap
    private _muzzles = getArray (configFile >> "CfgWeapons" >> _weapon >> "muzzles");
    {
        if (_x == "this") then {
            _muzzles set [_forEachIndex, _weapon];
        };
    } forEach _muzzles;
    _return = if (count _muzzles < 2) then {
        ""
    } else {
        private _muzzle = "";
        {
            if (
                getText(configFile >> "CfgWeapons" >> _weapon >> _x >> "cursorAim") == "gl"
            ) exitWith {_muzzle = _x}
        } forEach _muzzles;
        _muzzle
    };
    GVAR(weaponMuzzleNamespace) set [_weapon, _return];
};

_return
