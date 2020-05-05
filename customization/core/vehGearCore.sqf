#include "..\..\core\script_macros.hpp"

#define random(MIN, MAX) \
([MIN, MAX] call FUNC(RandomRange))

params ["_vehicle", "_type"];

if !(local _vehicle) exitWith {};

FNC_AddItemVehicle = {([_vehicle, _type] + _this) call FUNC(AddItemVehicleOrg);};
FNC_AddItemVehicleRandom = {([[_vehicle, _type]] + [_this]) call FUNC(AddItemVehicleRandomOrg);};