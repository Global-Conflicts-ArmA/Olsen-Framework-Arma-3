#include "..\..\script_macros.hpp"


params ["_Unit","_Group","","_thisFSM"];

SETVAR(_group,Task,"GARRISON");
SETVAR(_Group,InitialWPSet,true);

private _UnitLeader = _Unit;
private _nBuildingLst = nearestObjects [_UnitLeader, ["House", "Building"], 50];
private _nBuilding = [0,0,0];
private _BuildingPositions = [];
{
	_BuildingPositions = [_x] call BIS_fnc_buildingPositions;
	if ((count _BuildingPositions) > 2) exitWith {_nBuilding = _x;};
	true;
} count _nBuildingLst;


//If the closest building is greate than 50 meters, exit
if ((_nBuilding distance2D _UnitLeader) > 50) exitWith {};

//If the array is not more than 0 - then exit.

//Find the units in the group!
_GroupUnits = units _Group;
SETVAR(_Unit,GARRISONED,true);
SETVAR(_Group,GARRISONED,true);
private _WaypointIs = "HOLD";
while {_WaypointIs isEqualTo "HOLD"} do
{
	private _index = currentWaypoint _Group;
	private _WaypointIs = waypointType [_Group,_index];
	private _TempA = _BuildingPositions;
	if (count _TempA > 0) then
	{
		{
			private _Foot = isNull objectParent _x;
			if (_Foot) then
			{
			private _BuildingLocation = selectRandom _TempA;
			if !(isNil "_BuildingLocation") then
			{
				_x doMove _BuildingLocation;
				_x setUnitPos "UP";
				[_x,_BuildingLocation] spawn
				{
					params ["_unit","_BuildingLocation"];
					if (isNil "_BuildingLocation") exitWith {};
					waitUntil {!alive _unit || {_unit distance _BuildingLocation < 1.3}};
					_unit disableAI "PATH";
				};
				private _RMV = _TempA findIf {_BuildingLocation isEqualTo _x};
				_TempA deleteAt _RMV;
				};
			};
			true;
		} count _GroupUnits;


	};
	sleep (30 + (random 60));
};

[_Group,_Unitleader] spawn {
	params ["_Group","_Unitleader"];
	waituntil {((behaviour _Unitleader) in ["AWARE","COMBAT","STEALTH"])};
	[_Group] call FUNC(CombatResponse);
};
