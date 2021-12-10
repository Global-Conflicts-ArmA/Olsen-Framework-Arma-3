#include "..\..\script_macros.hpp"


private ["_Locations", "_Unit", "_InCover", "_Enemy", "_RefinedBuildingArray", "_UnitPosition", "_AcceptableRange", "_ClosestPos"];

//Stop the AI - and then tell them to move to the house
_Locations = _this select 0;
_Unit = _this select 1;
_InCover = _this select 2;
_Enemy = _this select 4;

sleep (random 5);


			//Define this array so the original remains intact in case needed latter.
			_RefinedBuildingArray = _Locations;

			//Remove any positions below or above the player.
			_UnitPosition = getposATL _Enemy;
			_AcceptableRange = _UnitPosition select 2;
			{
				if ((_x select 2) < (_AcceptableRange - 1) || (_x select 2) > (_AcceptableRange + 1)) then
				{
					_RefinedBuildingArray = _RefinedBuildingArray - [_x];
				};

			} foreach _RefinedBuildingArray;


			//Define the closest position to be edited
			if (_RefinedBuildingArray isEqualTo []) then {_ClosestPos = [_Locations,_Enemy] call FUNC(ClosestObject);} else {_ClosestPos = [_RefinedBuildingArray,_Enemy] call FUNC(ClosestObject);};


if (isNil "_closestpos") exitWith {};
while {(_Unit distance _ClosestPos) > 3 && alive _Unit} do
{

			_Unit doMove _ClosestPos;
			sleep 5;

			//Define this array so the original remains intact in case needed latter.
			_RefinedBuildingArray = _Locations;

			//Remove any positions below or above the player.
			_UnitPosition = getposATL _Enemy;
			_AcceptableRange = _UnitPosition select 2;
			_RefinedBuildingArray apply {
				if ((_x select 2) < (_AcceptableRange - 1) || (_x select 2) > (_AcceptableRange + 1)) then
				{
					_RefinedBuildingArray = _RefinedBuildingArray - [_x];
				};

			};


			//Define the closest position to be edited
			if (_RefinedBuildingArray isEqualTo []) then {_ClosestPos = [_Locations,_Enemy] call FUNC(ClosestObject);} else {_ClosestPos = [_RefinedBuildingArray,_Enemy] call FUNC(ClosestObject);};


};
