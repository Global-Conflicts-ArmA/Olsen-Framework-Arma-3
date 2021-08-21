/*
 * Author: DerZade
 * Removes magazine from unit's chestpack. The purpose of this function is to ensure that magazines with a specified ammo count can be removed.
 * If you want to remove a magazine with just any amount of ammo you may want to use 'zade_boc_fnc_removeItemFromChestpack' instead.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Classname <STRING>
 * 2: Ammo count <NUMBER>
 *
 * Return Value:
 * Nothing
 *
 * Example:
 * [player,"30Rnd_556x45_Stanag",25] call zade_boc_fnc_removeMagFromChestpack;
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_unit","_item","_ammo"];

//exit if there is no such item in chestpack
if ((compile format ["(_x select 0) isEqualTo '%1' and (_x select 1) isEqualTo %2",_item,_ammo]) count ([_unit] call FUNC(BPKCHST_ChestpackMagazines)) isEqualTo 0) exitWith {};

private _var = _unit getVariable ["zade_boc_chestpack",nil];

(_var select 3) deleteAt ((_var select 3) find [_item,_ammo]);

//update variable
_unit setVariable ["zade_boc_chestpack",_var,true];
