/*
 * Author: DerZade
 * Returns array with all items (of any kind, even weapons) in chestpack of the given unit.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Return magazines aswell <BOOL> (optional | default: true)
 *
 * Return Value:
 * Items <ARRAY>
 *
 * Example:
 * [player] call FW_fnc_BPKCHST_ChestpackItems;
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_unit",["_returnMags",true]];

private _var = _unit getVariable ["zade_boc_chestpack",nil];
private _items = +(_var select 2);

if (_returnMags) then {
     //add magazines
     {
          _items pushBack (_x select 0);
     } forEach (_var select 3);
};

//return objNull
if (isNil "_var" or isNil "_items") exitWith {[]};

//return items
_items
