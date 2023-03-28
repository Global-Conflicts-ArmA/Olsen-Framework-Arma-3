#include "script_component.hpp"


params [
    ["_mag", "", [""]]
];

// create namespace to store cache
if (isNil QGVAR(UGLRoundHashMap)) then {
    GVAR(UGLRoundHashMap) = createHashMap;
};

// see if mag is already cached in hashmap
private _return = GVAR(UGLRoundHashMap) getOrDefault [_mag, -1];

if (_return isEqualTo -1) then {
    // otherwise generate info and store in hashmap
    // shot = 1
    // smoke = 2
    // flare = 3
    private _ammo = getText (configfile >> "CfgMagazines" >> _mag >> "Ammo");
    private _sim = getText (configfile >> "CfgAmmo" >> _ammo >> "simulation");
    _return = switch _sim do {
        case "shotSmoke": {
            2
        };
        case "shotIlluminating": {
            3
        };
        default {
            1
        };
    };
    GVAR(UGLRoundHashMap) set [_mag, _return];
};

_return
