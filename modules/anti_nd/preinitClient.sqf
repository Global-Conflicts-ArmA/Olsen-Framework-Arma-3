#include "script_component.hpp"

private _version = 1.0;

["Anti ND", "Prevents negligent discharges at spawn.", "Starfox64, PIZZADOX &amp; StatusRed", _version] call EFUNC(FW,RegisterModule);

GVAR(BLUFOR_Time) = [missionConfigFile >> QGVAR(settings) >> "BLUFOR" >> "time", "number", 30] call CBA_fnc_getConfigEntry;
GVAR(BLUFOR_Distance) = [missionConfigFile >> QGVAR(settings) >> "BLUFOR" >> "distance", "number", 200] call CBA_fnc_getConfigEntry;
GVAR(OPFOR_Time) = [missionConfigFile >> QGVAR(settings) >> "OPFOR" >> "time", "number", 30] call CBA_fnc_getConfigEntry;
GVAR(OPFOR_Distance) = [missionConfigFile >> QGVAR(settings) >> "OPFOR" >> "distance", "number", 200] call CBA_fnc_getConfigEntry;
GVAR(INDFOR_Time) = [missionConfigFile >> QGVAR(settings) >> "INDFOR" >> "time", "number", 30] call CBA_fnc_getConfigEntry;
GVAR(INDFOR_Distance) = [missionConfigFile >> QGVAR(settings) >> "INDFOR" >> "distance", "number", 200] call CBA_fnc_getConfigEntry;
GVAR(CIV_Time) = [missionConfigFile >> QGVAR(settings) >> "CIV" >> "time", "number", 30] call CBA_fnc_getConfigEntry;
GVAR(CIV_Distance) = [missionConfigFile >> QGVAR(settings) >> "CIV" >> "distance", "number", 200] call CBA_fnc_getConfigEntry;

[] call FUNC(Init);
