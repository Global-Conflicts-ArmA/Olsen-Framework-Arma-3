/*
 * Author: DerZade
 * Gets array with all magazines from backpack of the given unit.
 *
 * Arguments:
 * 0: unit <OBJECT>
 *
 * Return Value:
 * backpack magazines <ARRAY> [classname,ammo count, amount of mags]
 *
 * Example:
 * [player] call FW_fnc_BPKCHST_UTIL_backpackMagazines;
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_unit"];

private _magsArray = [];

{
     _mag = _x;
     //search for a item in the backpack items which has the same displayname to get a classname
     _classname = "";
     _displayName = "";
     {
          _displayName = getText (configFile >> "CfgMagazines" >> _x >> "DisplayName");
          if (_mag find _displayName != -1 and _displayName != "") exitWith {_classname = _x;};
     } forEach (backpackItems _unit);
     _arr = +(toArray _mag);

     //get ammo of magazine(s)
     _arr deleteRange [0,count _displayName+1]; //remove displayname + '('
     _ammo = +_arr;
     _ammo deleteRange [(_ammo find 47), count _ammo]; //remove everything after '/'
     _ammo = parseNumber toString _ammo;

     //get amount of magazine(s)
     _arr call BIS_fnc_arrayPop; //remove last element ')'
     _arr call BIS_fnc_arrayPop; //remove last element 'x'
     _amount = [];
     _element = _arr call BIS_fnc_arrayPop;
     while {_element != 40} do {
          [_amount,_element] call BIS_fnc_arrayUnShift;
          _element = _arr call BIS_fnc_arrayPop;
     };
     _amount = parseNumber toString _amount;

     _magsArray pushBack [_classname,_ammo,_amount];
} forEach (backpackMagazines _unit);

_magsArray
