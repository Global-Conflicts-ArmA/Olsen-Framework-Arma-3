#define preInitServer

#include "script_macros.hpp"

GVAR(Teams) = []; //DO NOT REMOVE
GVAR(TeamSides) = []; //DO NOT REMOVE
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

[QGVAR(SC_CountEvent), {
    params ["_side", "_magazine"];
    private _magName = _magazine call FUNC(SC_getDisplayName);
	[_side, _magName] call FUNC(SC_shotCount);
}] call CBA_fnc_addEventHandler;

GVAR(SC_west_ExpendedAmmo) = [];
GVAR(SC_east_ExpendedAmmo) = [];
GVAR(SC_ind_ExpendedAmmo) = [];
GVAR(SC_civ_ExpendedAmmo) = [];
GVAR(SC_classNames) = [];

#include "..\customization\serverSettings.sqf" //DO NOT REMOVE
#include "..\customization\inits\PreInitServer.sqf" //DO NOT REMOVE
#include "..\modules\modules.sqf" //DO NOT REMOVE
