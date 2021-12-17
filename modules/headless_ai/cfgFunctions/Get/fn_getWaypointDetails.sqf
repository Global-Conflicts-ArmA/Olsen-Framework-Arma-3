#include "..\..\script_macros.hpp"

params [["_entityWaypoints",[],[[]]],["_waypointDetails",[],[[]]]];

_entityWaypoints apply {
    private _wayPoint = _x;
    _waypointDetails pushBack [
        _wayPoint,
        waypointName _wayPoint,
        waypointPosition _wayPoint,
        waypointType _wayPoint,
        waypointBehaviour _wayPoint,
        waypointCombatMode _wayPoint,
        waypointSpeed _wayPoint,
        waypointFormation _wayPoint,
        waypointTimeout _wayPoint,
        waypointCompletionRadius _wayPoint,
        waypointAttachedObject _wayPoint,
        waypointAttachedVehicle _wayPoint,
        waypointHousePosition _wayPoint,
        waypointLoiterRadius _wayPoint,
        waypointScript _wayPoint,
        waypointStatements _wayPoint
    ];
};

_waypointDetails
