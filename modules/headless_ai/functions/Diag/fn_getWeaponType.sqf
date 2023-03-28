#include "script_component.hpp"


params [["_weapon", "", [""]]];
if (_weapon isEqualTo "") exitWith {false};

// create namespace to store cache
if (isNil QGVAR(weaponTypeNamespace)) then {
    GVAR(weaponTypeNamespace) = createHashMap;
};

// see if weapon is already cached in hashmap
private _return = GVAR(weaponTypeNamespace) getOrDefault [_weapon, -1];

if (_return isEqualTo -1) then {
    // otherwise generate info and store in hashmap
    private _type = (_weapon call BIS_fnc_itemtype) select 1;
    _return = switch _type do {
        case "MachineGun": {3};
        case "Launcher": {4};
        case "MissileLauncher": {4};
        case "RocketLauncher": {4};
        default {1};
    };
    GVAR(weaponTypeNamespace) set [_weapon, _return];
};

_return
