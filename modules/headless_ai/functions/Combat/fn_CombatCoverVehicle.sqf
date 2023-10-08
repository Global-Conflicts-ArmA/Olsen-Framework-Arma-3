#include "script_component.hpp"

params [
    "_group",
    "_supportedGroup",
    "_targetPos",
    ["_compRadius", 250, [0]]
];
LOG_1("combatCoverVeh started _this: %1",_this);

SETVAR(_group,Task,"COVER");
SETVAR(_supportedGroup,CoveringGroup,_group);

private _leader = leader _group;
private _vehicle = vehicle _leader;
_group addVehicle _vehicle;
private _driver = driver _vehicle;
//private _arrayTest = ["AUTOCOMBAT", "COVER", "SUPPRESSION", "AUTOTARGET", "TARGET", "FSM"];
private _arrayTest = ["AUTOCOMBAT", "COVER", "SUPPRESSION"];
private _gunner = objNull;
units _group apply {
    private _unit = _x;
    _arrayTest apply {
        _unit disableAI _x;
    };
    if (gunner _vehicle isEqualTo _unit) then {
        _unit setVariable [QGVAR(Busy), false];
        _gunner = _unit;
        _unit assignAsGunner _vehicle;
    } else {
        if (driver _vehicle isEqualTo _unit) then {
            _unit setVariable [QGVAR(Busy), true];
            _unit assignAsDriver _vehicle;
        } else {
            _unit assignAsCargo _vehicle;
            _unit setVariable [QGVAR(Busy), false];
        };
    };
};
if (_gunner isNotEqualTo objNull) then {
    _group selectLeader _gunner;
    _vehicle setEffectiveCommander _gunner;
} else {
    _group selectLeader _driver;
};
_group setCombatMode "BLUE";
_group setBehaviour "SAFE";
_group setSpeedMode "FULL";
[_group] call CBA_fnc_clearWaypoints;
[_group, _targetPos, 0, "MOVE"] call CBA_fnc_addWaypoint;
//doStop _driver;
_driver doFollow leader _group;
_vehicle forceSpeed 0;

[{
    params ["_argNested", "_idPFH"];
    _argNested params [
        "_group",
        "_supportedGroup",
        "_targetPos",
        "_compRadius"
    ];
    private _leader = leader _group;
    private _vehicle = vehicle _leader;
    if (
        (_group getVariable [QGVAR(Task), "PATROL"]) isNotEqualTo "COVER" ||
        units _group isEqualTo [] ||
        !alive _vehicle
    ) exitWith {
        TRACE_2("exited coverVehicle",_group,_vehicle);
        private _arrayTest = ["AUTOCOMBAT"];
        units _group apply {
            private _unit = _x;
            _arrayTest apply {
                _unit enableAI _x;
            };
        };
        _vehicle forceSpeed -1;
        [_idPFH] call CBA_fnc_removePerFrameHandler;
    };
    private _supportLeader = leader _supportedGroup;
    private _aheadPos = _leader getPos [10, _leader getDir _targetPos];
    private _driver = driver _vehicle;
    //private _canSeeObj = ([vehicle _leader, "VIEW", objNull] checkVisibility [getPosWorld _vehicle, _targetPos] >= 0.5);
    private _distToSupportGroup = _leader distance2D _supportLeader;
    private _distSPToTarget = _supportLeader distance2D _targetPos;
    private _distToTarget = _leader distance2D _targetPos;
    if (_distSPToTarget <= _compRadius) exitWith {
        TRACE_2("exited coverVehicle with _supportedGroup close",_group,_compRadius);
        private _arrayTest = ["AUTOCOMBAT"];
        units _group apply {
            private _unit = _x;
            _arrayTest apply {
                _unit enableAI _x;
            };
        };
        _vehicle forceSpeed -1;
        [_idPFH] call CBA_fnc_removePerFrameHandler;
    };
    private _enemyArray = [side _leader] call FUNC(enemyArray);
    private _LOSCheckNearbyEnemy = _enemyArray findIf {
        _x distance2D _leader <= 800 &&
        {[_leader, _x, false, true] call FUNC(LOSCheck)}
    };
    private _canSeeEnemy = _LOSCheckNearbyEnemy isNotEqualTo -1;
    TRACE_2("cover veh dist to support",_supportLeader,_distToSupportGroup);
    if (
            _distToSupportGroup > 10 &&
            {_distToTarget > _distSPToTarget} &&
            {
                (units _supportedGroup findIf {_x distance _leader < 6}) isEqualTo -1
            } &&
            {_aheadPos distance2D _targetPos > _distSPToTarget} &&
            {_vehicle distance2D _aheadPos > 2} 
    ) then {
        TRACE_2("cover veh too far, moving",_distToSupportGroup,_aheadPos);
        _vehicle forceSpeed -1;
        _vehicle moveTo _aheadPos;
        _driver setDestination [_aheadPos, "VEHICLE PLANNED", false];
    } else {
        TRACE_2("cover veh close enough, staying put",_distToSupportGroup,_aheadPos);
        _vehicle forceSpeed 0;
    };
    //if (_canSeeEnemy) then {
    //    private _selectedEnemy = _enemyArray select _LOSCheckNearbyEnemy;
    //    if ([_group] call FUNC(isInCombat)) then {
    //        [gunner _vehicle, _selectedEnemy, 5] call FUNC(PrepToFire);
    //        TRACE_2("cover veh sees enemy, firing",_group,_selectedEnemy);
    //        //[gunner _vehicle, getPosATL _selectedEnemy, 3] call FUNC(suppressDirection);
    //    };
    //} else {
    //    if ([_group] call FUNC(isInCombat)) then {
    //        TRACE_1("cover veh cant see enemy, suppress anyways",_group);
    //        private _randomAngle = random [-8, 0, 8];
    //        [gunner _vehicle, (_vehicle getDir _targetPos) + _randomAngle, 3] call FUNC(suppressDirection);
    //    };
    //};
}, 1, [
    _group,
    _supportedGroup,
    _targetPos,
    _compRadius
]] call CBA_fnc_addPerFrameHandler;
