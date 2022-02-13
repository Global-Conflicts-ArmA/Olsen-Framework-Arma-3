#include "script_component.hpp"

BlueBoard removeAction GVAR(confirmedBlu);
BlueBoard removeAction GVAR(canceledBlu);

["Blufor has signaled they are ready to begin!"] remoteExec ["hint"];

SETMPVAR(bluforIsReady, True);
[Blueboard, true] remoteExec ["hideObjectGlobal", 2];
[Blueboard] remoteExec ["deleteVehicle", 2];
