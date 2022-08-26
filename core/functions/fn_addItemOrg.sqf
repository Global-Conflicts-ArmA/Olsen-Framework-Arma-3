/*
 * Author: Olsen
 *
 * Add item to unit.
 *
 * Arguments:
 * 0: unit to add item to <object>
 * 1: name of loadout <string>
 * 2: item classname <string>
 * 3: amount <number> (optional)
 * 4: container ("uniform"/"vest"/"backpack") <string> (optional)
 *
 * Return Value:
 * nothing
 *
 * Public: No
 */

#include "script_component.hpp"

params ["_unit", "_loadoutType", "_item", ["_amount", 1, [1]], ["_position", "none", [""]]];

if !([_item, _unit] call FUNC(checkClassname)) exitWith {};

if (_position isNotEqualTo "") then {
	_position = toLower _position;
};

for "_x" from 1 to _amount do {
	private _success = false;
	private _parents = [configFile >> "CFGweapons" >> _item, true] call BIS_fnc_returnParents;
	private _type = (_item call BIS_fnc_itemType) select 1;

	if (_position isEqualTo "none") then {
		if (!_success && {"Rifle" in _parents}) then {
			if (primaryWeapon _unit isEqualTo "") then {
				_unit addWeaponGlobal _item;
				_success = true;
			};
		};
		if (!_success && {"Pistol" in _parents}) then {
			if (handgunWeapon _unit isEqualTo "") then {
				_unit addWeaponGlobal _item;
				_success = true;
			};
		};
		if (!_success && {"Launcher" in _parents}) then {
			if (secondaryWeapon _unit isEqualTo "") then {
				_unit addWeaponGlobal _item;
				_success = true;
			};
		};
		if (!_success && {_type in ["Map", "GPS", "Compass", "Watch", "NVGoggles"]}) then {
			if ([_unit, _type] call FUNC(CanLinkItem)) then {
				_unit linkItem _item;
				_success = true;
			};
		};
		if (!_success && {_type isEqualTo "Uniform"}) then {
			if (uniform _unit isEqualTo "") then {
				_unit forceAddUniform _item;
				_success = true;
			};
		};
		if (!_success && {_type isEqualTo "Vest"}) then {
			if (vest _unit isEqualTo "") then {
				_unit addVest _item;
				_success = true;
			};
		};
		if (!_success && {_type isEqualTo "Backpack"}) then {
			if (backpack _unit isEqualTo "") then {
				_unit addBackpackGlobal _item;
				_success = true;
			};
		};
		if (!_success && {_type isEqualTo "Headgear"}) then {
			if (headgear _unit isEqualTo "") then {
				_unit addHeadgear _item;
				_success = true;
			};
		};
		if (!_success && {_type isEqualTo "Glasses"}) then {
			if (goggles _unit isEqualTo "") then {
				_unit addGoggles _item;
				_success = true;
			};
		};
		if (!_success && {_type isEqualTo "Binocular"}) then {
			if (binocular _unit isEqualTo "") then {
				_unit addWeaponGlobal _item;
				_success = true;
			};
		};
		if (!_success && {_type in ["AccessoryMuzzle", "AccessoryPointer", "AccessorySights", "AccessoryBipod"]}) then {
			if ([primaryWeapon _unit, _item] call FUNC(CanAttachItem)) then {
				if (!(_type in primaryWeaponItems _unit)) then {
					_unit addPrimaryWeaponItem _item;
					_success = true;
				};
			}
			else {
				if ([handgunWeapon _unit, _item] call FUNC(CanAttachItem)) then {
					if (!(_type in handgunItems _unit)) then {
						_unit addHandgunItem _item;
						_success = true;
					};
				}
				else {
					if ([secondaryWeapon _unit, _item] call FUNC(CanAttachItem)) then {
						if (!(_type in secondaryWeaponItems _unit)) then {
							_unit addSecondaryWeaponItem _item;
							_success = true;
						};
					};
				}
			}
		};
	} else {
		switch (_position) do {
			case "backpack": {
				if (_unit canAddItemToBackpack _item || (GVAR(enableOverfill))) then {
					if ((GVAR(enableOverfill))) then {
						(backpackContainer _unit) addItemCargoGlobal [_item, 1];
					}
					else {
						_unit addItemToBackpack _item;
					};
					_success = true;
				};
			};
			case "vest": {
				if (_unit canAddItemToVest _item || (GVAR(enableOverfill))) then {
					if ((GVAR(enableOverfill))) then {
						(vestContainer _unit) addItemCargoGlobal [_item, 1];
					}
					else {
						_unit addItemToVest _item;
					};
					_success = true;
				};
			};
			case "uniform": {
				if (_unit canAddItemToUniform _item || (GVAR(enableOverfill))) then {
					if ((GVAR(enableOverfill))) then {
						(uniformContainer _unit) addItemCargoGlobal [_item, 1];
					}
					else {
						_unit addItemToUniform _item;
					};
					_success = true;
				};
			};
			default {
				if (_unit canAddItemToUniform _item || (GVAR(enableOverfill))) then {
					if ((GVAR(enableOverfill))) then {
						(uniformContainer _unit) addItemCargoGlobal [_item, 1];
					}
					else {
						_unit addItemToUniform _item;
					};
					_success = true;
				};
			};
		};
		if !(_success) then {
            ERROR_4("FW_fnc_AddItem: Warning %1 overflown from %2, in %3, case %4", _item, _position, _unit, _loadoutType);
		};
	};

	if !(_success) then {
		if (_unit canAdd _item && {_type != "Backpack"}) then {
			_unit addItem _item;
			_success = true;
		} else {
            if (_position isEqualTo "none") then {
                ERROR_4("FW_fnc_AddItem: Warning couldn't fit %1 anywhere, in %3, case %4", _item, _position, _unit, _loadoutType);
			} else {
                ERROR_4("FW_fnc_AddItem: Warning couldn't fit %1 anywhere, originally intended for %2, in %3, case %4", _item, _position, _unit, _loadoutType);
            };
		};
	};
};
