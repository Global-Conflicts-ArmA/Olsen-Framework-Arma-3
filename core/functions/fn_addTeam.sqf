/*
 * Author: Olsen
 *
 * Adds new team.
 *
 * Arguments:
 * 0: side of new team <side>
 * 1: name of new team <string>
 * 2: type of new team: "ai"/"player" <string>
 *
 * Return Value:
 * nothing
 *
 * Public: Yes
 */

#include "..\script_macros.hpp"

params [
	["_side", sideUnknown, [sideUnknown]],
	["_name", "Unknown", [""]],
	["_type", "ai", [""]]
];

if (isMultiplayer) then {
	_type = "ai";
};

GVAR(TeamSides) pushBackUnique _side;

GVAR(Teams) pushBack [_name, _side, _type,  0, 0, [], []];