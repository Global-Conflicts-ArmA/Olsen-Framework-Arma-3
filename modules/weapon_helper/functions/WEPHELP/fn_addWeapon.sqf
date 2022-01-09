/*
 * Author: TinfoilHate
 * Adds a random weapon and appropriate random magazines from an array, either to the unit in general or a specific container on the unit.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Array of Weapon/Magazine/Accessory classes <ARRAY>
 * 2: Optional location to fill with magazines ("" or blank is all locations) <STRING>
 * 3: Optional maximum magazines to add <NUMBER>
 *
 * Return Value:
 * Nil
 *
 * Example:
 * [_unit, ["rhs_weap_akm", "rhs_30Rnd_762x39mm", "rhs_weap_ak74n", "rhs_30Rnd_545x39_AK"], "vest", 8] call EFUNC(WEPHELP,addWeapon);
 *
 * Public: Yes
*/

#include "script_component.hpp"

params ["_unit", "_inputArray", ["_location", ""], "_max"];

private _accBase = [];
private _weaponBase = [];
private _magazinesBase = [];

// Sorting input array
_inputArray apply {
	private _item = toLower(_x);

	if (([(configFile >> "CfgWeapons" >> _item),true] call BIS_fnc_returnParents) findIf {_x == "ItemCore"} != -1) then {
		_accBase pushBack _item;
	};

	if (isClass (configFile >> "CfgWeapons" >> _item) && {!(_accBase findIf {_x == _item} != -1)}) then {
		_weaponBase pushBack _item;
	};

	if (isClass (configFile >> "CfgMagazines" >> _item)) then {
		_magazinesBase pushBack _item;
	};
};

/* diag_log format ["_accBase = %1\n\n_weaponBase = %2\n\n_magazinesBase = %3", _accBase, _weaponBase, _magazinesBase]; */

private _weaponFinal = selectRandom _weaponBase;
private _magazinesFinal = [];

private _magazinesCompatible = [_weaponFinal] call CBA_fnc_compatibleMagazines;
_magazinesBase apply {
	private _item = _x;

	if (_magazinesCompatible findIf {_x == _item} != -1) then {
		_magazinesFinal pushBack _item;
	};
};


private _accOpticCompatible = [_weaponFinal, "optic"] call CBA_fnc_compatibleItems;
private _accMuzzleCompatible = [_weaponFinal, "muzzle"] call CBA_fnc_compatibleItems;
private _accPointerCompatible = [_weaponFinal, "pointer"] call CBA_fnc_compatibleItems;
private _accBipodCompatible = [_weaponFinal, "bipod"] call CBA_fnc_compatibleItems;

private _accRandom = [
	(random 1 < (missionNamespace getVariable [("WEPHELP_opticChance_" + str(side _unit)),0])),
	(random 1 < (missionNamespace getVariable [("WEPHELP_muzzleChance_" + str(side _unit)),0])),
	(random 1 < (missionNamespace getVariable [("WEPHELP_pointerChance_" + str(side _unit)),0])),
	(random 1 < (missionNamespace getVariable [("WEPHELP_bipodChance_" + str(side _unit)),0]))
];

private _accOpticFinal = [];
private _accMuzzleFinal = [];
private _accPointerFinal = [];
private _accBipodFinal = [];

/* diag_log format ["_accBase = %1", _accBase]; */

_accBase apply {
	_accRandom params ["_randomOptic","_randomMuzzle","_randomPointer","_randomBipod"];
	private _item = _x;

	switch true do {
		case (_randomOptic && {_accOpticCompatible findIf {_x == _item} != -1}): {_accOpticFinal pushBack _item};
		case (_randomMuzzle && {_accMuzzleCompatible findIf {_x == _item} != -1}): {_accMuzzleFinal pushBack _item};
		case (_randomPointer && {_accPointerCompatible findIf {_x == _item} != -1}): {_accPointerFinal pushBack _item};
		case (_randomBipod && {_accBipodCompatible findIf {_x == _item} != -1}): {_accBipodFinal pushBack _item};
	};
};

private _itemsFinal = [];
_itemsFinal pushBack _weaponFinal;

if (count _accOpticFinal > 0) then {_itemsFinal pushBack (selectRandom _accOpticFinal)};
if (count _accMuzzleFinal > 0) then {_itemsFinal pushBack (selectRandom _accMuzzleFinal)};
if (count _accPointerFinal > 0) then {_itemsFinal pushBack (selectRandom _accPointerFinal)};
if (count _accBipodFinal > 0) then {_itemsFinal pushBack (selectRandom _accBipodFinal)};

_itemsFinal apply {[_x] call EFUNC(FW,AddItem)};

if (count _magazinesFinal > 0) then {
	[_unit,_magazinesFinal,_location,_max] call FUNC(addMagazine);
} else {
	[_unit,_weaponFinal,_location,_max] call FUNC(addMagazine);
};
