/*
 * Author: TinfoilHate
 * Adds up to the specified number of magazines to a unit or specific location.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Unit's Olsen Gear Type <STRING>
 * 2: Array of Magazine classes <ARRAY>
 * 3: Optional location to fill with magazines <STRING>
 * 4: Optional maximum magazines to add <NUMBER>
 *
 * Return Value:
 * Nil
 *
 * Example:
 * [_unit,_type,["rhs_VOG25"],"vest",12] call kobld_weaponHelper_fnc_addMagazine;
 *
 * Public: Yes
*/

params ["_unit","_type","_magazineBase","_location","_max"];

private _uniform = uniform _unit;
private _vest = vest _unit;
private _backpack = backpack _unit;
private _magazineRandom = "";

if (_magazineBase isEqualType "STRING") then {
	_magazineBase = [_magazineBase];
};

if (isClass (configFile >> "CfgWeapons" >> (_magazineBase # 0))) then {
	_magazineBase = getArray (configFile >> "CfgWeapons" >> (_magazineBase # 0) >> "magazines");
};

_location = toLower(_location);

if (_uniform != "") then {
	if (_location isEqualTo "uniform" || {_location isEqualTo ""}) then {
		private _i = 0;
		while {_magazineRandom = selectRandom _magazineBase; _unit canAddItemToUniform _magazineRandom} do {
			if (_i >= _max) exitWith {};

			[_magazineRandom,1,"uniform"] call FNC_AddItem;

			_i = _i + 1;
		};
	};
};

if (_vest != "") then {
	if (_location isEqualTo "vest" || {_location isEqualTo ""}) then {
		private _i = 0;
		while {_magazineRandom = selectRandom _magazineBase; _unit canAddItemToVest _magazineRandom} do {
			if (_i >= _max) exitWith {};

			[_magazineRandom,1,"vest"] call FNC_AddItem;

			_i = _i + 1;
		};
	};
};

if (_backpack != "") then {
	if (_location isEqualTo "backpack" || {_location isEqualTo ""}) then {
		private _i = 0;
		while {_magazineRandom = selectRandom _magazineBase; _unit canAddItemToBackpack _magazineRandom} do {
			if (_i >= _max) exitWith {};

			[_magazineRandom,1,"backpack"] call FNC_AddItem;

			_i = _i + 1;
		};
	};
};

_unit addPrimaryWeaponItem (selectRandom _magazineBase);
_unit addHandgunItem (selectRandom _magazineBase);