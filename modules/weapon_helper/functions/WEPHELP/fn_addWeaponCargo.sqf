/*
 * Author: TinfoilHate
 * Adds a random weapon and appropriate random magazines from an array, either to the unit in general or a specific container on the unit.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Array of Weapon/Magazine/Accessory classes <ARRAY>
 * 2: Optional: Magazines to add <NUMBER>
 *
 * Return Value:
 * Nil
 *
 * Example:
 * [_unit, ["rhs_weap_akm", "rhs_30Rnd_762x39mm", "rhs_weap_ak74n", "rhs_30Rnd_545x39_AK"], 8, "vest"] call EFUNC(WEPHELP,addWeaponCargo);
 *
 * Public: Yes
*/

#include "script_component.hpp"

params ["_unit", "_inputArray", ["_qty",1]];

private _accBase = [];
private _weaponBase = [];
private _magazinesBase = [];
private _item = objNull;

// Sorting input array
_inputArray apply {
	_item = toLower(_x);

	if (([(configFile >> "CfgWeapons" >> _item),true] call BIS_fnc_returnParents) findIf {_x == "ItemCore"} != -1) then {
		_accBase pushBack _item;
	} else {
		if (isClass (configFile >> "CfgWeapons" >> _item) && {!(_accBase findIf {_x == _item} != -1)}) then {
			_weaponBase pushBack _item;
		} else {
			if (isClass (configFile >> "CfgMagazines" >> _item)) then {
				_magazinesBase pushBack _item;
			};
		};
	};
};

private _weaponFinal = selectRandom _weaponBase;
private _magazinesFinal = [];

private _magazinesCompatible = [_weaponFinal] call CBA_fnc_compatibleMagazines;
_magazinesBase apply {
	_item = _x;

	if (_magazinesCompatible findIf {_x == _item} != -1) then {
		_magazinesFinal pushBack _item;
	};
};


private _accOpticCompatible = [_weaponFinal, "optic"] call CBA_fnc_compatibleItems;
private _accMuzzleCompatible = [_weaponFinal, "muzzle"] call CBA_fnc_compatibleItems;
private _accPointerCompatible = [_weaponFinal, "pointer"] call CBA_fnc_compatibleItems;
private _accBipodCompatible = [_weaponFinal, "bipod"] call CBA_fnc_compatibleItems;

private _accOpticFinal = [""];
private _accMuzzleFinal = [""];
private _accPointerFinal = [""];
private _accBipodFinal = [""];

_accBase apply {
	switch true do {
		case ({_accOpticCompatible findIf {_x == _item} != -1}): {_accOpticFinal pushBack _item};
		case ({_accMuzzleCompatible findIf {_x == _item} != -1}): {_accMuzzleFinal pushBack _item};
		case ({_accPointerCompatible findIf {_x == _item} != -1}): {_accPointerFinal pushBack _item};
		case ({_accBipodCompatible findIf {_x == _item} != -1}): {_accBipodFinal pushBack _item};
	};
};

private _magazineRandom = selectRandom _magazinesFinal;

_unit addWeaponWithAttachmentsCargoGlobal [[_weaponFinal, (selectRandom _accMuzzleFinal), (selectRandom _accPointerFinal), (selectRandom _accOpticFinal), [_magazineRandom,1000], [], (selectRandom _accBipodFinal)], 1];
_unit addMagazineCargoGlobal [_magazineRandom, _qty];

[_unit,true]
