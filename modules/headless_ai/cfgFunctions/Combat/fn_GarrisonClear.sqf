#include "..\..\script_macros.hpp"


params ["_Unit","_MovedRecentlyCover","_InCover","_ActivelyClearing","_StartedInside","_GARRISONED"];

//Function to send AI to clear buildings
if (_MovedRecentlyCover || {_ActivelyClearing} || {_StartedInside} || {_GARRISONED}) exitWith {};
//Find the closest enemy (This should be the one that is in a building

//systemchat format ["F %1",_Unit];
private _Enemy = _Unit call FUNC(ClosestEnemy);
if (isNil "_Enemy" || {(typeName _Enemy) isEqualTo "ARRAY"}) exitWith {};

//Find nearest building to the enemy
private _nBuilding = nearestBuilding _Enemy;

//Find the locations of the buildings
private _Locations = [_nBuilding] call BIS_fnc_buildingPositions;

//Stop the AI - and then tell them to move to the house
{
	//Set variable to true to prevent AI clearing buildings to often
	//_x spawn FUNC(StanceModifier);
	if (_Enemy distance _x < 200) then {
		[_Locations,_x,_InCover,_ActivelyClearing,_Enemy] spawn FUNC(GarrisonClearPatrol);
	};
} foreach units (group _Unit);
