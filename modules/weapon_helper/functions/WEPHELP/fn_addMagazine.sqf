/*
 * Author: TinfoilHate
 * Adds up to the specified number of magazines to a unit or specific location.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Array of Magazine classes <ARRAY>
 * 2: Optional location to fill with magazines <STRING>
 * 3: Optional maximum magazines to add <NUMBER>
 *
 * Return Value:
 * Nil
 *
 * Example:
 * [_unit,["rhs_VOG25"],"vest",12] call EFUNC(WEPHELP,addMagazine);
 *
 * Public: Yes
*/

#include "script_component.hpp"

params ["_unit","_magazineBase","_location","_max"];

private _uniform = uniform _unit;
private _vest = vest _unit;
private _backpack = backpack _unit;
private _magazineRandom = "";
private _magazinesAdded = 0;

if (_magazineBase isEqualType "STRING") then {
	_magazineBase = [_magazineBase];
};

if (isClass (configFile >> "CfgWeapons" >> (_magazineBase select 0))) then {
	_magazineBase = getArray (configFile >> "CfgWeapons" >> (_magazineBase select 0) >> "magazines");
};

if (_uniform != "") then {
	if (_location == "uniform" || _location == "") then {
		while {_magazineRandom = selectRandom _magazineBase; _unit canAddItemToUniform _magazineRandom} do {
			if (_magazinesAdded >= _max) exitWith {};

			[_magazineRandom,1,"uniform"] call EFUNC(FW,AddItem);

			_magazinesAdded = _magazinesAdded + 1;
		};
	};
};

if (_vest != "") then {
	if (_location == "vest" || _location == "") then {
		while {_magazineRandom = selectRandom _magazineBase; _unit canAddItemToVest _magazineRandom} do {
			if (_magazinesAdded >= _max) exitWith {};

			[_magazineRandom,1,"vest"] call EFUNC(FW,AddItem);

			_magazinesAdded = _magazinesAdded + 1;
		};
	};
};

if (_backpack != "") then {
	if (_location == "backpack" || _location == "") then {
		while {_magazineRandom = selectRandom _magazineBase; _unit canAddItemToBackpack _magazineRandom} do {
			if (_magazinesAdded >= _max) exitWith {};

			[_magazineRandom,1,"backpack"] call EFUNC(FW,AddItem);

			_magazinesAdded = _magazinesAdded + 1;
		};
	};
};

_unit addPrimaryWeaponItem (selectRandom _magazineBase);
_unit addHandgunItem (selectRandom _magazineBase);
