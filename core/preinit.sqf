#define preinit

#include "script_macros.hpp"

// debug settings
if (
    isMultiplayer &&
    {(toLower serverName) find "main" isNotEqualTo -1}
) then {
    GVAR(testingDisableFriendlyAI) = false;
} else {
    GVAR(testingDisableFriendlyAI) = ([missionConfigFile >> QGVAR(debugSettings) >> "testingDisableFriendlyAI", "number", 0] call CBA_fnc_getConfigEntry) == 1;
};

// gear settings
GVAR(force_remove_facewear) = ([missionConfigFile >> QGVAR(gearSettings) >> "forceRemoveFacewear", "number", 0] call CBA_fnc_getConfigEntry) == 1;
GVAR(enableOverfill) = ([missionConfigFile >> QGVAR(gearSettings) >> "testingDisableFriendlyAI", "number", 1] call CBA_fnc_getConfigEntry) == 1;
GVAR(removeAllGear) = ([missionConfigFile >> QGVAR(gearSettings) >> "testingDisableFriendlyAI", "number", 1] call CBA_fnc_getConfigEntry) == 1;

// general settings
GVAR(loadingScreen) = ([missionConfigFile >> QGVAR(settings) >> "loadingScreen", "number", 1] call CBA_fnc_getConfigEntry) == 1;
ace_respawn_RemoveDeadBodiesDisconnected = ([missionConfigFile >> QGVAR(settings) >> "removeDeadBodiesDisconnected", "number", 0] call CBA_fnc_getConfigEntry) == 1;

// ITC settings
ITC_LAND_CIWS_INTERCEPTABLE = [missionConfigFile >> QGVAR(settings) >> "interceptableMissiles", "ARRAY", []] call CBA_fnc_getConfigEntry;

GVAR(DebugMessages) = [];
GVAR(Modules) = [];

["ace_firedPlayer", FUNC(firedEH)] call CBA_fnc_addEventHandler;
["ace_firedPlayerVehicle", FUNC(firedEH)] call CBA_fnc_addEventHandler;
["ace_firedNonPlayer", FUNC(firedEH)] call CBA_fnc_addEventHandler;
["ace_firedNonPlayerVehicle", FUNC(firedEH)] call CBA_fnc_addEventHandler;

#include "..\customization\inits\PreInitGlobal.sqf" //DO NOT REMOVE
#include "..\modules\modules.sqf" //DO NOT REMOVE
