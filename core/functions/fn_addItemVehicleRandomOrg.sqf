/*
 * Author: Olsen
 *
 * Add random item to vehicle.
 *
 * Arguments:
 * 0: vehicle <object> and loadout name <string> <array>
 * 1: items <array>
 *
 * Return Value:
 * nothing
 *
 * Public: No
 */

#include "..\script_macros.hpp"

params ["_nestedArray", "_items"];
_nestedArray params ["_vehicle", "_loadoutType"];

private _amount = 1;
private _position = "NONE";

if (count _items > 1) then {
	if ((_items select 1) isEqualType "ARRAY") then {
		_position = "ARRAY";
	} else {
		if ((_items select 1) isEqualType "SCALAR") then {
			_amount = _items select 1;
			_items = _items select 0;
		};
	};
};

private _randomPick = (_items select (([1, count _items] call FUNC(RandomRange)) - 1));

if (_position isEqualTo "ARRAY") then {

	if ((_randomPick select 0) isEqualType "ARRAY") then {
		{
			([_vehicle, _loadoutType] + _x) call FUNC(AddItemVehicleOrg);
		} forEach _randomPick;
	} else {
		([_vehicle, _loadoutType] + _randomPick) call FUNC(AddItemVehicleOrg);
	};
} else {
	[_vehicle, _loadoutType, _randomPick, _amount] call FUNC(AddItemVehicleOrg);
};