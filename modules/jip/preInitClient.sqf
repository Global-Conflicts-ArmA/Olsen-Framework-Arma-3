#include "script_component.hpp"

private _version = 0.4;

["JIP Manager", "Handles JIPs in different ways depending on the module's settings.", "Olsen, Starfox64, StatusRed &amp; PiZZADOX", _version] call EFUNC(FW,RegisterModule);

GVAR(west_type) = toUpper ([missionConfigFile >> QGVAR(settings) >> "west" >> "type", "string", "TELEPORT"] call CBA_fnc_getConfigEntry);
GVAR(west_distance) = [missionConfigFile >> QGVAR(settings) >> "west" >> "distance", "number", 50] call CBA_fnc_getConfigEntry;
GVAR(west_spawnDistance) = [missionConfigFile >> QGVAR(settings) >> "west" >> "spawnDistance", "number", 200] call CBA_fnc_getConfigEntry;
GVAR(west_dismountVehicles) = [missionConfigFile >> QGVAR(settings) >> "west" >> "dismountVehicles", "boolean", true] call CBA_fnc_getConfigEntry;

GVAR(east_type) = toUpper ([missionConfigFile >> QGVAR(settings) >> "east" >> "type", "string", "TELEPORT"] call CBA_fnc_getConfigEntry);
GVAR(east_distance) = [missionConfigFile >> QGVAR(settings) >> "east" >> "distance", "number", 50] call CBA_fnc_getConfigEntry;
GVAR(east_spawnDistance) = [missionConfigFile >> QGVAR(settings) >> "east" >> "spawnDistance", "number", 200] call CBA_fnc_getConfigEntry;
GVAR(east_dismountVehicles) = [missionConfigFile >> QGVAR(settings) >> "east" >> "dismountVehicles", "boolean", true] call CBA_fnc_getConfigEntry;

GVAR(independent_type) = toUpper ([missionConfigFile >> QGVAR(settings) >> "independent" >> "type", "string", "TELEPORT"] call CBA_fnc_getConfigEntry);
GVAR(independent_distance) = [missionConfigFile >> QGVAR(settings) >> "independent" >> "distance", "number", 50] call CBA_fnc_getConfigEntry;
GVAR(independent_spawnDistance) = [missionConfigFile >> QGVAR(settings) >> "independent" >> "spawnDistance", "number", 200] call CBA_fnc_getConfigEntry;
GVAR(independent_dismountVehicles) = [missionConfigFile >> QGVAR(settings) >> "independent" >> "dismountVehicles", "boolean", true] call CBA_fnc_getConfigEntry;

GVAR(civilian_type) = toUpper ([missionConfigFile >> QGVAR(settings) >> "civilian" >> "type", "string", "TELEPORT"] call CBA_fnc_getConfigEntry);
GVAR(civilian_distance) = [missionConfigFile >> QGVAR(settings) >> "civilian" >> "distance", "number", 50] call CBA_fnc_getConfigEntry;
GVAR(civilian_spawnDistance) = [missionConfigFile >> QGVAR(settings) >> "civilian" >> "spawnDistance", "number", 200] call CBA_fnc_getConfigEntry;
GVAR(civilian_dismountVehicles) = [missionConfigFile >> QGVAR(settings) >> "civilian" >> "dismountVehicles", "boolean", true] call CBA_fnc_getConfigEntry;
