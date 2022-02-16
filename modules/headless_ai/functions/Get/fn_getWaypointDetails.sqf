#include "script_component.hpp"

params [["_entityWaypoints",[],[[]]]];

private _waypointDetails = _entityWaypoints apply {
    [
        _x,
        waypointName _x,
        waypointPosition _x,
        waypointType _x,
        waypointBehaviour _x,
        waypointCombatMode _x,
        waypointSpeed _x,
        waypointFormation _x,
        waypointTimeout _x,
        waypointCompletionRadius _x,
        waypointAttachedObject _x,
        waypointAttachedVehicle _x,
        waypointHousePosition _x,
        waypointLoiterRadius _x,
        waypointScript _x,
        waypointStatements _x
    ];
};

_waypointDetails
