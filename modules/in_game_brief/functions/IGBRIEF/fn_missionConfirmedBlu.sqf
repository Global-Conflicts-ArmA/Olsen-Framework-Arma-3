#include "script_component.hpp"

BlueBoard removeAction GVAR(confirmedBlu);
BlueBoard removeAction GVAR(canceledBlu);

[-2, {hint "Blufor has signaled they are ready to begin!";}] call CBA_fnc_globalExecute;

GVAR(bluforIsReady) = True;
BlueBoard hideObjectGlobal true;
deleteVehicle BlueBoard;
