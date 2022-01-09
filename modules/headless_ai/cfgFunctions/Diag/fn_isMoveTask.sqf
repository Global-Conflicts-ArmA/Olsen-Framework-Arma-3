#include "..\..\script_macros.hpp"

//unit 1, unit 2
params [["_group", grpNull, [grpNull]]];

private _task = GETVAR(_group,task,"Patrol");
private _moveTasks = [
    "PATROL",
    "PERIMPATROL",
    "SENTRY",
    "ATTACK",
    "ASSAULT",
    "FLANK",
    "MOVE",
    "MANUAL",
    "BLDMOVE",
    "BLDSEARCH",
    "PICKUP",
    "DROPOFF"
];
private _stationaryTasks = [
    "GARRISON",
    "DEFEND",
    "BUNKER",
    "STATIONARY",
    "BLDDEFEND",
    "HOLD"
];

private _return = _task in _moveTasks;
_return