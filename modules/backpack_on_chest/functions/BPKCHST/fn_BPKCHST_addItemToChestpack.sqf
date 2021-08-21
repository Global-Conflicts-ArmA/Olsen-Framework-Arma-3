/*
 * Author: DerZade
 * Creates a new item and stores it in the soldier's chestpack. The item can also be a weapon or a magazine.
 * The item(s) won't be added, if adding them would cause an overflow of the backpack.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Item/magazine/weapon classname <STRING>
 * 2: Amount <NUMBER> (optional | default: 1)
 *
 * Return Value:
 * Nothing
 *
 * Example:
 * [player,"FirstAidKit"] call zade_boc_fnc_addItemToChestpack;
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_unit","_item",["_amount",1]];

//exit if there is not enough space left
if !([_unit,_item,_amount] call FUNC(BPKCHST_canAddItemToChestpack)) exitWith {};

//exit if is magazine
if (isClass (configFile >> "CfgMagazines" >> _item)) exitWith {
     for "_i" from 1 to _amount do {
          [_unit,_item,(getNumber (configFile >> "CfgMagazines" >> _item >> "count"))] call FUNC(BPKCHST_addMagToChestpack);
     };
};

private _var = _unit getVariable ["zade_boc_chestpack",nil];

for "_i" from 1 to _amount do {
     (_var select 2) pushBack _item;
};

//update variable
_unit setVariable ["zade_boc_chestpack",_var,true];
