#include "script_component.hpp"


params [
    "_unit",
    ["_distance", 5, [5]],
    ["_infantryOnly", false, [false]]
];

if (_infantryOnly) exitWith {
    private _nearbyInfantry = (_unit nearEntities [[
        "CAManBase"
    ], _distance]) select {
        _x call EFUNC(FW,isAlive) &&
        {side _x isEqualTo side _unit}
    };
    private _nearbyEntities = [_nearbyInfantry, [], [], []];
    _nearbyEntities
};

private _list = _unit nearEntities [[
    "CAManBase",
    "Car",
    "WheeledAPC",
    "TrackedAPC",
    "Tank"
], _distance] select {
    side _x isEqualTo side _unit
};

private _nearbyInfantry = _list select {
    _x call EFUNC(FW,isAlive) &&
    {_x isKindOf "CAManBase"}
};
private _nearbyCars = _list select {
    _x isKindOf "Car"
};
private _nearbyAPCs = _list select {
    _x isKindOf "TrackedAPC" ||
    _x isKindOf "WheeledAPC"
};
private _nearbyTanks = _list select {
    _x isKindOf "Tank"
};

private _nearbyEntities = [_nearbyInfantry, _nearbyCars, _nearbyAPCs, _nearbyTanks];

_nearbyEntities
