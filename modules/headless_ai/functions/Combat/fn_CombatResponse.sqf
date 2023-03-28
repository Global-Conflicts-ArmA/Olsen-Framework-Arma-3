#include "script_component.hpp"


//FUNC(CombatResponse)

params ["_group", ["_radioEnemy", objnull, [objnull]], ["_reinforcement", false, [false]]];

private _leader = leader _group;
private _currentmission = SETVAR(_group,Task,"NONE");
if (behaviour _leader isEqualTo "SAFE") then {
	_group setbehaviour "AWARE";
};
private _currenttarget = GETVAR(_group,CurrentTarget,objnull);
if ((_radioEnemy isNotEqualTo objnull) && {(_currenttarget isEqualTo objnull)}) then {
	_currenttarget = _radioEnemy;
	SETVAR(_group,CurrentTarget,_radioEnemy);
};
private _enemydir = _leader getdir _currenttarget;
private _enemydist = _leader distance _currenttarget;

switch _currentmission do {
	case "GARRISON": {};
	case "STATIONARY": {};
	case "BUNKER": {};
	case "PATROL": {
			if (_enemydist <= 150) then {
				if (_reinforcement) then {
					[_group, _currenttarget] call FUNC(CombatAttack);
				} else {
					[_group, _currenttarget] call FUNC(CombatDefend);
				};
			} else {
				if (_reinforcement) then {
					[_group, _currenttarget] call FUNC(CombatMoveTo);
				} else {
					[_group, _currenttarget] call FUNC(CombatDefend);
				};
			};
		};
	case "LOITER": {
			_group setSpeedMode "FULL";
			units _group apply {
                _x doFollow leader _group;
                _x setUnitPos "Auto";
            };
			if (_reinforcement) then {
				[_group, _currenttarget] call FUNC(CombatAttack);
			} else {
				[_group, _currenttarget] call FUNC(CombatDefend);
			};
		}; //regroups unit via a different function
	case "IDLE": {
			if (_enemydist < 150) then {
				if (_reinforcement) then {
					[_group, _currenttarget] call FUNC(CombatAttack);
				} else {
					[_group, _currenttarget] call FUNC(CombatDefend);
				};
			} else {
				if (_reinforcement) then {
					[_group,_currenttarget,_enemydir] call FUNC(CombatMoveTo);
				} else {
					[_group,_currenttarget,_enemydir] call FUNC(CombatDefend);
				};
			};
		};
	case "NONE": {
			if (_enemydist < 150) then {
				if (_reinforcement) then {
					[_group, _currenttarget] call FUNC(CombatAttack);
				} else {
					[_group, _currenttarget] call FUNC(CombatDefend);
				};
			} else {
				if (_reinforcement) then {
					[_group, _currenttarget] call FUNC(CombatMoveTo);
				} else {
					[_group, _currenttarget] call FUNC(CombatDefend);
				};
			};
		};
	default {
		if (_enemydist < 150) then {
			if (_reinforcement) then {
				[_group, _currenttarget] call FUNC(CombatAttack);
			} else {
				[_group, _currenttarget] call FUNC(CombatDefend);
			};
		} else {
			if (_reinforcement) then {
				[_group, _currenttarget] call FUNC(CombatMoveTo);
			} else {
				[_group, _currenttarget] call FUNC(CombatDefend);
			};
		};
	};
};
