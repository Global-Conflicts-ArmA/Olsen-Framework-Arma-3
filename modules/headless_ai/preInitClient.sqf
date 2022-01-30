#include "script_component.hpp"

LOG("HC Client Pre Init");

private _version = "0.2.5";

["Headless AI", "Spawns AI via logic sync and provides custom AI system", "PIZZADOX", _version] call EFUNC(FW,RegisterModule);

//[QGVAR(ClientEvent), {
//
//}] call CBA_fnc_addEventHandler;

AI_EXEC_CHECK(HC);

GVAR(spawnGroupPFH) = -1;
GVAR(spawnQueue) = [];
GVAR(spawnUnitsQueue) = [];
GVAR(spawnUnitsQueueActiveGroup) = [];

//Ask server for entities data
if (isMultiplayer) then {
	[QGVAR(HCRequestArrayDataEvent), clientOwner] call CBA_fnc_serverEvent;
	[{
	    (GETMVAR(receivedArrayData,false))
	},{
	    [] call FUNC(initMain);
	}] call CBA_fnc_waitUntilAndExecute;
} else {
	[] call FUNC(initMain);
};
