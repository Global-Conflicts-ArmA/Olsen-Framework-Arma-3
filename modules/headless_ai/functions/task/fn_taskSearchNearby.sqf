#include "script_component.hpp"


params ["_group"];

_group = _group call CBA_fnc_getGroup;
if !(local _group) exitWith {}; // Don't create waypoints on each machine
private _leader = leader _group;

private _buildings = nearestObjects [_leader, ["House", "Building"], 50, true];
if (_buildings isEqualTo []) exitWith {};
private _screenedBuildings = _buildings select {((count ([_x] call BIS_fnc_buildingPositions)) >= 2) && {(CBA_missionTime - (GETVAR(_x,searched,CBA_missionTime - 600))) >= 600}};
if (_screenedBuildings isEqualTo []) exitWith {};

//private _building = selectRandom _screenedBuildings;
private _building = _screenedBuildings select 0;

[_group, _building] call FUNC(searchBuilding);