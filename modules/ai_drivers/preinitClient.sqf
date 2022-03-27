#include "script_component.hpp"

private _version = 0.3;

["AI drivers", "Adds AI commanded by players as drivers to vehicles.", "BlackHawk &amp; PiZZADOX", _version] call FUNC(RegisterModule);

GVAR(selectVehicles) = [missionConfigFile >> QGVAR(settings) >> "selectVehicles", "array", []] call CBA_fnc_getConfigEntry;
GVAR(VehicleClasses) = [missionConfigFile >> QGVAR(settings) >> "VehicleClasses", "array", []] call CBA_fnc_getConfigEntry;
GVAR(AllTanks) = ([missionConfigFile >> QGVAR(settings) >> "AllTanks", "number", 1] call CBA_fnc_getConfigEntry) == 1;
GVAR(AllCars) = ([missionConfigFile >> QGVAR(settings) >> "AllCars", "number", 1] call CBA_fnc_getConfigEntry) == 1;
GVAR(AllShips) = ([missionConfigFile >> QGVAR(settings) >> "AllShips", "number", 1] call CBA_fnc_getConfigEntry) == 1;
GVAR(NVGAction) = ([missionConfigFile >> QGVAR(settings) >> "NVGAction", "number", 1] call CBA_fnc_getConfigEntry) == 1;
GVAR(FlipAction) = ([missionConfigFile >> QGVAR(settings) >> "FlipAction", "number", 1] call CBA_fnc_getConfigEntry) == 1;
