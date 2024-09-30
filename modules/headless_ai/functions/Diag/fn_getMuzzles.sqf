#include "script_component.hpp"

params [
    ["_type", "", [""]]
];

if (isNil QGVAR(grenadeTypeNamespace)) then {
    GVAR(grenadeTypeNamespace) = createHashMap;
};

private _return = GVAR(grenadeTypeNamespace) getOrDefault [_type, []];
if (_return isEqualTo []) then {
    _return = [configFile >> "cfgWeapons" >> _type >> "muzzles", "array", []] call CBA_fnc_getConfigEntry;
    GVAR(grenadeTypeNamespace) set [_type, _return];
};

_return
