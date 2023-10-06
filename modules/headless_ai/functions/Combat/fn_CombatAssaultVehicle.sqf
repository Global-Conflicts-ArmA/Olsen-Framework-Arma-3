#include "script_component.hpp"

params [
    "_group",
    "_targetPos",
    ["_compRadius", 250, [0]]
];
LOG_1("combatAssaultVeh started _this: %1",_this);

private _units = units _group;

[_group] call CBA_fnc_clearWaypoints;
[_group, _targetPos, 0, "SAD"] call CBA_fnc_addWaypoint;

_group setBehaviourStrong "AWARE";
_group setCombatMode "BLUE";
_group setSpeedMode "FULL";

private _arrayTest = ["AUTOCOMBAT", "COVER", "SUPPRESSION", "AUTOTARGET", "TARGET"];
//_group enableAttack false;
private _leader = leader _group;
private _veh = vehicle _leader;
private _driver = driver _veh;
[_leader, _driver] apply {
    private _unit = _x;
    _arrayTest apply {
        _unit disableAI _x;
    };
};

//private _vehConfig = (configfile >> "CfgVehicles" >> typeOf _veh);
//private _transportSoldiersAmount = getNumber(_vehConfig >> "transportSoldier");
//private _cargoIndexes = getArray(_vehConfig >> "cargoProxyIndexes");
//private _isCommanderCargo = getNumber(_vehConfig >> "");
private _fullCrew = fullCrew _veh;
private _cargoSoldiers = _fullCrew apply {
    _x params ["_unit", "_role", "_index", "_turretPath", "_personTurret"];
    if (_role isEqualTo "cargo" || _role isEqualTo "turret" || _personTurret) then {
        _unit
    };
};

if (_cargoSoldiers isEqualTo []) exitWith {
    TRACE_2("exiting combatAssaultVeh since it only has reg crew",_group,_cargoSoldiers);
    [_group, getPos _leader] call FUNC(taskPatrol);
};

// manoeuvre function
private _assaultTaskPFH = [{
    params ["_args", "_idPFH"];
    _args params [
        "_group",
        "_targetPos",
        "_units",
        "_compRadius",
        "_cargoSoldiers"
    ];
    _units = _units select {_x call EFUNC(FW,isAlive)};
    _args set [2, _units];
    _cargoSoldiers = _cargoSoldiers select {_x call EFUNC(FW,isAlive)};
    _args set [4, _cargoSoldiers];
    private _leader = leader _group;
    private _veh = vehicle _leader;
    private _driver = driver _veh;
    if (
        (_units isEqualTo []) ||
        {_veh isEqualTo _leader} ||
        {(GETVAR(_group,Task,"PATROL")) isNotEqualTo "ASSAULT"} ||
        {(GETVAR(_group,ExitAssault,false))} ||
        {
            (getPosATL _leader distance2D _targetPos) <= _compRadius
        } ||
        {
            (((side _leader call FUNC(EnemyArray)) findif {
                ((_leader distance2D _x) <= (GETVAR(_group,AssaultEngageDistance,200))) &&
                {[_leader, _x] call FUNC(LOSCheck)}
            }) isNotEqualTo -1)
        }
    ) exitWith {
        [_idPFH] call CBA_fnc_removePerFrameHandler;
        SETVAR(_group,ExitAssault,false);
        TRACE_2("Group exited Assault PFH",_veh,_cargoSoldiers);
        if (_cargoSoldiers isNotEqualTo []) then {
            _veh forceSpeed 0;
            [{
                speed (_this select 0) < 2
            }, {
                params [
                    "_veh",
                    "_group",
                    "_cargoSoldiers",
                    "_targetPos"
                ];
                _cargoSoldiers orderGetIn false;
                _cargoSoldiers apply {
                    _x setVariable [QGVAR(Busy), true];
                    moveOut _x;
                    unassignVehicle _x;
                    private _unitPos = getposATL _x;
                    private _dir = _veh getDir _unitPos;
                    doStop _x;
                    private _dismountPos = _x getPos [10, _dir];
                    _x moveTo _dismountPos;
                };
                private _vehCrew = units _group - _cargoSoldiers;
                TRACE_2("splitting groups",_vehCrew,_cargoSoldiers);
                private _newGroup = [
                    _group,
                    _cargoSoldiers,
                    "ASSAULT",
                    _targetPos,
                    20,
                    false
                ] call FUNC(createSubGroup);
                [_group, _newGroup, _targetPos] call FUNC(taskCover);
            }, [
                _veh,
                _group,
                _cargoSoldiers,
                _targetPos
            ]] call CBA_fnc_waitUntilAndExecute;
        } else {
            [_group, getPos _leader] call FUNC(taskPatrol);
        };
        //if (RNG(0.5)) then {
        //    [_group, _targetPos] call FUNC(CombatAttack);
        //} else {
            //[_group] call FUNC(CombatHunt);
            //[_group, _targetPos, 100, "SAD", "COMBAT", "RED"] call CBA_fnc_addWaypoint;
        //};
    };
    //TRACE_2("assault cargoUnits", _group, _cargoSoldiers);
    private _cargoTroopsOutStatus = _cargoSoldiers findIf {
        (vehicle _x isNotEqualTo _veh) 
    };
    private _getAttackStatus = units _group findIf {
        getAttackTarget vehicle _x isNotEqualTo objNull 
    };
    //TRACE_2("veh assault status of targets",_cargoTroopsOutStatus, _getAttackStatus);
    if (
         _cargoTroopsOutStatus isNotEqualTo -1 ||
         (_getAttackStatus isNotEqualTo -1)
    ) exitWith {
        TRACE_1("Group exited Assault PFH due to dismounts",_group);
        [_idPFH] call CBA_fnc_removePerFrameHandler;
        //dismount quicker
        if (_cargoSoldiers isNotEqualTo []) then {
            _veh forceSpeed 0;
            [{
                speed (_this select 0) < 2
            }, {
                params [
                    "_veh",
                    "_group",
                    "_cargoSoldiers",
                    "_targetPos"
                ];
                _cargoSoldiers orderGetIn false;
                _cargoSoldiers apply {
                    _x setVariable [QGVAR(Busy), true];
                    moveOut _x;
                    unassignVehicle _x;
                    private _unitPos = getposATL _x;
                    private _dir = _veh getDir _unitPos;
                    doStop _x;
                    private _dismountPos = _x getPos [10, _dir];
                    _x doMove _dismountPos;
                };
                private _vehCrew = units _group - _cargoSoldiers;
                TRACE_2("splitting groups",_vehCrew,_cargoSoldiers);
                private _newGroup = [
                    _group,
                    _cargoSoldiers,
                    "ASSAULT",
                    _targetPos,
                    20,
                    false
                ] call FUNC(createSubGroup);
                [_group, _newGroup, _targetPos] call FUNC(taskCover);
            }, [
                _veh,
                _group,
                _cargoSoldiers,
                _targetPos
            ]] call CBA_fnc_waitUntilAndExecute;
        } else {
            [_group, getPos _leader] call FUNC(taskPatrol);
        };
    };
    _group setCombatMode "BLUE";
    _group setBehaviour "AWARE";
    _group setSpeedMode "FULL";
    _veh moveTo _targetPos;
    _driver setDestination [_targetPos, "VEHICLE PLANNED", false];
}, 2, [
    _group,
    _targetPos,
    _units,
    _compRadius,
    _cargoSoldiers
]] call CBA_fnc_addPerFrameHandler;

SETVAR(_group,Task,"ASSAULT");
