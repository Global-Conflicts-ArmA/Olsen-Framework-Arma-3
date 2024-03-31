#include "script_component.hpp"

LOG("HC Client Pre Init");

private _version = "0.2.7";

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
[{GETMVAR(ArrayDataChecked,false)}, {
    params ["_clientOwner"];
    [QGVAR(HCRequestArrayDataEvent), _clientOwner] call CBA_fnc_serverEvent;
	[{
	    (GETMVAR(receivedArrayData,false))
	},{
	    [] call FUNC(initMain);
	}] call CBA_fnc_waitUntilAndExecute;
}, [clientOwner]] call CBA_fnc_waitUntilAndExecute;
