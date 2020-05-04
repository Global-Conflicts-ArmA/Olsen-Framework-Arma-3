["weapon_helper", "Assists with gear randomization.", "TinfoilHate"] call FNC_RegisterModule;

#include "settings.sqf"

FNC_wephelper = {
	params ["_unit","_type","_inputArray",["_location", ""],"_max"];

	private _accList = [];
	private _weaponList = [];
	private _magazineList = [];

	// Sort the jumbled mass of organizational failure that is the _inputArray
	{
		_item = toLower(_x);

		if ("ItemCore" in ([(configFile >> "CfgWeapons" >> _item),true] call BIS_fnc_returnParents)) then {
			_accList pushBack _item;
		};

		if (isClass (configFile >> "CfgWeapons" >> _item) && !(_item in _accList)) then {
			_weaponList pushBack _item;
		};

		if (isClass (configFile >> "CfgMagazines" >> _item)) then {
			_magazineList pushBack _item;
		};
	} forEach _inputArray;

	_newWeapon = selectRandom _weaponList;
	_newMagList = [];
	{
		_item = toLower(_x);
		//I hate this a lot
		_tempMagArray = [];
		{_tempMagArray pushBack toLower(_x)} forEach ([_newWeapon] call CBA_fnc_compatibleMagazines);

		if (_item in _tempMagArray) then {
			_newMaglist pushBack toLower(_item);
		};
	} forEach _magazineList;

	_newAccListOptic = [];
	_newAccListMuzzle = [];
	_newAccListPointer = [];
	_newAccListBipod = [];

	_optics = [];
	_muzzles = [];
	_pointers = [];
	_bipods = [];

	{_optics pushBack toLower(_x)} forEach ([_newWeapon, "optic"] call CBA_fnc_compatibleItems);
	{_muzzles pushBack toLower(_x)} forEach ([_newWeapon, "muzzle"] call CBA_fnc_compatibleItems);
	{_pointers pushBack toLower(_x)} forEach ([_newWeapon, "pointer"] call CBA_fnc_compatibleItems);
	{_bipods pushBack toLower(_x)} forEach ([_newWeapon, "bipod"] call CBA_fnc_compatibleItems);

	{
		_item = toLower(_x);

		switch true do {
			case ((_item in _optics) && (random 1 < fw_weaponhelper_opticChance)): {_newAccListOptic pushBack _item};
			case ((_item in _muzzles) && (random 1 < fw_weaponhelper_muzzleChance)): {_newAccListMuzzle pushBack _item};
			case ((_item in _pointers) && (random 1 < fw_weaponhelper_pointerChance)): {_newAccListPointer pushBack _item};
			case ((_item in _bipods) && (random 1 < fw_weaponhelper_bipodChance)): {_newAccListBipod pushBack _item};
		};
	} forEach _accList;

	[_newWeapon] call FNC_AddItem;
	if (count _newAccListOptic > 0) then {[(selectRandom _newAccListOptic)] call FNC_AddItem;};
	if (count _newAccListMuzzle > 0) then {[(selectRandom _newAccListMuzzle)] call FNC_AddItem;};
	if (count _newAccListPointer > 0) then {[(selectRandom _newAccListPointer)] call FNC_AddItem;};
	if (count _newAccListBipod > 0) then {[(selectRandom _newAccListBipod)] call FNC_AddItem;};

	if (count _newMagList > 0) then {
		[_unit,_type,_newMagList,_location,_max] call FNC_maghelper;
	} else {
		[_unit,_type,_newWeapon,_location,_max] call FNC_maghelper;
	};
};

FNC_maghelper = {
	params ["_unit","_type","_magazine","_location","_max"];

	private _uniform = uniform _unit;
	private _vest = vest _unit;
	private _backpack = backpack _unit;
	private _newMag = "";

	if (typeName _magazine == "STRING") then {
		_magazine = [_magazine];
	};

	if (isClass (configFile >> "CfgWeapons" >> (_magazine # 0))) then {
		_magazine = getArray (configFile >> "CfgWeapons" >> (_magazine # 0) >> "magazines");
	};

	if (_uniform != "") then {
		if (_location == "uniform" || _location == "") then {
			_u = 0;
			while {_newMag = selectRandom _magazine; _unit canAddItemToUniform _newMag} do {
				if (_u >= _max) exitWith {};

				[_newMag,1,"uniform"] call FNC_AddItem;

				_u = _u + 1;
			};
		};
	};

	if (_vest != "") then {
		if (_location == "vest" || _location == "") then {
			_v = 0;
			while {_newMag = selectRandom _magazine; _unit canAddItemToVest _newMag} do {
				if (_v >= _max) exitWith {};

				[_newMag,1,"vest"] call FNC_AddItem;

				_v = _v + 1;
			};
		};
	};

	if (_backpack != "") then {
		if (_location == "backpack" || _location == "") then {
			_b = 0;
			while {_newMag = selectRandom _magazine; _unit canAddItemToBackpack _newMag} do {
				if (_b >= _max) exitWith {};

				[_newMag,1,"backpack"] call FNC_AddItem;

				_b = _b + 1;
			};
		};
	};

	_unit addPrimaryWeaponItem (selectRandom _magazine);
	_unit addHandgunItem (selectRandom _magazine);
};