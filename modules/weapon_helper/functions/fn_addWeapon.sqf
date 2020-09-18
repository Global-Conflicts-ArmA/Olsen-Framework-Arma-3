/*
 * Author: TinfoilHate
 * Adds a random weapon and appropriate random magazines from an array, either to the unit in general or a specific container on the unit.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Unit's Olsen Gear Type <STRING>
 * 2: Array of Weapon/Magazine/Accessory classes <ARRAY>
 * 3: Optional location to fill with magazines ("" or blank is all locations) <STRING>
 * 4: Optional maximum magazines to add <NUMBER>
 *
 * Return Value:
 * Nil
 *
 * Example:
 * [_unit, _type, ["rhs_weap_akm", "rhs_30Rnd_762x39mm", "rhs_weap_ak74n", "rhs_30Rnd_545x39_AK"], "vest", 8] call kobld_weaponHelper_fnc_addWeapon;
 *
 * Public: Yes
*/

params ["_unit", "_type", "_inputArray", ["_location", ""], "_max"];

private _accBase = [];
private _weaponBase = [];
private _magazinesBase = [];

// Sorting input array
{
	_item = toLower(_x);

	if (([(configFile >> "CfgWeapons" >> _item),true] call BIS_fnc_returnParents) findIf {_x == "ItemCore"} != -1) then {
		_accBase pushBack _item;
	};

	if (isClass (configFile >> "CfgWeapons" >> _item) && {!(_accBase findIf {_x == _item} != -1)}) then {
		_weaponBase pushBack _item;
	};

	if (isClass (configFile >> "CfgMagazines" >> _item)) then {
		_magazinesBase pushBack _item;
	};
} forEach _inputArray;

private _weaponFinal = selectRandom _weaponBase;
private _magazinesFinal = [];

_magazinesCompatible = [_weaponFinal] call CBA_fnc_compatibleMagazines;
{
	_item = _x;

	if (_magazinesCompatible findIf {_x == _item} != -1) then {
		_magazinesFinal pushBack _item;
	};
} forEach _magazinesBase;


private _accOpticCompatible = [_weaponFinal, "optic"] call CBA_fnc_compatibleItems;
private _accMuzzleCompatible = [_weaponFinal, "muzzle"] call CBA_fnc_compatibleItems;
private _accPointerCompatible = [_weaponFinal, "pointer"] call CBA_fnc_compatibleItems;
private _accBipodCompatible = [_weaponFinal, "bipod"] call CBA_fnc_compatibleItems;

private _accRandom = [
	(random 1 < (missionNamespace getVariable [("kobld_weaponHelper_opticChance_" + str(side _unit)),0])),
	(random 1 < (missionNamespace getVariable [("kobld_weaponHelper_muzzleChance_" + str(side _unit)),0])),
	(random 1 < (missionNamespace getVariable [("kobld_weaponHelper_pointerChance_" + str(side _unit)),0])),
	(random 1 < (missionNamespace getVariable [("kobld_weaponHelper_bipodChance_" + str(side _unit)),0]))
];

private _accOpticFinal = [];
private _accMuzzleFinal = [];
private _accPointerFinal = [];
private _accBipodFinal = [];

{
	_accRandom params ["_randomOptic","_randomMuzzle","_randomPointer","_randomBipod"];
	_item = _x;

	switch true do {
		case (_randomOptic && {_accOpticCompatible findIf {_x == _item} != -1}): {_accOpticFinal pushBack _item};
		case (_randomMuzzle && {_accMuzzleCompatible findIf {_x == _item} != -1}): {_accMuzzleFinal pushBack _item};
		case (_randomPointer && {_accPointerCompatible findIf {_x == _item} != -1}): {_accPointerFinal pushBack _item};
		case (_randomBipod && {_accBipodCompatible findIf {_x == _item} != -1}): {_accBipodFinal pushBack _item};
	};
} forEach _accBase;

private _itemsFinal = [];
_itemsFinal pushBack _weaponFinal;

if (count _accOpticFinal > 0) then {_itemsFinal pushBack (selectRandom _accOpticFinal)};
if (count _accMuzzleFinal > 0) then {_itemsFinal pushBack (selectRandom _accMuzzleFinal)};
if (count _accPointerFinal > 0) then {_itemsFinal pushBack (selectRandom _accPointerFinal)};
if (count _accBipodFinal > 0) then {_itemsFinal pushBack (selectRandom _accBipodFinal)};

_itemsFinal apply {[_x] call FNC_AddItem};

if (count _magazinesFinal > 0) then {
	[_unit,_type,_magazinesFinal,_location,_max] call kobld_weaponHelper_fnc_addMagazine;
} else {
	[_unit,_type,_weaponFinal,_location,_max] call kobld_weaponHelper_fnc_addMagazine;
};