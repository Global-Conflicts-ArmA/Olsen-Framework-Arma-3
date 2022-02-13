#include "script_component.hpp"

RedBoard removeAction GVAR(confirmedRed);
RedBoard removeAction GVAR(canceledRed);

["Opfor has signaled they are ready to begin!"] remoteExec ["hint"];

SETMPVAR(opforIsReady, True);
[RedBoard, true] remoteExec ["hideObjectGlobal", 2];
[RedBoard] remoteExec ["deleteVehicle", 2];
