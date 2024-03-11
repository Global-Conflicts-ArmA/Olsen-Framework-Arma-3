#include "script_component.hpp"

params ["_group", "_targetPos", ["_radius", 50, [0]], ["_mode", "ASSAULT", [""]]];
LOG_1("combatAssault started _this: %1",_this);

private _leader = leader _group;
if (INVEHICLE(_leader)) exitWith {
    _this call FUNC(CombatAssaultVehicle);
};

private _enemyDir = leader _group getDir _targetPos;
private _formation = if (RNG(0.5)) then {"LINE"} else { if (_mode == "RETREAT") then {"VEE"} else {"WEDGE"} };
_group setFormDir _enemyDir;
private _units = units _group;

[_group] call CBA_fnc_clearWaypoints;
[_group, _targetPos, 0, "MOVE", "AWARE", "WHITE"] call CBA_fnc_addWaypoint;

//private _arrayTest = ["AUTOCOMBAT", "COVER", "SUPPRESSION", "AUTOTARGET", "TARGET", "FSM"];
private _arrayTest = ["AUTOCOMBAT", "TARGET"];
//_group enableAttack false;
_units apply {
    private _unit = _x;
    _arrayTest apply {
        _unit disableAI _x;
    };
    _unit setUnitPos "UP";
    _unit setVariable [QGVAR(Busy), ffalse];
    _unit doFollow _leader;
    _unit forceSpeed -1;
};
_group setBehaviourStrong "AWARE";
_group setFormation _formation;
_group setCombatMode "YELLOW";
_group setSpeedMode "FULL";

