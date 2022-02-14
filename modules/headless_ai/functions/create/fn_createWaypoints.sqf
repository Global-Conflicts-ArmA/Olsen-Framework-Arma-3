#include "script_component.hpp"


params ["_group", ["_waypoints",[],[[]]]];
_waypoints apply {
    private _currentWaypoint = _x;
    _currentWaypoint params [
        ["_waypoint", [], [[]]],
        ["_name", "", [""]],
        ["_pos", [], [[]]],
        ["_type", "", [""]],
        ["_behaviour", "", [""]],
        ["_combatMode", "", [""]],
        ["_speed", "", [""]],
        ["_formation", "", [""]],
        ["_timeout", [], [[]]],
        ["_compRadius", 0, [0]],
        ["_attachedObject", objNull, [objNull]],
        ["_attachedVeh", objNull, [objNull]],
        ["_buildingPos", 0, [0]],
        ["_loiterDistance", 0, [0]],
        ["_script", "", [""]],
        ["_statements", [], [[]]]
    ];
    TRACE_3("",_pos,_statements,_compRadius);
    private _wp = _group addWaypoint [_pos, 5, _waypoint select 1, _name];
    _wp setWaypointType _type;
    _wp setWaypointBehaviour _behaviour;
    _wp setWaypointCombatMode _combatMode;
    _wp setWaypointSpeed _speed;
    _wp setWaypointFormation _formation;
    _wp setWaypointTimeout _timeout;
    _wp setWaypointCompletionRadius _compRadius;
    _wp waypointAttachObject _attachedObject;
    _wp waypointAttachVehicle _attachedVeh;
    _wp setWaypointHousePosition _buildingPos;
    _wp setWaypointLoiterRadius _loiterDistance;
    _wp setWaypointScript _script;
    _wp setWaypointStatements _statements;
};
//delete initial wp
deleteWaypoint [_group, 0];
//_group setCurrentWaypoint [_group, 0];
//set manual waypoint mission mode
SETVAR(_group,Task,"MANUAL");
