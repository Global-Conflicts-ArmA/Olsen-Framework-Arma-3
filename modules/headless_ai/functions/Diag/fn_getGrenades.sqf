#include "script_component.hpp"

params ["_unit"];

if (isNil QGVAR(grenadeTypeNamespace)) then {
    GVAR(grenadeTypeNamespace) = createHashMap;
};

private _fncIsGrenadeType = {
    params ["_type"];
    private _return = GVAR(grenadeTypeNamespace) getOrDefault [_type, -2];
    if (_return isEqualTo -2) then {
        if (
            _type call BIS_fnc_isThrowable &&
            {_type isKindOf ["HandGrenade", configFile >> "CfgMagazines"]}
        ) then {
            _return = [1,2] select (_type isKindOf ["SmokeShell", configFile >> "CfgMagazines"]);
        } else {
            _return = -1;
        };
        GVAR(grenadeTypeNamespace) set [_type, _return];
    };
    _return
};


private _smokes = [];
private _frags = [];
magazines _unit apply {
    private _gType = _x call _fncIsGrenadeType;
    if (_gType isNotEqualTo -1) then {
        if (_gType isEqualTo 2) then {
            _smokes pushBack _x;
        } else {
            _frags pushBack _x;
        };
    };
};

[_frags, _smokes]
