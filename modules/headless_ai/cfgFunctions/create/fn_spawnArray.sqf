#include "..\..\script_macros.hpp"

LOG_1("Executed spawnarray _Array: %1",_this);

if (!isMultiplayer) then {
    LOG("!isMultiplayer, createZone function executed");
    [QGVAR(SpawnArrayEvent), _this] call CBA_fnc_localEvent;
} else {
    LOG_1("sending createZone function to clientid %1",GVAR(HC_ID));
    [QGVAR(SpawnArrayEvent), _this, GVAR(HC_ID)] call CBA_fnc_ownerEvent;
};
