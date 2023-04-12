#include "script_component.hpp"

private _version = 1.0;

["Self actions", "Allows players to check their own team color, view other's maps and cut grass.", "TinfoilHate, StatusRed &amp; PiZZADOX", _version] call FUNC(RegisterModule);

GVAR(TeamColourCheck) = ([missionConfigFile >> QGVAR(settings) >> "TeamColourCheck", "number", 1] call CBA_fnc_getConfigEntry) == 1;
GVAR(MapViewing) = ([missionConfigFile >> QGVAR(settings) >> "MapViewing", "number", 1] call CBA_fnc_getConfigEntry) == 1;
GVAR(GrassCutting) = ([missionConfigFile >> QGVAR(settings) >> "GrassCutting", "number", 1] call CBA_fnc_getConfigEntry) == 1;
GVAR(GrassCuttingLarge) = ([missionConfigFile >> QGVAR(settings) >> "GrassCuttingLarge", "number", 1] call CBA_fnc_getConfigEntry) == 1;

GVAR(SipDrink) = ([missionConfigFile >> QGVAR(settings) >> "SipDrink", "number", 1] call CBA_fnc_getConfigEntry) == 1;
GVAR(SipDrinkRequireItem) = ([missionConfigFile >> QGVAR(settings) >> "SipDrinkRequireItem", "number", 1] call CBA_fnc_getConfigEntry) == 1;
