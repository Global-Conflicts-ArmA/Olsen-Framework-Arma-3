#include "script_component.hpp"


//This will tell our scripts if certain waypoints are set or not
//_WaypointCheck = _group call FUNC(Waypointcheck);
params ["_group"];

private _WaypointsToIncriminate = [];

private _index = currentWaypoint _group;
private _WaypointIs = waypointType [_group,_index];
{
	if (_WaypointIs isEqualTo _x) then {_WaypointsToIncriminate pushback _x};
} foreach ["HOLD","GUARD","UNLOAD","LOAD","TR UNLOAD","SENTRY","DESTROY"];

_WaypointsToIncriminate
