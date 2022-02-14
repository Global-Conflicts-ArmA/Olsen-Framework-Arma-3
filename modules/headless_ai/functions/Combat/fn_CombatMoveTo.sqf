#include "script_component.hpp"


//FUNC(CombatMoveTo)

params [
    ["_group", grpNull, [grpNull]],
    ["_targetPos", [0,0,0], [[]]],
    ["_nextTask", "ATTACK", [""]]
];

TRACE_1("called moveTo with",_this);

private _radius = 30;

if ((random 2) > 1) then {_group setformation "LINE";} else {_group setformation "WEDGE";};
private _direction = leader _group getDir _targetPos;
_group setFormDir _direction;

private _units = units _group;
_units apply {
    private _unit = _x;
    _unit disableAI "AUTOCOMBAT";
    _unit setUnitPos "UP";
};

[_group] call CBA_fnc_clearWaypoints;
SETVAR(_group,Task,"MOVE");
[_group, _targetPos, _radius, "MOVE", "AWARE", "RED"] call CBA_fnc_addWaypoint;

private _moveToTaskPFH = [{
    params ["_argNested", "_idPFH"];
    _argNested params ["_group", "_targetPos", "_nextTask"];
    private _leader = leader _group;
    private _units = units _group select {_x call EFUNC(FW,isAlive)};
    if (_leader distance2D _targetPos <= 50) exitWith {
        TRACE_3("moveTo done, setting to new task",_group,_targetPos,_nextTask);
        _units apply {
            private _unit = _x;
            _unit enableAI "AUTOCOMBAT";
            _unit setUnitPos "Auto";
        };
        switch _nextTask do {
            case "ATTACK": {
                [_group, _targetPos] call FUNC(CombatAttack);
            };
            default {
                [_group, _targetPos] call FUNC(CombatAttack);
            };
        };
        [_idPFH] call CBA_fnc_removePerFrameHandler;
    };
    private _nearestEnemy = _leader call FUNC(closestEnemy);
    private _engageDistance = GETVAR(_group,engageDistance,200);
    if (
            _nearestEnemy isNotEqualTo objNull
            && {_leader distance2d _nearestEnemy < _engageDistance}
            && {count _units > 2}
    ) then {
        _units apply {
            private _unit = _x;
            _unit enableAI "AUTOCOMBAT";
            _unit setUnitPos "Auto";
        };
        [_group, getPos _nearestEnemy] call FUNC(CombatAttack);
        [_idPFH] call CBA_fnc_removePerFrameHandler;
    } else {
        [_group] call CBA_fnc_clearWaypoints;
        [_group, _targetPos, _radius, "MOVE", "AWARE", "RED"] call CBA_fnc_addWaypoint;
    };
}, 5, [_group, _targetPos, _nextTask]] call CBA_fnc_addPerFrameHandler;


//_NoFlanking = GETVAR(_Group,REINFORCE,false);
//if (_NoFlanking) then {
//	[_Group] call CBA_fnc_clearWaypoints;
//	SETVAR(_group,Task,"ATTACK");
//	[_group, _position, _radius, "SAD", "COMBAT", "RED"] call CBA_fnc_addWaypoint;
//} else {
//	SETVAR(_group,Task,"FLANK");
//	[_Group,false] spawn FUNC(FlankManeuver);
//};
