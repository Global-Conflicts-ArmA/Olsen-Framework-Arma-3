#include "script_component.hpp"

params ["_group", "_targetPos", ["_compradius", 250, [0]]];
LOG_1("combatAssault started _this: %1",_this);

private _leader = leader _group;
private _units = units _group;

[_group] call CBA_fnc_clearWaypoints;
[_group, _targetPos, 100, "SAD", "COMBAT", "RED"] call CBA_fnc_addWaypoint;

private _arrayTest = ["AUTOCOMBAT", "COVER", "SUPPRESSION", "AUTOTARGET", "TARGET", "FSM"];
_group enableAttack false;
_units apply {
    private _unit = _x;
    _arrayTest apply {
        _unit disableAI _x;
    };
};
_group setBehaviour "AWARE";
//_group setFormation "DIAMOND";
_group setCombatMode "BLUE";
_group setSpeedMode "FULL";

// manoeuvre function
private _assaultTaskPFH = [{
    params ["_args", "_idPFH"];
    _args params ["_group", "_targetPos", "_units", "_compradius"];
    _units = _units select {_x call EFUNC(FW,isAlive)};
    private _leader = leader _group;
    private _veh = vehicle _leader;
    if (
        (_units isEqualTo []) ||
        {_veh isEqualTo _leader} ||
        {!((GETVAR(_group,Task,"PATROL")) isEqualTo "ASSAULT")} ||
        {(GETVAR(_group,ExitAssault,false))} ||
        {
            (getPosATL _leader distance2D _targetPos) <= _compradius
        } ||
        {
            !(((_group call FUNC(EnemyArray)) findif {
                ((_leader distance2D _x) <= (GETVAR(_group,AssaultEngageDistance,200))) &&
                {[_leader, _x] call FUNC(LOSCheck)}
            }) isEqualTo -1)
        }
    ) exitWith {
        [_idPFH] call CBA_fnc_removePerFrameHandler;
        TRACE_1("Group exited Assault PFH",_group);
        SETVAR(_group,ExitAssault,false);
        _units apply {
            private _unit = _x;
            ["AUTOCOMBAT", "COVER", "SUPPRESSION", "AUTOTARGET", "TARGET", "FSM"] apply {
                _unit enableAI _x;
            };
            _group setCombatMode "RED";
            _group setBehaviour "COMBAT";
            _group enableAttack true;
        };
        //if (RNG(0.5)) then {
        //    [_group, _targetPos] call FUNC(CombatAttack);
        //} else {
            [_group] call FUNC(CombatDefend);
        //};
    };
    _group setCombatMode "BLUE";
    _group setBehaviour "AWARE";
    _group setSpeedMode "FULL";
    private _driver = driver _veh;
    _driver doMove _targetPos;
}, 5, [_group, _targetPos, _units, _compradius]] call CBA_fnc_addPerFrameHandler;

SETVAR(_group,Task,"ASSAULT");
