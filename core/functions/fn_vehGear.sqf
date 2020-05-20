#include "script_component.hpp"

#define random(MIN, MAX) \
([MIN, MAX] call FUNC(RandomRange))

params ["_vehicle", "_type"];

if !(local _vehicle) exitWith {};

FUNC(AddItemVehicle) = {([_vehicle, _type] + _this) call FUNC(AddItemVehicleOrg);};
FUNC(AddItemVehicleRandom) = {([[_vehicle, _type]] + [_this]) call FUNC(AddItemVehicleRandomOrg);};

#include "..\..\customization\vehGearSettings.sqf"