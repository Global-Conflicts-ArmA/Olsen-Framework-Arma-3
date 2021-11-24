#include "script_component.hpp"

params [
	["_callID", "", [""]],
	["_reqAdmin", false, [false]]
];

if (_reqAdmin && !GVAR(IsAdmin)) exitWith {
	hint "Only server admins may use this feature!";
};

["frameworkCallMission", [player, _callID]] call CBA_fnc_globalEvent;
