/*
 * Author: DerZade
 * Checks if given item can be stored into soldier's chestpack.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Item/magazine/weapon classname <STRING>
 * 2: Amount <NUMBER> (optional)
 *
 * Return Value:
 * Can add item? <BOOL>
 *
 * Example:
 * [player,"FirstAidKit",2] call FW_fnc_BPKCHST_canAddItemToChestpack;
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_unit","_item",["_amount",1]];

//calculate space left in chestpack
private _freeSpace = getNumber(configFile >> "CfgVehicles" >> ([_unit] call FUNC(BPKCHST_Chestpack)) >> "maximumLoad") - ([_unit] call FUNC(BPKCHST_loadChestpack));

private _itemMass = 0;
if (isClass (configFile>>"CfgWeapons">> _item >> "ItemInfo")) then {
     _itemMass = getNumber(configFile>>"CfgWeapons">> _item >> "ItemInfo" >> "Mass");
};
if (isClass (configFile>>"CfgWeapons">> _item >> "WeaponSlotsInfo")) then {
     _itemMass = getNumber(configFile>>"CfgWeapons">> _item >> "WeaponSlotsInfo" >> "Mass")
};
if (isClass (configFile>>"CfgMagazines">> _item)) then {
     _itemMass = getNumber(configFile>>"CfgMagazines">> _item >> "Mass");
};
if (isClass (configFile>>"CfgVehicles">> _item)) then  {
     _itemMass = getNumber(configFile>>"CfgVehicles">> _item >> "Mass");
};
if (isClass (configFile>>"CfgGlasses">> _item)) then  {
     _itemMass = getNumber(configFile>>"CfgGlasses">> _item >> "Mass");
};

if (_itemMass * _amount > _freeSpace) then {false} else {true};
