#include "..\..\script_macros.hpp"


params ["_group",["_waypoints",[],[[]]]];
{
    private _currentWaypoint = _x;
    private _wp = _group addWaypoint [(_currentWaypoint select 2),5,(_currentWaypoint select 0 select 1),(_currentWaypoint select 1)];
    _wp setWaypointType (_currentWaypoint select 3);
    _wp setWaypointBehaviour (_currentWaypoint select 4);
    _wp setWaypointCombatMode (_currentWaypoint select 5);
    _wp setWaypointSpeed (_currentWaypoint select 6);
    _wp setWaypointFormation (_currentWaypoint select 7);
    _wp setWaypointTimeout (_currentWaypoint select 8);
    _wp setWaypointCompletionRadius (_currentWaypoint select 9);
    _wp waypointAttachObject (_currentWaypoint select 10);
    _wp waypointAttachVehicle (_currentWaypoint select 11);
    _wp setWaypointHousePosition (_currentWaypoint select 12);
    _wp setWaypointLoiterRadius (_currentWaypoint select 13);
    _wp setWaypointScript (_currentWaypoint select 14);
    _wp setWaypointStatements (_currentWaypoint select 15);
} foreach _waypoints;
//delete initial wp
deleteWaypoint [_group, 0];
//_group setCurrentWaypoint [_group, 0];
//set manual waypoint mission mode
SETVAR(_group,InitialWPSet,true);
SETVAR(_group,Mission,"MANUAL");
[_group] call FUNC(taskForceSpeed);
true
