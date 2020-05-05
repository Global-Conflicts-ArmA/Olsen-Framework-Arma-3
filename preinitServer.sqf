#define preinitServer

#include "core\script_macros.hpp"

FW_Teams = []; //DO NOT REMOVE
FW_MissionEnded = false; //Mission has not ended

["FW_eventSpawned", {
    params ["_unit"];
    _unit setVariable ["FW_Side", side _unit];
	_unit setVariable ["FW_Tracked", true];
	_unit call FNC_EventSpawned;
}] call CBA_fnc_addEventHandler;

["FW_eventUntrack", {
    params ["_unit"];
	_unit call FNC_untrackUnit;
}] call CBA_fnc_addEventHandler;

["FW_eventKilled", {
    params [["_unit", objNull, [objNull]], ["_killer", objNull, [objNull]]];
	[_unit, _killer] call FNC_EventKilled;
}] call CBA_fnc_addEventHandler;

#include "modules\modules.sqf" //DO NOT REMOVE