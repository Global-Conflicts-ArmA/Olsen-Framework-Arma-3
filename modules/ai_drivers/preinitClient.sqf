#include "script_component.hpp"

private _version = 0.4;

["AI drivers", "Adds AI commanded by players as drivers to vehicles.", "BlackHawk &amp; PiZZADOX", _version] call EFUNC(FW,RegisterModule);

GVAR(selectVehicles) = [missionConfigFile >> QGVAR(settings) >> "selectVehicles", "array", []] call CBA_fnc_getConfigEntry;
GVAR(VehicleClasses) = [missionConfigFile >> QGVAR(settings) >> "VehicleClasses", "array", []] call CBA_fnc_getConfigEntry;
GVAR(AllTanks) = ([missionConfigFile >> QGVAR(settings) >> "AllTanks", "number", 1] call CBA_fnc_getConfigEntry) == 1;
GVAR(AllCars) = ([missionConfigFile >> QGVAR(settings) >> "AllCars", "number", 1] call CBA_fnc_getConfigEntry) == 1;
GVAR(AllShips) = ([missionConfigFile >> QGVAR(settings) >> "AllShips", "number", 1] call CBA_fnc_getConfigEntry) == 1;
GVAR(NVGAction) = ([missionConfigFile >> QGVAR(settings) >> "NVGAction", "number", 1] call CBA_fnc_getConfigEntry) == 1;
GVAR(FlipAction) = ([missionConfigFile >> QGVAR(settings) >> "FlipAction", "number", 1] call CBA_fnc_getConfigEntry) == 1;
GVAR(TestMode) = ([missionConfigFile >> QGVAR(settings) >> "TestMode", "number", 1] call CBA_fnc_getConfigEntry) == 1;

private _topDisplay = [missionConfigFile >> QGVAR(settings) >> "topDisplay", "array", [0.1,-0.22,0.5,0.25]] call CBA_fnc_getConfigEntry;
private _bottomDisplay = [missionConfigFile >> QGVAR(settings) >> "bottomDisplay", "array", [0.1,1,0.5,0.25]] call CBA_fnc_getConfigEntry;

uiNamespace setVariable [QGVAR(topDisplay), _topDisplay];
uiNamespace setVariable [QGVAR(bottomDisplay), _bottomDisplay];

if (isNil QGVAR(OpticsNamespace)) then {
    GVAR(OpticsNamespace) = createHashMap;
};

"true" configClasses (missionConfigFile >> QGVAR(Settings) >> "AIViewParams") apply {
    private _pos = [_x, "pos", [0,0,0]] call BIS_fnc_returnConfigEntry;
    private _vector = [_x, "targetPos", [0,0,0]] call BIS_fnc_returnConfigEntry;
    private _viewArray = [_pos, _vector];
    TRACE_2("resolving custom class AI Driver Pos",configName _x,_viewArray);
    GVAR(OpticsNamespace) set [configName _x, _viewArray];
};
