/*
 * Author: DerZade
 * Triggerd by Add-Module
 *
 * Arguments:
 * 0: module <OBJECT>
 * 1: synchronized units <ARRAY>
 *
 * Return Value:
 * Nothing
 *
 * Example:
 * n/a
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_module","_units"];

private _class = _module getVariable "classname";
private _items = call compile format ["[%1]",_module getVariable "items"];
private _mags = call compile format ["[%1]",_module getVariable "mags"];
private _code = compile (_module getVariable "code");

{
     private _unit = _x;

     //add chestpack
     [_unit,_class] call FUNC(BPKCHST_addChestpack);

     //add items
     {
          if (typeName _x isEqualTo "STRING") then {
               [_unit,_x] call FUNC(BPKCHST_addItemToChestpack);
          } else {
               private _itemClass = _x select 0;
               private _itemAmount = _x select 1;
               [_unit,_itemClass,_itemAmount] call FUNC(BPKCHST_addItemToChestpack);
          };
     } forEach _items;

     //add magazines
     {
          [_unit,(_x select 0),(_x select 1)] call FUNC(BPKCHST_addMagToChestpack);
     } forEach _mags;

     //execute extra code
     ([_unit] call FUNC(BPKCHST_ChestpackContainer)) spawn _code;
} forEach _units;
