#include "..\..\script_macros.hpp"


params ["_unit", ["_distance", 50, [50]]];

private _nearbyInfantry = (_unit nearEntities ["CAManBase", _distance]) select {side commander _x isEqualTo _unit};
private _nearbyCars = (_unit nearEntities ["Car", _distance]) select {side commander _x isEqualTo _unit};;
private _nearbyAPCs = (_unit nearEntities [["TrackedAPC", "WheeledAPC"], _distance]) select {side commander _x isEqualTo _unit};;
private _nearbyTanks = (_unit nearEntities ["Tank", _distance]) select {side commander _x isEqualTo _unit};;

private _nearbyEntities = [_nearbyInfantry, _nearbyCars, _nearbyAPCs, _nearbyTanks];

_nearbyEntities


