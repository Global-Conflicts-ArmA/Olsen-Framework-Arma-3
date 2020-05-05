#include "..\..\script_macros.hpp"


Private ["_Unit", "_NoFlanking", "_myNearestEnemy", "_GroupUnit", "_myEnemyPos", "_ResetWaypoint", "_OverWatch", "_rnd", "_dist", "_dir", "_positions", "_myPlaces", "_RandomArray", "_RandomLocation", "_index", "_waypoint0", "_waypoint1", "_waypoint2", "_index2", "_wPos", "_UnitPosition", "_x1", "_y1", "_x2", "_y2", "_Midpoint", "_group_array", "_GroupCount", "_CoverCount", "_RandomUnit","_locationPos4","_nearestHill"];
//AI Waypoint Mock up using select best.
params ["_group",["_Flanking",false]];

_Unit = leader _group;

//Exit this script if the group has many active waypoints and the leader is currently moving. Check again in 30 seconds.
//if ((count (waypoints (group _Unit))) >= 3 && !(((velocityModelSpace _Unit) select 1) isEqualTo 0) ) exitWith {};
if ((count (waypoints (group _Unit))) >= 3) exitWith {};

_WaypointCheck = _group call FUNC(Waypointcheck);
if (count _WaypointCheck > 0) exitWith {};

_NoFlanking = GETVAR(_group,REINFORCE,false);
if (_NoFlanking) exitWith {};

//_myNearestEnemy = _Unit call FUNC(ClosestEnemy);
_myNearestEnemy = _Unit findNearestEnemy _Unit;

if (isNull _myNearestEnemy) exitWith
{
	//systemchat format ["%1 RAWR A",side _unit];

	if ((count (waypoints (group _Unit))) < 2) then
	{

		_wPos = waypointPosition [_group, 1];
		_WType = waypointType [_group,1];
		_speed = waypointSpeed [_group,1];
		_Beh = waypointBehaviour [_group,1];
		if (_wPos isEqualTo [0,0,0]) exitWith {};
			while {(count (waypoints _group)) > 0} do
			{
				deleteWaypoint ((waypoints _group) select 0);
				sleep 0.25;
			};
		sleep 2;
		_waypoint2 = _group addwaypoint[_wPos,15];
		_waypoint2 setwaypointtype _WType;
		_waypoint2 setWaypointSpeed _speed;
		_waypoint2 setWaypointBehaviour _Beh;
		//_group setCurrentWaypoint [_group, _waypoint2 select 1];
		_this spawn FUNC(FlankManeuver);
	};

};


if (isNil "_myNearestEnemy" || {(typeName _myNearestEnemy) isEqualTo "ARRAY"}) exitWith {};

if (_Flanking) exitWith {};

if ((count (waypoints (group _Unit))) >= 3) exitWith {};

if (_Unit getVariable "PZAI_GARRISONED") exitWith {};

		//systemchat format ["%1 RAWR B",side _unit];

//If first waypoint is DESTROY, DO NOT change waypoints.
_WType = waypointType [_group,1];
if (_WType isEqualTo "DESTROY") exitWith {};



//Check to see if the AI should just press the advantage!
_EnemyGroup = count (units (group _myNearestEnemy));
_GroupCount = count units _group;
_myEnemyPos = (getposATL _myNearestEnemy);
if (_myEnemyPos isEqualTo [0,0,0]) exitWith
{
	sleep 30;
	[_Unit,_Flanking] spawn FUNC(FlankManeuver);
};

_RandomChance = random 100;
if (_RandomChance < 25) then
{
	if ((_EnemyGroup/_GroupCount) <= 0.5) exitWith
	{
		while {(count (waypoints _group)) > 0} do
		{
		deleteWaypoint ((waypoints _group) select 0);
		sleep 0.25;
		};


		_waypoint2 = _group addwaypoint[_myEnemyPos,1];
		_waypoint2 setwaypointtype "MOVE";
		_waypoint2 setWaypointSpeed "NORMAL";
		_waypoint2 setWaypointBehaviour "COMBAT";

	if (GVAR(Debug)) then
	{
		[_Unit,"Flank Waypoint set. I am a good leader >:D!!",30,20000] remoteExec ["3DText",0];
	};


	};

};
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//systemchat format ["%1 RAWR C",side _unit];
sleep 0.25;
if (_myEnemyPos isEqualTo [0,0,0]) exitWith {_Flanking = false;[_Unit,_Flanking] spawn FUNC(FlankManeuver);_Flanking = true;};

while {(count (waypoints _group)) > 0} do
{
 deleteWaypoint ((waypoints _group) select 0);
 sleep 0.25;
};


_ResetWaypoint = _group addwaypoint [getPosATL _Unit,15];

_rnd = random 100;
_dist = (_rnd + 100);
_dir = random 360;
_positions = [(_myEnemyPos select 0) + (sin _dir) * _dist, (_myEnemyPos select 1) + (cos _dir) * _dist, 0];


_group	= group _Unit;
_index = currentWaypoint _group;


_myPlaces = selectBestPlaces [_myEnemyPos, PZAI_WaypointDistance,"((6*hills + 2*forest + 4*houses + 2*meadow) - sea + (2*trees)) - (1000*deadbody)", 100, 5];
if (_myPlaces isEqualTo []) then {_myPlaces = [_myEnemyPos];};
_RandomArray = _myPlaces call BIS_fnc_selectrandom;
_RandomLocation = _RandomArray select 0;


_group setBehaviour "COMBAT";
_waypoint0 = _group addwaypoint [_RandomLocation,15];
_waypoint0 setwaypointtype "MOVE";
_waypoint0 setWaypointSpeed "NORMAL";
_waypoint0 setWaypointBehaviour "COMBAT";
_group setCurrentWaypoint [_group,(_waypoint0 select 1)];
//_waypoint1 = _group addwaypoint[_positions,10];
//_waypoint1 setwaypointtype "MOVE";
//_waypoint1 setWaypointSpeed "NORMAL";
//_waypoint1 setWaypointBehaviour "COMBAT";
_waypoint2 = _group addwaypoint[_myEnemyPos,15];
_waypoint2 setwaypointtype "MOVE";
_waypoint2 setWaypointSpeed "NORMAL";
_waypoint2 setWaypointBehaviour "COMBAT";

if (GVAR(Debug)) then
{
	[_Unit,"Flank Waypoint set. I am a good leader >:D!!",30,20000] remoteExec ["3DText",0];
};
