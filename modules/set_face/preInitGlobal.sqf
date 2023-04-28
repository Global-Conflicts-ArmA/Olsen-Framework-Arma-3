#include "script_component.hpp"

GVAR(Blufor_SetFaces) = ([missionConfigFile >> QGVAR(settings) >> "blufor" >> "setFaces", "boolean", 1] call CBA_fnc_getConfigEntry) isEqualTo 1;
GVAR(Blufor_RegularFaces) = [missionConfigFile >> QGVAR(settings) >> "blufor" >> "regular_faces", "array", []] call CBA_fnc_getConfigEntry;
GVAR(Blufor_SpecialFaces) = [missionConfigFile >> QGVAR(settings) >> "blufor" >> "special_faces", "array", []] call CBA_fnc_getConfigEntry;
GVAR(Blufor_SpecialUnits) = [missionConfigFile >> QGVAR(settings) >> "blufor" >> "special_units", "array", []] call CBA_fnc_getConfigEntry apply {
    missionNamespace getVariable [_x, objNull]
};
GVAR(Blufor_ExceptionUnits) = [missionConfigFile >> QGVAR(settings) >> "blufor" >> "exception_units", "array", []] call CBA_fnc_getConfigEntry apply {
    missionNamespace getVariable [_x, objNull]
};

GVAR(Opfor_SetFaces) = ([missionConfigFile >> QGVAR(settings) >> "opfor" >> "setFaces", "boolean", 1] call CBA_fnc_getConfigEntry) isEqualTo 1;
GVAR(Opfor_RegularFaces) = [missionConfigFile >> QGVAR(settings) >> "opfor" >> "regular_faces", "array", []] call CBA_fnc_getConfigEntry;
GVAR(Opfor_SpecialFaces) = [missionConfigFile >> QGVAR(settings) >> "opfor" >> "special_faces", "array", []] call CBA_fnc_getConfigEntry;
GVAR(Opfor_SpecialUnits) = [missionConfigFile >> QGVAR(settings) >> "opfor" >> "special_units", "array", []] call CBA_fnc_getConfigEntry apply {
    missionNamespace getVariable [_x, objNull]
};
GVAR(Opfor_ExceptionUnits) = [missionConfigFile >> QGVAR(settings) >> "opfor" >> "exception_units", "array", []] call CBA_fnc_getConfigEntry apply {
    missionNamespace getVariable [_x, objNull]
};

GVAR(Indfor_SetFaces) = ([missionConfigFile >> QGVAR(settings) >> "indfor" >> "setFaces", "boolean", 1] call CBA_fnc_getConfigEntry) isEqualTo 1;
GVAR(Indfor_RegularFaces) = [missionConfigFile >> QGVAR(settings) >> "indfor" >> "regular_faces", "array", []] call CBA_fnc_getConfigEntry;
GVAR(Indfor_SpecialFaces) = [missionConfigFile >> QGVAR(settings) >> "indfor" >> "special_faces", "array", []] call CBA_fnc_getConfigEntry;
GVAR(Indfor_SpecialUnits) = [missionConfigFile >> QGVAR(settings) >> "indfor" >> "special_units", "array", []] call CBA_fnc_getConfigEntry apply {
    missionNamespace getVariable [_x, objNull]
};
GVAR(Indfor_ExceptionUnits) = [missionConfigFile >> QGVAR(settings) >> "indfor" >> "exception_units", "array", []] call CBA_fnc_getConfigEntry apply {
    missionNamespace getVariable [_x, objNull]
};

GVAR(Civilian_SetFaces) = ([missionConfigFile >> QGVAR(settings) >> "civilian" >> "setFaces", "boolean", 1] call CBA_fnc_getConfigEntry) isEqualTo 1;
GVAR(Civilian_RegularFaces) = [missionConfigFile >> QGVAR(settings) >> "civilian" >> "regular_faces", "array", []] call CBA_fnc_getConfigEntry;
GVAR(Civilian_SpecialFaces) = [missionConfigFile >> QGVAR(settings) >> "civilian" >> "special_faces", "array", []] call CBA_fnc_getConfigEntry;
GVAR(Civilian_SpecialUnits) = [missionConfigFile >> QGVAR(settings) >> "civilian" >> "special_units", "array", []] call CBA_fnc_getConfigEntry apply {
    missionNamespace getVariable [_x, objNull]
};
GVAR(Civilian_ExceptionUnits) = [missionConfigFile >> QGVAR(settings) >> "civilian" >> "exception_units", "array", []] call CBA_fnc_getConfigEntry apply {
    missionNamespace getVariable [_x, objNull]
};
