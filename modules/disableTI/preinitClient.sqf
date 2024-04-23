#include "script_component.hpp"

private _version = 0.1;

["Disable TI", "Disables thermals for a range of vehicle selection", "PiZZADOX", _version] call EFUNC(FW,RegisterModule);

GVAR(selectVehicles) = [missionConfigFile >> QGVAR(settings) >> "selectVehicles", "array", []] call CBA_fnc_getConfigEntry;
GVAR(VehicleClasses) = [missionConfigFile >> QGVAR(settings) >> "VehicleClasses", "array", []] call CBA_fnc_getConfigEntry;
GVAR(AllTanks) = ([missionConfigFile >> QGVAR(settings) >> "AllTanks", "number", 1] call CBA_fnc_getConfigEntry) == 1;
GVAR(AllCars) = ([missionConfigFile >> QGVAR(settings) >> "AllCars", "number", 1] call CBA_fnc_getConfigEntry) == 1;
GVAR(AllShips) = ([missionConfigFile >> QGVAR(settings) >> "AllShips", "number", 1] call CBA_fnc_getConfigEntry) == 1;
