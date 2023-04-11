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

if (!isMultiplayer && {_type == "player"}) then {
	_type = "both";
};

GVAR(TeamSides) pushBackUnique _side;
private _var =  switch _side do {
    case west: {
	    QGVAR(TeamName_Blufor)
    };
	case east: {
	    QGVAR(TeamName_Opfor)
    };
	case independent: {
	    QGVAR(TeamName_Indfor)
    };
	case civilian: {
	    QGVAR(TeamName_Civ)
    };
    default {
        QGVAR(TeamName_Blufor)
    };
};
missionNamespace setVariable [_var, _name, true];

GVAR(Teams) pushBack [_name, _side, _type,  0, 0, [], []];
