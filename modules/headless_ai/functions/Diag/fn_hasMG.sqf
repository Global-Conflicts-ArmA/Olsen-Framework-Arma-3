#include "script_component.hpp"


params ["_unit"];

private _weapon = primaryweapon _unit;
if (_weapon isEqualTo "") exitWith {false};

private _isMG = ([_weapon] call FUNC(getWeaponType)) isEqualTo 3;

_isMG
