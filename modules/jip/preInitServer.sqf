#include "script_component.hpp"

GVAR(west_denyTime) = [missionConfigFile >> QGVAR(settings) >> "west" >> "denyTime", "number", 300] call CBA_fnc_getConfigEntry;
GVAR(east_DenyTime) = [missionConfigFile >> QGVAR(settings) >> "east" >> "denyTime", "number", 300] call CBA_fnc_getConfigEntry;
GVAR(independent_DenyTime) = [missionConfigFile >> QGVAR(settings) >> "independent" >> "denyTime", "number", 300] call CBA_fnc_getConfigEntry;
GVAR(civilian_DenyTime) = [missionConfigFile >> QGVAR(settings) >> "civilian" >> "denyTime", "number", 300] call CBA_fnc_getConfigEntry;

[{CBA_missionTime > GVAR(west_DenyTime)}, {
	missionNamespace setVariable [QGVAR(west_JIPDenied), true, true];
}, []] call CBA_fnc_waitUntilAndExecute;

[{CBA_missionTime > GVAR(east_DenyTime)}, {
	missionNamespace setVariable [QGVAR(east_JIPDenied), true, true];
}, []] call CBA_fnc_waitUntilAndExecute;

[{CBA_missionTime > GVAR(independent_DenyTime)}, {
	missionNamespace setVariable [QGVAR(independent_JIPDenied), true, true];
}, []] call CBA_fnc_waitUntilAndExecute;

[{CBA_missionTime > GVAR(civilian_DenyTime)}, {
	missionNamespace setVariable [QGVAR(civilian_JIPDenied), true, true];
}, []] call CBA_fnc_waitUntilAndExecute;
