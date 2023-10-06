#include "script_component.hpp"

params ["_group", "_targetPos", ["_radius", 50, [0]]];
LOG_1("combatAssault started _this: %1",_this);

private _leader = leader _group;
if (INVEHICLE(_leader)) exitWith {
    _this call FUNC(CombatAssaultVehicle);
};

private _enemyDir = leader _group getDir _targetPos;
private _formation = if (RNG(0.5)) then {"LINE"} else {"WEDGE"};
_group setFormation _formation;
_group setFormDir _enemyDir;
private _units = units _group;

[_group] call CBA_fnc_clearWaypoints;
[_group, _targetPos, 0, "MOVE", "AWARE", "WHITE"] call CBA_fnc_addWaypoint;

//private _arrayTest = ["AUTOCOMBAT", "COVER", "SUPPRESSION", "AUTOTARGET", "TARGET", "FSM"];
private _arrayTest = ["AUTOCOMBAT", "COVER", "SUPPRESSION"];
//_group enableAttack false;
_units apply {
    private _unit = _x;
    _arrayTest apply {
        _unit disableAI _x;
    };
    doStop _unit;
    _unit setUnitPos "UP";
};
_group setBehaviourStrong "AWARE";
//_group setFormation "DIAMOND";
_group setCombatMode "BLUE";
_group setSpeedMode "FULL";

// manoeuvre function
private _assaultTaskPFH = [{
    params ["_args", "_idPFH"];
    _args params [
        "_group",
        "_targetPos",
        "_compRadius"
    ];
    _units = units _group select {_x call EFUNC(FW,isAlive)};
    TRACE_2("",_group,count _units);
    private _leader = leader _group;
    if (_units isEqualTo []) exitWith {
        [_idPFH] call CBA_fnc_removePerFrameHandler;
    };
    private _nearestEnemy = _leader call FUNC(closestEnemy);
    //unset fire and move groups
    _units apply {
        _x forceSpeed -1;
    };
    if (
        (GETVAR(_group,Task,"PATROL")) isNotEqualTo "ASSAULT" ||
        {(GETVAR(_group,ExitAssault,false))} ||
        {(getPosATL _leader distance2D _targetPos) <= _compRadius} || 
        {count _units <= 3} || 
        {_leader distance2D _nearestEnemy <= 15}
    ) exitWith {
        [_idPFH] call CBA_fnc_removePerFrameHandler;
        TRACE_1("Group exited Assault PFH",_group);
        SETVAR(_group,ExitAssault,false);
        _group setCombatMode "RED";
        _group setBehaviour "COMBAT";
        //_group enableAttack true;
        _units apply {
            private _unit = _x;
            ["AUTOCOMBAT", "COVER", "SUPPRESSION", "AUTOTARGET", "TARGET", "FSM"] apply {
                _unit enableAI _x;
            };
            _unit setVariable [QGVAR(Busy), false];
        };
        //hunt in local area
        [_group, _targetPos] call FUNC(taskHunt);
    };
    if (
        _nearestEnemy isNotEqualTo objNull
        && {(_leader distance2d _nearestEnemy < (GETVAR(_group,AssaultEngageDistance,200)))}
    ) then {
        //sort the members by distance to the objective... find the farthest and make them move, closest do fire support
        TRACE_2("Enemy Detected and in range",_group,_leader distance2d _nearestEnemy);
        private _sortArray = _units apply {
        	private _dis = _x distance2d _nearestEnemy;
        	[_dis, _x]
        };
        _sortArray sort true;
        private _fireGroup = [_sortArray, 0, count _sortArray / 2] call BIS_fnc_subSelect;
        private _moveGroup = _sortArray - _fireGroup;
        if (_moveGroup isEqualTo []) then {
            _fireGroup = _sortArray deleteAt 0;
            _moveGroup = _sortArray;
        };
        TRACE_2("assault groups chosen",_fireGroup,_moveGroup);
        _fireGroup apply {
            _x params ["_distance", "_unit"];
            _unit setUnitCombatMode "YELLOW";
            _unit setBehaviour "COMBAT";
            //_unit lookAt _nearestEnemy;
            _unit setVariable [QGVAR(Busy), false];
            _unit forcespeed 0;
            //private _relDir = _unit getDir _nearestEnemy;
            //if (
            //    RNG(0.75)
            //    && {(_unit call FUNC(hasUGL)) isNotEqualTo ""}
            //) then {
            //    TRACE_1("attempting to fire UGL",_unit);
            //    if (stance _unit isEqualTo "PRONE") then {
            //        _unit setUnitPos "MIDDLE";
            //    };
            //    private _muzzle = _unit call FUNC(hasUGL);
            //    [_unit, _muzzle, _targetPos] call FUNC(fireUGL);
            //} else {
            //    if (RNG(0.5) && {!(stance _unit isNotEqualTo "PRONE")}) then {
            //        _unit setUnitPos "DOWN";
            //    } else {
            //        _unit setUnitPos "MIDDLE";
            //    };
            //    [_unit, _relDir, 3] call FUNC(SuppressDirection);
            //}
        };
        _moveGroup apply {
            _x params ["_distance", "_unit"];
            //_unit doFollow _leader;
            _unit forceSpeed -1;
            private _relDir = _unit getDir _targetPos;
            private _relPos = _unit getPos [20, _relDir + (random 30) - (random 30)];
            _unit doMove _relPos;
            _unit lookAt _nearestEnemy;
            _unit setVariable [QGVAR(Busy), true];
            _unit setDestination [_relPos, "FORMATION PLANNED", false];
            if (RNG(0.75)) then {
                _unit setUnitPos "UP";
            } else {
                _unit setUnitPos "MIDDLE";
            };
            _unit setSuppression 0;
        };
    } else {
        TRACE_2("rushing towards obj",_group,_units);
        _units apply {
            private _unit = _x;
            //["AUTOCOMBAT", "COVER", "SUPPRESSION", "AUTOTARGET", "TARGET", "FSM"] apply {
            //    _unit disableAI _x;
            //};
            _unit forceSpeed -1;
            private _relDir = _unit getDir _targetPos;
            private _relPos = _unit getPos [20, _relDir + (random 30) - (random 30)];
            _unit doMove _relPos;
            //_unit setDestination [_relPos, "FORMATION PLANNED", false];
            _unit setUnitPos "UP";
            _unit setVariable [QGVAR(Busy), true];
            //_unit setSuppression 0;
        };
    };
}, 5, [_group, _targetPos, _radius]] call CBA_fnc_addPerFrameHandler;

SETVAR(_group,Task,"ASSAULT");
