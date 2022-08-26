#include "script_component.hpp"

params ["_group", "_dropOffPos", ["_compradius", 100, [0]]];
LOG_1("combatDropOff started _this: %1",_this);

private _leader = leader _group;
private _units = units _group;

[_group] call CBA_fnc_clearWaypoints;
[_group, _dropOffPos, 0, "SAD"] call CBA_fnc_addWaypoint;

_group setBehaviourStrong "AWARE";
_group setCombatMode "BLUE";
_group setSpeedMode "FULL";

// manoeuvre function
private _dropOffTaskPFH = [{
    params ["_args", "_idPFH"];
    _args params ["_group", "_dropOffPos", "_units", "_compradius"];
    _units = _units select {_x call EFUNC(FW,isAlive)};
    private _leader = leader _group;
    private _veh = vehicle _leader;
    private _distance = _veh distance2D _dropOffPos;
    TRACE_1("",_distance);
    if (
        _units isEqualTo [] ||
        {_veh isEqualTo _leader} ||
        {!canMove _veh} ||
        {(GETVAR(_group,Task,"PATROL")) isNotEqualTo "DROPOFF"} ||
        {(GETVAR(_group,ExitTask,false))} ||
        {
            _distance <= _compradius
        }
    ) exitWith {
        [_idPFH] call CBA_fnc_removePerFrameHandler;
        TRACE_1("Group exited DropOff PFH",_group);
        SETVAR(_group,ExitTask,false);
        private _cargoGroups = GETVAR(_veh,vehCargoGroups,[]);
        if (_cargoGroups isNotEqualTo []) then {
            _cargoGroups apply {
                private _group = _x;
                //_group call FUNC(vehicleEject);
                [{
                    speed _veh <= 2
                },{
                    private _group = _this;
                    (units _group) apply {
                        unassignVehicle _x;
                        doGetOut _x;
                    };
                }, _group, 3, {
                    private _group = _this;
                    (units _group) apply {
                        unassignVehicle _x;
                        doGetOut _x;
                    };
                }] call CBA_fnc_waitUntilAndExecute;
                private _task = GETVAR(_group,vehCargoOrigTask,"PATROL");
                private _manualPos = GETVAR(_group,taskPos,[ARR_3(0,0,0)]);
                private _taskPos = if (_manualPos isEqualTo [0,0,0]) then {
                    getPosATL _leader
                } else {
                    _manualPos
                };
                TRACE_2("",_group,_taskPos);
                [_group,_task,_taskPos] call FUNC(taskAssign);
            };
        };
        if (RNG(0.5)) then {
            [_group, _dropOffPos] call FUNC(CombatAttack);
        } else {
            [_group] call FUNC(CombatDefend);
        };
    };
    private _driver = driver _veh;
    _driver moveTo _dropOffPos;
    _driver setDestination [_dropOffPos, "VEHICLE PLANNED", false];
}, 5, [_group, _dropOffPos, _units, _compradius]] call CBA_fnc_addPerFrameHandler;

SETVAR(_group,Task,"DROPOFF");
