#define random(MIN, MAX) \
([MIN, MAX] call FNC_RandomRange)

params ["_vehicle", "_type"];

if !(local _vehicle) exitWith {};

FNC_AddItemVehicle = {([_vehicle, _type] + _this) call FNC_AddItemVehicleOrg;};
FNC_AddItemVehicleRandom = {([[_vehicle, _type]] + [_this]) call FNC_AddItemVehicleRandomOrg;};