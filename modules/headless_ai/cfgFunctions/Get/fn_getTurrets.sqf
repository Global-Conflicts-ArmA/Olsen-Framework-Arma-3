#include "..\..\script_macros.hpp"


params ["_veh"];

private _arr = [];
private _trts = (configFile >> "CfgVehicles" >> (typeOf _veh) >> "Turrets");
for "_i" from 0 to (count _trts - 1) do {
    _arr set [count _arr, [_i]];
    for "_j" from 0 to (count (_trts >> (configName (_trts select _i)) >> "Turrets") - 1) do {
        _arr set [count _arr, [_i, _j]];
    };
};
_arr
