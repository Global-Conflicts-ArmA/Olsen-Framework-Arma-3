#include "..\..\script_macros.hpp"


//FUNC(CombatResponse)

params ["_Group",["_RadioEnemy",objnull],["_reinforcement",false]];

private _leader = leader _group;
private _currentmission = GETVAR(_group,Mission,"NONE");
if (behaviour _leader isEqualTo "SAFE") then {
	_group setbehaviour "AWARE";
};
private _currenttarget = GETVAR(_group,CurrentTarget,objnull);
if (!(_RadioEnemy isEqualTo objnull) && {(_currenttarget isEqualTo objnull)}) then {
	_currenttarget = _RadioEnemy;
	SETVAR(_group,CurrentTarget,_RadioEnemy);
};
private _enemydir = _leader getdir _currenttarget;
private _enemydist = _leader distance _currenttarget;

switch (_currentmission) do {
	case "GARRISON": {};
	case "STATIONARY": {};
	case "BUNKER": {};
	case "PATROL": {
			if (_enemydist < 150) then {
				if (_reinforcement) then {
					[_Group,_currenttarget,_enemydir] call FUNC(CombatAttack);
				} else {
					[_Group,_currenttarget,_enemydir] call FUNC(CombatDefend);
				};
			} else {
				if (_reinforcement) then {
					[_Group,_currenttarget,_enemydir] call FUNC(CombatMoveTo);
				} else {
					[_Group,_currenttarget,_enemydir] call FUNC(CombatDefend);
				};
			};
		};
	case "LOITER": {
			_Group setSpeedMode "FULL";
			{_x setUnitPos "AUTO";} foreach (units _group);
			if (_reinforcement) then {
				[_Group,_currenttarget,_enemydir] call FUNC(CombatAttack);
			} else {
				[_Group,_currenttarget,_enemydir] call FUNC(CombatDefend);
			};
		}; //regroups unit via a different function
	case "IDLE": {
			if (_enemydist < 150) then {
				if (_reinforcement) then {
					[_Group,_currenttarget,_enemydir] call FUNC(CombatAttack);
				} else {
					[_Group,_currenttarget,_enemydir] call FUNC(CombatDefend);
				};
			} else {
				if (_reinforcement) then {
					[_Group,_currenttarget,_enemydir] call FUNC(CombatMoveTo);
				} else {
					[_Group,_currenttarget,_enemydir] call FUNC(CombatDefend);
				};
			};
		};
	case "NONE": {
			if (_enemydist < 150) then {
				if (_reinforcement) then {
					[_Group,_currenttarget,_enemydir] call FUNC(CombatAttack);
				} else {
					[_Group,_currenttarget,_enemydir] call FUNC(CombatDefend);
				};
			} else {
				if (_reinforcement) then {
					[_Group,_currenttarget,_enemydir] call FUNC(CombatMoveTo);
				} else {
					[_Group,_currenttarget,_enemydir] call FUNC(CombatDefend);
				};
			};
		};
	default {
		if (_enemydist < 150) then {
			if (_reinforcement) then {
				[_Group,_currenttarget,_enemydir] call FUNC(CombatAttack);
			} else {
				[_Group,_currenttarget,_enemydir] call FUNC(CombatDefend);
			};
		} else {
			if (_reinforcement) then {
				[_Group,_currenttarget,_enemydir] call FUNC(CombatMoveTo);
			} else {
				[_Group,_currenttarget,_enemydir] call FUNC(CombatDefend);
			};
		};
	};
};
