#include "script_component.hpp"

RedBoard removeAction GVAR(confirmedRed);
RedBoard removeAction GVAR(canceledRed);

[-2, {hint "Opfor has signaled they are ready to begin!";}] call CBA_fnc_globalExecute;

SETMVAR(opforIsReady, True);
RedBoard hideObjectGlobal true;
[RedBoard] remoteExec ["deleteVehicle", 2];
