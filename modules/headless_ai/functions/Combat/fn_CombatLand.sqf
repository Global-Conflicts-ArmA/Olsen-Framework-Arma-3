#include "script_component.hpp"

params ["_group", "_targetPos"];

private _leader = leader _group;
private _units = units _group;
private _vehicle = vehicle _leader;
private _pilot = driver _vehicle;

[_group] call CBA_fnc_clearWaypoints;
private _arrayTest = ["AUTOCOMBAT", "COVER", "SUPPRESSION", "AUTOTARGET", "TARGET", "FSM"];
_group enableAttack false;
_units apply {
    private _unit = _x;
    _arrayTest apply {
        _unit disableAI _x;
    };
};
_group setBehaviour "AWARE";
_group setCombatMode "BLUE";
_group setSpeedMode "FULL";

// manoeuvre function
private _landTaskPFH = [{
    params ["_args", "_idPFH"];
    _args params [
        "_group",
        "_targetPos",
        "_pilot",
        "_vehicle",
        ["_state", "FLYING", [""]]
    ];
    _units = _units select {_x call EFUNC(FW,isAlive)};
    private _leader = leader _group;
    
    _group setCombatMode "BLUE";
    _group setBehaviour "AWARE";
    _group setSpeedMode "FULL";
    
    private _distance = _vehicle distance2d _targetPos;
    
    //TRACE_3("landTask",_vehicle,_state,_distance);
    
    switch (_state) do {
        case "LANDED": {
            [_idPFH] call CBA_fnc_removePerFrameHandler;
            TRACE_1("Group exited Land PFH",_group);
            SETVAR(_group,ExitTask,false);
            private _cargoGroups = GETVAR(_vehicle,vehCargoGroups,[]);
            [_leader, _pilot] apply {
                private _unit = _x;
                ["AUTOCOMBAT", "COVER", "SUPPRESSION", "AUTOTARGET", "TARGET", "FSM"] apply {
                    _unit enableAI _x;
                };
            };
            _vehicle flyInHeight 100;
            _vehicle limitSpeed (2 * getNumber(configOf _vehicle >> "maxSpeed"));
            if (_cargoGroups isNotEqualTo []) then {
                _cargoGroups apply {
                    private _group = _x;
                    //_group call FUNC(vehicleEject);
                    [{
                        speed _vehicle <= 2
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
                    private _task = GETVAR(_group,NextTask,"PATROL");
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
            SETVAR(_vehicle,vehCargoGroups,[]);
            private _rtb = GETVAR(_group,rtbPos,objNull);
            if (_rtb isNotEqualTo objNull) then {
                SETVAR(_group,rtbPos,objNull);
                [_group,_rtb] call FUNC(combatLand);
            } else {
                doStop _vehicle;
                _vehicle land "LAND";
            };
        };
        case "LANDING": {
            private _relVelocity = velocityModelSpace _vehicle;
            _relVelocity params ["", "_fVelocity", "_uVelocity"];
            if (_uVelocity > 0) then {
                private _vectorAdd = [0, 0, -(_uVelocity * 0.8)];
                private _newVector = _relVelocity vectorAdd _vectorAdd;
                _vehicle setVelocityModelSpace _newVector;
            };
            if ((getPosATL _vehicle select 2) <= 5) then {
                _vehicle flyInHeight 0;
                _state = "LANDED";
                _args set [4, _state];
                SETVAR(_group,Task,"LANDED");
            };
        };
        case "APPROACHING": {
            private _relVelocity = velocityModelSpace _vehicle;
            _relVelocity params ["", "_fVelocity", "_uVelocity"];
            if (_fVelocity >= 15 || _uVelocity >= 4) then {
                private _nFVelocity = if (_fVelocity < 15) then {
                    _fVelocity
                } else {
                    -(_fVelocity * 0.5)
                };
                private _nUVelocity = if (_uVelocity < 4) then {
                    _uVelocity
                } else {
                    -(_uVelocity * 0.5)
                };
                private _vectorAdd = [0, _nFVelocity, _nUVelocity];
                private _newVector = _relVelocity vectorAdd _vectorAdd;
                _vehicle setVelocityModelSpace _newVector;
            };
            if (_distance <= 200) then {
                _vehicle land "LAND";
                _state = "LANDING";
                _args set [4, _state];
                SETVAR(_group,Task,"LANDING");
            };
        };
        case "FLYING": {
            _pilot doMove _targetPos;
            if (_distance <= 300) then {
                _vehicle flyInHeight 30;
                _vehicle limitSpeed 35;
                _state = "APPROACHING";
                _args set [4, _state];
                SETVAR(_group,Task,"APPROACHING");
            };
        };
        default {};
    };
}, 3, [_group, _targetPos, _pilot, _vehicle]] call CBA_fnc_addPerFrameHandler;

SETVAR(_group,Task,"LAND");
