#include "..\..\script_macros.hpp"


params ["_unit"];

private _weapon = currentWeapon _unit;
private _muzzles = _weapon call CBA_fnc_getMuzzles;
if (count _muzzles < 2) exitWith {false};
private _muzzle = "";
{
    private _cfgPath = configFile >> "CfgWeapons" >> _weapon >> _x;
    if (getText(_cfgPath >> "cursorAim") == "gl") exitWith {_muzzle = _x}
} forEach _muzzles;
_muzzle
