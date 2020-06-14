#include "..\..\script_macros.hpp"

LOG("HC Client Pre Init");

private _version = "0.2.4";

["Headless AI", "Spawns AI via logic sync and provides custom AI system", "PIZZADOX", _version] call FUNC(RegisterModule);

//[QGVAR(ClientEvent), {
//
//}] call CBA_fnc_addEventHandler;

AI_EXEC_CHECK(HC);

[] call FUNC(initMain);
