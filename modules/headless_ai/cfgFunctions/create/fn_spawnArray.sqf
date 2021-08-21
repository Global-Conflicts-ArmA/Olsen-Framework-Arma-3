#include "..\..\script_macros.hpp"


params [["_arrayName", "", [""]]];

LOG_1("Executed spawnarray _Array: %1",_arrayName);

if (!isMultiplayer) then {
    LOG("!isMultiplayer, createZone function executed");
    [QGVAR(SpawnArrayEvent), [_arrayName]] call CBA_fnc_localEvent;
} else {
    LOG_1("sending createZone function to clientid %1",GVAR(HC_ID));
    [QGVAR(SpawnArrayEvent), [_arrayName], GVAR(HC_ID)] call CBA_fnc_ownerEvent;
};
