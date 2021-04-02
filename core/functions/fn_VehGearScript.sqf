#include "script_component.hpp"

#define random(MIN, MAX) RNDRANGE(var1,var2)

params ["_vehicle", "_type"];

if !(local _vehicle) exitWith {};
    
if (GETMVAR(removeVehicleGear,true)) then {
	[] call FUNC(removeAllVehicleGear);
};

FUNC(AddItemVehicle) = {([_vehicle, _type] + _this) call FUNC(AddItemVehicleOrg);};
FUNC(AddItemVehicleRandom) = {([[_vehicle, _type]] + [_this]) call FUNC(AddItemVehicleRandomOrg);};

#include "..\..\customization\vehGearSettings.sqf"