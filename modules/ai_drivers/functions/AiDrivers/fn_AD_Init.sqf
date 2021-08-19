#include "script_component.hpp"

if (!(hasinterface) || {is3DEN}) exitwith {};

//contains _AOMarkers array
#include "..\..\settings.sqf"

vehicles select {
    private _veh = _x;

    (str _veh) in GVAR(AiDriversVehicles) ||
    {(GVAR(AiDriversAllTanks) && {(_veh isKindOf "Tank")})} ||
    {(GVAR(AiDriversAllShips) && {(_veh isKindOf "Ship")})} ||
    {(GVAR(AiDriversAllCars) && {(_veh isKindOf "Car")})} ||
    {(GVAR(AiDriversVehicleClasses) findIf {_veh isKindOf _x}) > -1}
} apply {
    _x call FUNC(AD_EnableAIDriver)
};
