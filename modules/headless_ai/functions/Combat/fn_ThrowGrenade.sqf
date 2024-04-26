#include "script_component.hpp"

params [
    "_unit",
    ["_grenades", [], [[]]],
    ["_smoke", false, [false]]
];

TRACE_2("throwing frag at enemy!",_unit,_enemyTarget);
//private _dir = _unit getDir _enemyTarget;
//_unit setDir _dir;
SETVAR(_unit,busy,true);
[_unit, "HandGrenadeMuzzle"] call BIS_fnc_fire;
[{
    params ["_unit"];
    SETVAR(_unit,busy,false);
}, [
    _unit
], 2] call CBA_fnc_waitAndExecute;
//_unit forceWeaponFire ["HandGrenadeMuzzle","HandGrenadeMuzzle"];
//_unit forceWeaponFire ["MiniGrenadeMuzzle","MiniGrenadeMuzzle"];
