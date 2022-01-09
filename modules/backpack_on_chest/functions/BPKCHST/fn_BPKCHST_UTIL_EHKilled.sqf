/*
 * Author: DerZade
 * Triggerd by Killed-Eventhandler
 *
 * Arguments:
 * 0: unit <OBJECT>
 *
 * Return Value:
 * Nothing
 *
 * Example:
 * _this call FW_fnc_BPKCHST_UTIL_EHKilled;
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_unit"];

private _chestpack = [_unit] call FUNC(BPKCHST_Chestpack);
private _chestpackitems =  [_unit, false] call FUNC(BPKCHST_ChestpackItems);
private _chestpackmags = [_unit] call FUNC(BPKCHST_ChestpackMagazines);

private _holder = createVehicle ["WeaponHolderSimulated", (getPos _unit), [], 0, "CAN_COLLIDE"];

//add pack
_holder addBackpackCargoGlobal [_chestpack, 1];
private _backpack = firstBackpack _holder;
clearAllItemsFromBackpack _backpack;

//add items
{
     _backpack addItemCargoGlobal [_x, 1];
} forEach _chestpackitems;

//add magazines
{
     _backpack addMagazineAmmoCargo [(_x select 0), (_x select 2), (_x select 1)];
} forEach _chestpackmags;

//remove the backpack from the dead unit
[_unit] call FUNC(BPKCHST_removeChestpack);
