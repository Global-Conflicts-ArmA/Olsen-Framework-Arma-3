#include "script_component.hpp"

params ["_unit"];

//group _unit call CBA_fnc_clearWaypoints;
removeAllWeapons _unit;
private _group = group _unit;
//_unit setSkill 0;
_unit enableFatigue false;
_unit setBehaviour "CARELESS";
_unit setUnitPos "UP";
_group setCombatMode "BLUE";
_group allowFleeing 0;
_group enableAttack false;
//doStop _unit;
//_unit setSkill ["courage", 1];
["FSM", "AUTOCOMBAT", "SUPPRESSION", "AIMINGERROR", "AUTOTARGET", "TARGET", "COVER"] apply {
    _unit disableAI _x;
};
//private _waypoint = [group _unit, _unit, 0, "MOVE", "CARELESS", "YELLOW", "FULL"] call CBA_fnc_addWaypoint;

private _attackSounds = [getMissionPath "modules\ayyLmao\sounds\attack1.ogg", getMissionPath "modules\ayyLmao\sounds\attack2.ogg"];
private _moveSounds = [getMissionPath "modules\ayyLmao\sounds\zombie1.ogg", getMissionPath "modules\ayyLmao\sounds\zombie2.ogg"];
private _moveAnims = ["amovpercmrunsnonwnondf","amovpercmwlksnonwnondf","amovpercmevasnonwnondf","amovpercmevasnonwnondf"];
private _attackAnim = "awoppercmstpsgthwnondnon_throw";
//private _attackAnim = "AwopPercMstpSgthWnonDnon_end";

if (_unit getVariable ["ACE_isUnconscious", false]) exitWith {};

[{
    params ["_args", "_idPFH"];
	_args params [
        "_unit",
        "_soundArray",
        "_animArray",
        ["_startPosition", [], [[]]],
        ["_lastSoundTime", CBA_missionTime - 8, [0]],
        ["_target", objnull, [objnull]],
        ["_lastCheckTime", CBA_missionTime - 2, [0]],
        ["_targetPos", [], [[]]]
    ];
    _soundArray params ["_attackSounds", "_moveSounds"];
    _animArray params ["_moveAnims", "_attackAnim"];
    //if (CBA_missionTime < 60) exitwith {};
    if (!(alive _unit) || _unit getVariable ["ACE_isUnconscious", false]) exitwith {
        [_idPFH] call CBA_fnc_removePerFrameHandler;
    };
    if (_target isNotEqualTo objNull) exitWith {
        TRACE_1("target not NULL",_target);
        if (!alive _target || _unit distance2D _startPosition > 100) exitWith {
            _args set [5, objnull];
            _args set [7, []];
            TRACE_1("criminal reset",_target);
        };
        if (_unit distance _target <= 2.5) exitWith {
            [_unit, _attackAnim, 2] call ace_common_fnc_doAnimation;
            _unit setDir (_unit getDir _target);
            playSound3D [selectRandom _attackSounds, _unit];
            private _bodyPart = selectRandom ["Head", "Body", "LeftArm", "RightArm", "LeftLeg", "RightLeg"];
            private _damage = 0.02 + (random 0.15);
            [_target, _damage, _bodyPart, "stab", _target] call ace_medical_fnc_addDamageToUnit;
            TRACE_1("target attacked",_target);
        };
        private _enemyPos = getPosATL _target;
        if (CBA_missionTime >= _lastSoundTime + 8) then {
            _args set [4, CBA_missionTime];
            playSound3D [selectRandom _moveSounds, _unit];
        };
        if (_targetPos isEqualTo [] || _targetPos distance _enemyPos > 1) then {
            //doStop _unit;
            _targetPos = _enemyPos;
            _args set [7, _targetPos];
            TRACE_2("chase criminal",_target,_enemyPos);
        };
        _unit doMove _targetPos;
        _unit doWatch _target;
    };
    TRACE_1("target NULL",_target);
    //private _enemyArray = [group _unit] call EFUNC(PZAI,EnemyArray);
    private _enemyArray = [] call BIS_fnc_listPlayers;
    if (_enemyArray isNotEqualTo []) then {
        private _distanceArray = [];
        _enemyArray apply {
            private _enemyUnit = _x;
            if (
                !(_x getVariable ["ACE_isUnconscious", false]) &&
                {_x distance2D _startPosition <= 100}
            ) then {
                private _enemyDistance = _unit distance2d _enemyUnit;
                _distanceArray pushback [_enemyDistance,_enemyUnit];
            };
        };
        if (_distanceArray isNotEqualTo []) then {
            _distanceArray sort true;
            private _target = (_distanceArray select 0) select 1;
            _args set [5, _target];
            private _enemyPos = getPosATL _target;
            if (CBA_missionTime >= _lastSoundTime + 8) then {
                _args set [4, CBA_missionTime];
                playSound3D [selectRandom _moveSounds, _unit];
            };
            //doStop _unit;
            _unit doMove _enemyPos;
            _args set [7, _enemyPos];
            TRACE_2("found criminal",_target,_enemyPos);
        };
    } else {
        if (_target isEqualTo objNull && {_unit distance2D _startPosition > 10}) then {
            //doStop _unit;
            TRACE_1("reset to start position",_startPosition);
            _unit doMove _startPosition;
        };
    };
}, 0.5, [_unit, [_attackSounds, _moveSounds], [_moveAnims, _attackAnim], getPosATL _unit]] call CBA_fnc_addPerFrameHandler;
