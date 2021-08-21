/*
 * Author: DerZade
 * Returns current sum of mass from items stored in a chestpack.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * Mass <NUMBER>
 *
 * Example:
 * [player] call FW_fnc_BPKCHST_loadChestpack;
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_unit"];

private _items = [_unit] call FUNC(BPKCHST_ChestpackItems);
private _mass = 0;

{

     //get mass of item
     private _itemMass = 0;
     if (isClass (configFile>>"CfgWeapons">> _x >> "ItemInfo")) then {
          _itemMass = getNumber(configFile>>"CfgWeapons">> _x >> "ItemInfo" >> "Mass");
     };
     if (isClass (configFile>>"CfgWeapons">> _x >> "WeaponSlotsInfo")) then {
          _itemMass = getNumber(configFile>>"CfgWeapons">> _x >> "WeaponSlotsInfo" >> "Mass")
     };
     if (isClass (configFile>>"CfgMagazines">> _x)) then {
          _itemMass = getNumber(configFile>>"CfgMagazines">> _x >> "Mass");
     };
     if (isClass (configFile>>"CfgVehicles">> _x)) then  {
          _itemMass = getNumber(configFile>>"CfgVehicles">> _x >> "Mass");
     };
     if (isClass (configFile>>"CfgGlasses">> _x)) then  {
          _itemMass = getNumber(configFile>>"CfgGlasses">> _x >> "Mass");
     };

     _mass = _mass + _itemMass

} forEach _items;


_mass