// manoeuvre function
private _assaultTaskPFH = [{
    params ["_args", "_idPFH"];
    _args params [
        "_group",
        "_targetPos",
        "_compRadius",
        ["_firstRun", true, [true]]
    ];
    _units = units _group select {_x call EFUNC(FW,isAlive)};
    TRACE_2("",_group,count _units);
    private _leader = leader _group;
    if (_units isEqualTo []) exitWith {
        [_idPFH] call CBA_fnc_removePerFrameHandler;
    };
    private _nearestEnemy = _leader call FUNC(closestEnemy);
    //unset fire and move groups
    if (!_firstRun && (_group getVariable["subGroup", objNull] isEqualTo objNull)) then {
        units _group apply {
            _x forceSpeed -1;
            _x setVariable [QGVAR(Busy), false];
            doStop _x;
        };
    };
    if (
        (GETVAR(_group,Task,"PATROL")) isNotEqualTo "ASSAULT" ||
        {(GETVAR(_group,ExitAssault,false))} ||
        {(getPosATL _leader distance2D _targetPos) <= _compRadius} ||
        {count units _group <= 3} ||
        {_mode != "RETREAT" && _leader distance2D _nearestEnemy <= 15}
    ) exitWith {
        [_idPFH] call CBA_fnc_removePerFrameHandler;
        TRACE_1("Group exited Assault PFH",_group);
        SETVAR(_group,ExitAssault,false);
        _group setCombatMode "YELLOW";
        _group setBehaviour "AWARE";
        _group enableAttack true;
        _units apply {
            private _unit = _x;
            ["AUTOCOMBAT", "COVER", "SUPPRESSION", "AUTOTARGET", "TARGET", "FSM"] apply {
                _unit enableAI _x;
            };
			_unit setUnitCombatMode "YELLOW";
            _unit forceSpeed -1;
            _unit setUnitPos "AUTO";
            _unit setVariable [QGVAR(Busy), false];
        };
        //patrol in local area
        [_group, "PATROL", _targetPos] call FUNC(taskAssign);
    };
    if (_firstRun) then {
        if (GETVAR(_group,AssaultPFH,objNull) isNotEqualTo objNull) then {
            [GETVAR(_group,AssaultPFH,objNull)] call CBA_fnc_removePerFrameHandler;
        };
        SETVAR(_group,AssaultPFH,_idPFH);
        units _group apply {
            private _unit = _x;
            _unit forceSpeed -1;
            private _relDir = _unit getDir _targetPos;
			if (_mode == "RETREAT" && (_nearestEnemy isNotEqualTo objNull) && (_unit distance2d _nearestEnemy < 100)) then {
				_relDir = _nearestEnemy getDir _unit;
			};
            private _relPos = _unit getPos [20, _relDir];
            _unit doMove _relPos;
            _unit setDestination [_relPos, "FORMATION PLANNED", false];
            _unit setUnitPos "UP";
            _unit setVariable [QGVAR(Busy), true];
        };
        _firstRun = false;
        _args set [3, _firstRun];
    } else {
        if (
            (_nearestEnemy isNotEqualTo objNull) && 
            {(_leader distance2d _nearestEnemy < (GETVAR(_group,AssaultEngageDistance,200)))}
        ) then {
            //sort the members by distance to the objective... find the farthest and make them move, closest do fire support
            // do this if the bound was finished
            if (_group getVariable["subGroup", objNull] isEqualTo objNull) then {
                TRACE_2("Enemy Detected and in range",_group,_leader distance2d _nearestEnemy);
                private _sortArray = units _group select { alive _x } apply {
                    private _dis = _x distance2d _targetPos;
                    [_dis, _x]
                };
                _sortArray sort true;
                _sortArray = _sortArray apply {
                    _x select 1
                };
                private _fireGroup = [_sortArray, 0, -(count _sortArray / 2)] call BIS_fnc_subSelect;
                private _moveGroup = _sortArray - _fireGroup;
                if (_moveGroup isEqualTo []) then {
                    _fireGroup = _sortArray deleteAt 0;
                    _moveGroup = _sortArray;
                };
                TRACE_2("assault groups chosen",_fireGroup,_moveGroup);
                _fireGroup apply {
                    if (RNG(0.5)) then {
                        _x setUnitPos "MIDDLE";
                    } else {
                        _x setUnitPos "DOWN";
                    }; 
                    _x setCombatBehaviour "COMBAT";
                    _x lookAt _nearestEnemy;
                    _x setVariable [QGVAR(Busy), false];
                    _x forcespeed 0;
                };

                private _newGroup = [
                    _group,
                    _moveGroup,
                    {
                        params ["_group", "_newUnits", "_args"];
                        _group enableAttack false;
                        _group setCombatMode "BLUE";
                        _group setBehaviourStrong "AWARE";
                        _group setSpeedMode "FULL";

                        private _subGroupLeader = leader _group;

                        private _relDir = _subGroupLeader getDir _targetPos;
                        // if retreating, get some separation from the nearest enemy fist
                        if (_mode == "RETREAT" && _unit distance2d _nearestEnemy < 100) then {
                            _relDir = _nearestEnemy getDir _subGroupLeader;
                        };
                        private _relPos = _subGroupLeader getPos [50, _relDir + (random 30) - (random 30)];

                        [_group] call CBA_fnc_clearWaypoints;
                        [_group, _relPos, 0, "MOVE", "AWARE", "YELLOW", "FULL", formation _group, "", [0,0,0], 10] call CBA_fnc_addWaypoint;
                        [_group, 0] setWaypointCompletionRadius 10;

                        units _group apply {
                            private _unit = _x;
                            _unit setUnitCombatMode "BLUE";
                            _unit setVariable [QGVAR(Busy), true];
                            _unit doWatch objNull;
                            _unit forceSpeed (_unit getSpeed "FAST");
                            // private _unitRelPos = _relPos getPos [10, random[0, 180, 360]];
                            // _unit doMove _unitRelPos;
                            _unit setUnitPos "UP";
                            _unit setSuppression 0;
                        };

                        [{
                            _group = _this select 0;
                            currentWaypoint _group == 1;
                        }, {
                            params ["_group", "_oldGroup"];
                            _group enableAttack true;
                            _group setCombatMode "YELLOW";
                            _group setBehaviourStrong "COMBAT";
                            _group setVariable["boundComplete", true];
                            units _group apply {
                                _x setUnitCombatMode "YELLOW";
                            };
                        }, [_group, _oldGroup]] call CBA_fnc_waitUntilAndExecute;
                    },
                    {false},
                    [],
                    "MANUAL",
                    _targetPos,
                    20,
                    {
                        params ["_group", "_newUnits", "_args"];
                        _group getVariable["boundComplete", false];
                    }
                ] call FUNC(createSubGroup);
            };
        } else {
            TRACE_2("rushing towards obj",_group,_units);
            units _group apply {
                private _unit = _x;
                _unit forceSpeed -1;
                _unit setUnitCombatMode "YELLOW";
                _unit setCombatBehaviour "AWARE";
                private _relDir = _unit getDir _targetPos;
                private _relPos = _unit getPos [20, _relDir + (random 30) - (random 30)];
                _unit doMove _relPos;
                _unit setDestination [_relPos, "FORMATION PLANNED", false];
                _unit setUnitPos "UP";
                _unit setVariable [QGVAR(Busy), true];
                _unit setSuppression 0;
            };
        };
    };
}, 3, [_group, _targetPos, _radius]] call CBA_fnc_addPerFrameHandler;

SETVAR(_group,Task,"ASSAULT");
