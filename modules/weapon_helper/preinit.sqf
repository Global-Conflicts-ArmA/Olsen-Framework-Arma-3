["Weapon Helper", "1.0", "Assists with gear randomisation.", "TinfoilHate, StatusRed"] call FNC_RegisterModule;

#include "settings.sqf"

FNC_WepHelper = {
	params ["_unit", "_type", "_maxMags", "_inputArray", ["_location", ""]];

	private _accList = [];
	private _weaponList = [];
	private _magazineList = [];

	// Sort the jumbled mass of organisational failure that is the _inputArray
	{
		if ("ItemCore" in ([(configFile >> "CfgWeapons" >> _x), true] call BIS_fnc_returnParents)) then {
			_accList pushBack _x;
		};

		if (isClass (configFile >> "CfgWeapons" >> _x) && !(_x in _accList)) then {
			_weaponList pushBack _x;
		};

		if (isClass (configFile >> "CfgMagazines" >> _x)) then {
			_magazineList pushBack _x;
		};
	} forEach _inputArray;

	_newWeapon = selectRandom _weaponList;
	_newMagList = [];
	{
		if (_x in (getArray (configFile >> "CfgWeapons" >> _newWeapon >> "magazines")) ) then {
			_newMaglist pushBack _x;
		};
	} forEach _magazineList;

	_newAccListOptic = [];
	_newAccListMuzzle = [];
	_newAccListPointer = [];
	_newAccListBipod = [];
	{
		switch true do {
			case (_x in ([_newWeapon, "optic"] call CBA_fnc_compatibleItems) && (random 1 < fw_weaponhelper_opticChance)): {_newAccListOptic pushBack _x};
			case (_x in ([_newWeapon, "muzzle"] call CBA_fnc_compatibleItems) && (random 1 < fw_weaponhelper_muzzleChance)): {_newAccListMuzzle pushBack _x};
			case (_x in ([_newWeapon, "pointer"] call CBA_fnc_compatibleItems) && (random 1 < fw_weaponhelper_pointerChance)): {_newAccListPointer pushBack _x};
			case (_x in ([_newWeapon, "bipod"] call CBA_fnc_compatibleItems) && (random 1 < fw_weaponhelper_bipodChance)): {_newAccListBipod pushBack _x};
		};
	} forEach _accList;

	[_newWeapon] call FNC_AddItem;
	if (count _newAccListOptic > 0) then {[(selectRandom _newAccListOptic)] call FNC_AddItem;};
	if (count _newAccListMuzzle > 0) then {[(selectRandom _newAccListMuzzle)] call FNC_AddItem;};
	if (count _newAccListPointer > 0) then {[(selectRandom _newAccListPointer)] call FNC_AddItem;};
	if (count _newAccListBipod > 0) then {[(selectRandom _newAccListBipod)] call FNC_AddItem;};

	if (count _newMagList > 0) then {
		[_unit, _type, _newMagList, _maxMags, _location] call FNC_MagHelper;
	} else {
		[_unit, _type, _newWeapon, _maxMags, _location] call FNC_MagHelper;
	};
};

FNC_MagHelper = {
	params ["_unit", "_type", "_magazine", "_maxMags", "_location"];

	_maxMags = _maxMags - 1; // Decrement the max mags as the mag added directly to the weapon isn't included
	private _uniform = uniform _unit;
	private _vest = vest _unit;
	private _backpack = backpack _unit;
	private _newMag = "";
	private _magCount = 0;

	if ("STRING" == (typeName _magazine)) then {
		_magazine = [_magazine];
	};

	if (isClass (configFile >> "CfgWeapons" >> (_magazine # 0))) then {
		_magazine = getArray (configFile >> "CfgWeapons" >> (_magazine # 0) >> "magazines");
	};

	if ("" != _uniform) then {
		if ("uniform" == _location || "" == _location) then {
			while {_newMag = selectRandom _magazine; _unit canAddItemToUniform _newMag} do {
				if (_maxMags > _magCount) then {
					[_newMag, 1, "uniform"] call FNC_AddItem;
					_magCount = _magCount + 1;
				} else {
					// Do nothing.
				};
			};
		};
	};

	if ("" != _vest) then {
		if ("vest" == _location || "" == _location) then {
			while {_newMag = selectRandom _magazine; _unit canAddItemToVest _newMag} do {
				if (_maxMags > _magCount) then {
					[_newMag, 1, "vest"] call FNC_AddItem;
					_magCount = _magCount + 1;
				} else {
					// Do nothing.
				};
			};
		};
	};

	if ("" != _backpack) then {
		if ("backpack" == _location || "" == _location) then {
			while {_newMag = selectRandom _magazine; _unit canAddItemToBackpack _newMag} do {
				if (_maxMags > _magCount) then {
					[_newMag, 1, "backpack"] call FNC_AddItem;
					_magCount = _magCount + 1;
				} else {
					// Do nothing.
				};
			};
		};
	};

	_unit addPrimaryWeaponItem (selectRandom _magazine);
};
