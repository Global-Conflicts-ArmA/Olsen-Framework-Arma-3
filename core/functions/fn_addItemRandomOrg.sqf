/*
 * Author: Olsen
 *
 * Add random item to unit.
 *
 * Arguments:
 * 0: unit <object> and loadout name <string> <array>
 * 1: items <array>
 *
 * Return Value:
 * nothing
 *
 * Public: No
 */

#include "..\script_macros.hpp"

params [["_nestedArray", [], [[]]], ["_items", [], [[]]]];
_nestedArray params ["_unit", "_loadoutType"];

private _randomPick = selectRandom _items;

if (_randomPick isEqualType "") then {
	[_unit, _loadoutType, _randomPick] call FUNC(AddItemOrg);
} else {
	if (_randomPick isEqualType []) then {
		{
			if (_x isEqualType "") then {
				[_unit, _loadoutType, _x] call FUNC(AddItemOrg);
			} else {
				if (_x isEqualType []) then {
					_x params [["_item", "", [""]], ["_amount", 1, [1]], ["_position", "none", [""]]];
					[_unit, _loadoutType, _item, _amount, _position] call FUNC(AddItemOrg);
				};
			};
		} forEach _randomPick;
	};
};