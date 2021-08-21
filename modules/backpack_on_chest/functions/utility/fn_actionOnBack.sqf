/*
 * Author: DerZade
 * Triggered by the onBack-action. Handles all the stuff.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * Nothing
 *
 * Example:
 * [player] call zade_boc_fnc_actionOnBack;
 *
 * Public: No
 */
params ["_player"];

private _chestpack = [_player] call zade_boc_fnc_chestpack;
private _chestpackitems =  [_player,false] call zade_boc_fnc_chestpackItems;
private _chestpackmags = [_player] call zade_boc_fnc_chestpackMagazines;
private _radioSettings = +(_player getVariable ["zade_boc_radioSettings",[]]);

//add pack
_player addBackpackGlobal _chestpack;
clearAllItemsFromBackpack _player;
//add items
{
     //check wether item is a backpack
     if (isClass (configFile>> "CfgVehicles" >> _x)) then {
          (backpackContainer _player) addBackpackCargoGlobal [_x, 1];
     } else {
          _player addItemToBackpack _x;
     };
} forEach _chestpackitems;

//add magazines
{
     (backpackContainer _player) addMagazineAmmoCargo [(_x select 0), (_x select 2), (_x select 1)];
} forEach _chestpackmags;


if !(_radioSettings isEqualTo []) then {
     [_player,_radioSettings] call zade_boc_fnc_pasteRadioSettings;
};

[_player] call zade_boc_fnc_removeChestpack;
