#define preinitServer

#include "core\script_macros.hpp"

GVAR(Teams) = []; //DO NOT REMOVE
GVAR(MissionEnded) = false; //Mission has not ended

[QGVAR(eventSpawned), {
    params ["_unit"];
	_unit call FUNC(trackUnit);
}] call CBA_fnc_addEventHandler;

[QGVAR(eventUntrack), {
    params ["_unit"];
	_unit call FUNC(untrackUnit);
}] call CBA_fnc_addEventHandler;

[QGVAR(eventKilled), {
    params [["_unit", objNull, [objNull]], ["_killer", objNull, [objNull]]];
	[_unit, _killer] call FUNC(EventKilled);
}] call CBA_fnc_addEventHandler;

[QGVAR(eventRespawn), {
    params [["_unit", objNull, [objNull]]];
	[_unit] call FUNC(EventRespawned);
}] call CBA_fnc_addEventHandler;

#include "customization\teamsettings.sqf" //DO NOT REMOVE
#include "modules\modules.sqf" //DO NOT REMOVE
