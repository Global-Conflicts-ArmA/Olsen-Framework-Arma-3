/*
 * Author: DerZade
 * Removes unit's chestpack.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * Nothing
 *
 * Example:
 * [player] call zade_boc_fnc_removeChestpack;
 *
 * Public: No
 */
params ["_unit"];

private _var = _unit getVariable ["zade_boc_chestpack",nil];

//delete chestpackContainer
     deleteVehicle ([_unit] call zade_boc_fnc_chestpackContainer);

//remove all EHs
_unit removeEventHandler ["GetInMan",(_var select 1) select 0];
_unit removeEventHandler ["GetOutMan",(_var select 1) select 1];
_unit removeEventHandler ["AnimDone",(_var select 1) select 2];
_unit removeEventHandler ["Killed",(_var select 1) select 3];

_unit forceWalk false;

//reset variable
_unit setVariable ["zade_boc_chestpack",nil,true];
_unit setVariable ["zade_boc_radioSettings",nil,true];
