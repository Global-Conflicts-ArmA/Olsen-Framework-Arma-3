#include "script_component.hpp"
params ["_unit"];


if (_unit isKindOf "CAManBase") exitWith {GVAR(playerInventorySize)};

private _size = [missionConfigFile >> "CfgGradFortifications" >> "Vehicles" >> typeOf _unit,"vehicleInventorySize",-1] call BIS_fnc_returnConfigEntry;

if (_size < 0) then {
    _size = GVAR(vehicleInventorySizeFactor) * 15 * ([configFile >> "CfgVehicles" >> typeOf _unit,"ace_cargo_space",-1] call BIS_fnc_returnConfigEntry);
};

if (_size < 0) then {
    _size = GVAR(vehicleInventorySizeFactor) * 15 * ([configFile >> "CfgVehicles" >> typeOf _unit,"ace_cargo_size",-1] call BIS_fnc_returnConfigEntry);
};

if (_size < 0) then {
    _size = GVAR(vehicleInventorySizeFactor) * 0.015 * ([configFile >> "CfgVehicles" >> typeOf _unit,"maximumLoad",0] call BIS_fnc_returnConfigEntry);
};

_size
