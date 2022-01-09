/*
 * Author: TinfoilHate
 * Adds up to the specified number of magazines to a unit or specific location.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Array of Magazine classes <ARRAY>
 * 2: Optional: Magazines to add <NUMBER>
 *
 * Return Value:
 * Nil
 *
 * Example:
 * [_unit, ["rhs_VOG25"], 12] call EFUNC(WEPHELP,addMagazineCargo);
 *
 * Public: Yes
*/

#include "script_component.hpp"

params ["_unit","_magazineBase",["_qty",1]];

private _magazineRandom = "";

if (_magazineBase isEqualType "STRING") then {
	_magazineBase = [_magazineBase];
};

if (isClass (configFile >> "CfgWeapons" >> (_magazineBase select 0))) then {
	_magazineBase = getArray (configFile >> "CfgWeapons" >> (_magazineBase select 0) >> "magazines");
};

_magazineRandom = selectRandom _magazineBase;
_unit addMagazineCargoGlobal [_magazineRandom, _qty];

[_unit,true]
