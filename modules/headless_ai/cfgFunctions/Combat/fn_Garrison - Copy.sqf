#include "..\..\script_macros.hpp"


private ["_nBuilding", "_Buildingarray" , "_GrabVariable", "_GroupUnits", "_BuildingPositions" , "_BuildingLocation", "_CurrentPos", "_rnd", "_dist", "_dir", "_positions"];
//Created on ???
// Modified on :8/15/14 - 8/3/15 - 9/10/15

params ["_Unit","_group","_wp"];

_wpPos = waypointPosition [_group, _wp];

//Lets find the closest building
//_nBuilding = nearestBuilding _wpPos;
_Buildingarray = nearestObjects [_wpPos, ["House", "Building"], 100];

if (count _Buildingarray < 1) exitwith {[_Unit, _Unit, 200] call CBA_fnc_taskPatrol;};

//Lets find out if the unit is already garrisoned or not. If he is, exit the script
_GrabVariable = GETVAR(_Unit,GARRISONED,false);

_BuildingPositions = [];

//If the closest building is greate than 100 meters, exit
//if ((_nBuilding distance _wpPos) > 100 || {_GrabVariable}) exitWith {};

{
	private _tempBuildingPositions = [_x] call BIS_fnc_buildingPositions;
	if (count _tempBuildingPositions > 2) then {
		_BuildingPositions = _BuildingPositions + _tempBuildingPositions;
	};
} foreach _Buildingarray;

//debug show collected positions
if (GVAR(UseMarkers)) then {
	{
		"Sign_Arrow_F" createvehicle [_x select 0, _x select 1, (_x select 2) + 0.5];
	} foreach _BuildingPositions;
};

//Find positions in a house.
//_BuildingPositions = [_nBuilding] call BIS_fnc_buildingPositions;
//private _OriginalPositions = _BuildingPositions;

//If the array is not more than 0 - then exit.
if ((count _BuildingPositions) isEqualTo 0) exitWith {[_Unit, _Unit, 200] call CBA_fnc_taskPatrol;};

//Find the units in the group!
_GroupUnits = units _group;

[_BuildingPositions, true] call CBA_fnc_shuffle;

{
	//_BuildingLocation = selectRandom _BuildingPositions;
	//_BuildingPositions = _BuildingPositions - [_BuildingLocation];
	_BuildingLocation = _BuildingPositions select _foreachindex;
	_x doMove _BuildingLocation;
	SETVAR(_x,GARRISONED,true);
	[_x,_BuildingLocation,_BuildingPositions] spawn {
		params ["_unit","_BuildingLocation","_BuildingPositions"];
		private _group	= group _Unit;
		private _index = currentWaypoint _group;
		private _WaypointIs = waypointType [_group,_index];
		if (PZAI_GarrisonPatrol) then {
			while {_WaypointIs isEqualTo "HOLD"} do {
				waitUntil {_unit distance _BuildingLocation < 1.3};
				_unit disableAI "PATH";
				//_unit forcespeed 0;
				sleep (120 + (random 60));
				_unit enableAI "PATH";
				//_unit forcespeed -1;
				_BuildingLocation = selectRandom _BuildingPositions;
				_unit doMove _BuildingLocation;
				_unit setUnitPos "UP";
			};
		} else {
			waitUntil {_unit distance _BuildingLocation < 1.3};
			_unit disableAI "PATH";
			_unit setUnitPos "UP";
		};
	};
} foreach _GroupUnits;
