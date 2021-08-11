#include "script_component.hpp"

params ["_vehicle"];

if ((GVAR(boostLastUsed) + GVAR(vehicleBoostDelay)) > CBA_MissionTime) exitWith {};

private _vel = velocity _vehicle;
private _dir = direction _vehicle;
_vehicle setVelocity [
  (_vel select 0) + (sin _dir * GVAR(vehicleBoostSpeed)),
  (_vel select 1) + (cos _dir * GVAR(vehicleBoostSpeed)),
  (_vel select 2)
];

GVAR(boostLastUsed) = CBA_MissionTime;
