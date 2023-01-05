#include "script_component.hpp"

params ["_unit"];

private _frags = [];
private _smokes = [];

magazines _unit select {
    _x call BIS_fnc_isThrowable &&
    {_x isKindOf ["HandGrenade", configFile >> "CfgMagazines"]}
} apply {
    if (_x isKindOf ["SmokeShell", configFile >> "CfgMagazines"]) then {
        _smokes pushBack _x
    } else {
        _frags pushBack _x
    };
};

[_frags, _smokes]
