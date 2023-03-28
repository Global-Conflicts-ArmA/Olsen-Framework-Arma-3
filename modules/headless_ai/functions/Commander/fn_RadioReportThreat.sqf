
#include "script_component.hpp"

params [
    ["_callerGroup", grpNull, [grpNull]],
    ["_target", objNull, [objNull]]
];

if (_callerGroup isEqualTo objNull || _target isEqualTo objNull) exitWith {};

private _callerSide = side leader _callerGroup;
private _targetGroup = group _target;

private _nearbyEnemy = [];
_nearbyEnemy = [_target, 50] call FUNC(nearbyFriendlyEntities);
_nearbyEnemy params [
    ["_nearbyInfantry", [], [[]]],
    ["_nearbyCars", [], [[]]],
    ["_nearbyAPCs", [], [[]]],
    ["_nearbyTanks", [], [[]]]
];
private _enemyInfantryCount = count _nearbyInfantry;
private _enemyHasVehicles = _nearbyCars isNotEqualTo [] ||
    {_nearbyAPCs isNotEqualTo []} ||
    {_nearbyTanks isNotEqualTo []};
private _enemyHasArmored = _enemyHasVehicles &&
    {(_nearbyAPCs isNotEqualTo []) ||
    {(_nearbyTanks isNotEqualTo [])}
};
private _reportedLocation = [_nearbyEnemy select 0, 30] call CBA_fnc_randPos;
private _lastTimeUpdated = CBA_MissionTime;
private _enemyType = "Infantry";

private _threatArray = [
    _targetGroup, /* threat group */
    ["",""], /* threat debug markers */
    _reportedLocation,
    _lastTimeUpdated,
    _enemyType,
    _enemyInfantryCount,
    _enemyHasVehicles,
    _enemyHasArmored
];

private _searchIndex = GVAR(CommanderThreats) findIf {
    private _group = _x select 0;
    if (_group isEqualType []) then {
        _targetGroup in _group
    } else {
        _group isEqualTo _targetGroup
    };
};

if (_searchIndex isEqualTo -1) then {
    GVAR(CommanderThreats) pushBackUnique _threatArray
} else {
    GVAR(CommanderThreats) set [_searchIndex, _threatArray];
};

TRACE_2("reporting threat",_callerGroup,_threatArray);
