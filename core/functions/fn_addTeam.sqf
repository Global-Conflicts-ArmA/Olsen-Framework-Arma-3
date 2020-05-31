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

#include "script_component.hpp"

params [
	["_side", sideUnknown, [sideUnknown]],
	["_name", "Unknown", [""]],
	["_type", "ai", [""]]
];

if (_side in GVAR(TeamSides)) exitwith {};

if !(isMultiplayer) then {
	_type = "ai";
};

GVAR(TeamSides) pushBackUnique _side;
switch _side do {
    case west: {
	    SETMPVAR(TeamName_Blufor,_name);
    };
	case east: {
	    SETMPVAR(TeamName_Opfor,_name);
    };
	case independent: {
	    SETMPVAR(TeamName_Indfor,_name);
    };
	case civilian: {
	    SETMPVAR(TeamName_Civ,_name);
    };
    default {};
};

GVAR(Teams) pushBack [_name, _side, _type,  0, 0, [], []];