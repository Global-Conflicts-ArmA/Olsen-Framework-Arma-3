#include "script_component.hpp"

if (!isServer) exitWith {};

private _class = _this select 0;
private _spawnLoc = _this select 1;
private _alt = _this select 2;
private _landLoc = _this select 3;
private _waitFor = _this select 4;
private _extractLoc = _this select 5;
private _vehInit = nil;

private _spawnPos = nil;
private _landPos = nil;
private _extractPos = nil;
private _isHelicopter = false;

if (count _this > 6) then {
  _vehInit = _this select 6;
};

switch (typeName _spawnLoc) do {
  case "STRING": {_spawnPos = getMarkerPos _spawnLoc};
  case "OBJECT": {_spawnPos = getPos _spawnLoc};
};

switch (typeName _landLoc) do {
  case "STRING": {_landPos = getMarkerPos _landLoc};
  case "OBJECT": {_landPos = getPos _landLoc};
};

switch (typeName _extractLoc) do {
  case "STRING": {_extractPos = getMarkerPos _extractLoc};
  case "OBJECT": {_extractPos = getPos _extractLoc};
};

private _veh = createVehicle [_class, _spawnPos, [], 0, "FLY"];
createVehicleCrew _veh;

_veh setCaptive true;
_veh allowDamage false;

if (!isNil "_vehInit") then {
  _veh call compile _vehInit;
};

if (_veh isKindOf "Air") then {
  _isHelicopter = true;
};

private _wpLand = (group driver _veh) addWaypoint [_landPos, 0];
_wpLand setWaypointbehaviour "CARELESS";
_wpLand setWaypointCombatMode "BLUE";

if (_isHelicopter) then {
  _veh flyInHeight _alt;

  _wpLand setWaypointType "SCRIPTED";
  _wpLand setWaypointScript getText (configFile >> "CfgWaypoints" >> "A3" >> "Land" >> "file");
} else {
  _wpLand setWaypointType "LOAD";
};

private _delay = 5;
[{
  params ["_args", "_idPFH"];

  private _veh = _args select 0;
  private _waitFor = _args select 1;
  private _extractPos = _args select 2;

  [{
    private _veh2 = _this select 0;
    private _waitFor2 = _this select 1;
    private _extractPos2 = _this select 2;
    private _pfhID = _this select 3;

    private _nowExtract = false;

      switch (typeName _waitFor2) do {
        case "SIDE": {if ([_veh2, _waitFor2] call FUNC(EXTRACT_CheckSideInVeh)) then {_nowExtract = true}};
        case "OBJECT": {if (_waitFor2 in _veh2 || !(_waitFor2 call FUNC(isAlive))) then {_nowExtract = true}};
        case "ARRAY": {if ([_veh2, _waitFor2] call FUNC(EXTRACT_CheckArrayInVeh)) then {_nowExtract = true}};
        case "STRING": {if (_veh2 call compile _waitFor2) then {_nowExtract = true}};
      };

      if (_nowExtract) then {
        private _wpExtract = (group driver _veh2) addWaypoint [_extractPos2, 0];
        _wpExtract setWaypointType "LOITER";
        _wpExtract setWaypointSpeed "FULL";

        [_pfhID] call CBA_fnc_removePerFrameHandler;
      };
  }, [_veh, _waitFor, _extractPos, _idPFH], 1] call CBA_fnc_waitAndExecute;
}, _delay, [_veh, _waitFor, _extractPos]] call CBA_fnc_addPerFrameHandler;

_veh;
