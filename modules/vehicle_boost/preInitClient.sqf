#include "script_component.hpp"

private _version = 0.2;

["Vehicle Boost", "Module to provide boost functionality to vehicles.", "StatusRed &amp; PiZZADOX", _version] call FUNC(RegisterModule);

GVAR(BoostNamespace) = createHashMap;
GVAR(BoostClasses) = [];

"true" configClasses (missionConfigFile >> QGVAR(Settings) >> "VehBoostParams") apply {
    private _maxSpeedInWater = [_x, "maxSpeedInWater", -1] call BIS_fnc_returnConfigEntry;
    private _maxSpeed = [_x, "maxSpeed", -1] call BIS_fnc_returnConfigEntry;
    private _values = [_maxSpeed, _maxSpeedInWater];
    TRACE_2("resolving custom class vehicle boost",configName _x,_values);
    GVAR(BoostClasses) pushBackUnique (configName _x);
    GVAR(BoostNamespace) set [configName _x, _values];
};
