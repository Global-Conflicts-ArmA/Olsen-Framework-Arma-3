#include "script_component.hpp"

if (!isServer) exitWith {};

params [
    ["_class", "", [""]],
    ["_spawnLoc", ""],
    ["_alt", 15, [15]],
    ["_landLoc", ""],
    ["_waitFor", blufor],
    ["_extractLoc", ""],
    ["_vehInit", "", [""]]
];

private _spawnPos = nil;
private _landPos = nil;
private _extractPos = nil;
private _isHelicopter = false;

if ("" isEqualType _spawnLoc) then {
  _spawnPos = getMarkerPos _spawnLoc;
} else {
  _spawnPos = getPos _spawnLoc;
};

if ("" isEqualType _landLoc) then {
  _landPos = getMarkerPos _landLoc;
} else {
  _landPos = getPos _landLoc;
};

if ("" isEqualType _extractLoc) then {
  _extractPos = getMarkerPos _extractLoc;
} else {
  _extractPos = getPos _extractLoc;
};

private _veh = createVehicle [_class, _spawnPos, [], 0, "FLY"];
createVehicleCrew _veh;

_veh setCaptive true;
_veh allowDamage false;

if (_vehInit isNotEqualTo "") then {
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
    if (blufor isEqualType _waitFor2) then {
      if ([_veh2, _waitFor2] call FUNC(EXTRACT_CheckSideInVeh)) then {_nowExtract = true};
    };

    if (objNull isEqualType _waitFor2) then {
      if (_waitFor2 in _veh2 || !(_waitFor2 call FUNC(isAlive))) then {_nowExtract = true};
    };

    if ([] isEqualType _waitFor2) then {
      if ([_veh2, _waitFor2] call FUNC(EXTRACT_CheckArrayInVeh)) then {_nowExtract = true};
    };

    if ("" isEqualType _waitFor2) then {
      if (_veh2 call compile _waitFor2) then {_nowExtract = true};
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
