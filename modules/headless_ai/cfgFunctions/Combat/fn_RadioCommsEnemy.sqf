#include "..\..\script_macros.hpp"


params ["_groupcaller","_enemycaller","_sidecaller"];

if (GVAR(Debug)) then {
	TRACE_3("radiocomms params",_groupcaller,_enemycaller,_sidecaller);
};

{
	_x params ["_side","_group","_leader","_groupcount","_behaviourtasking","_behaviour","_target","_position","_hasRadio","_areaAssigned", "_assetType"];
	if (GVAR(Debug)) then {
		TRACE_1("radiocomms fnc",_group);
	};
	if (!(_groupcaller isEqualTo _group)) then {
		private _isFriendly = [_sidecaller, _side] call BIS_fnc_sideIsFriendly;
		if (GVAR(Debug)) then {
			TRACE_2("radiocomms fnc",_group,_isFriendly);
		};
		if (_isFriendly) then {
			if (!(_enemycaller isEqualTo _target) && {((_enemycaller distance _target) > 100)}) then {
				if ((_hasRadio) || !(PZAI_RadioNeedRadio)) then {
					private _distanceToUnit = _enemycaller distance2d _leader;
					if (_distanceToUnit <= PZAI_RadioDistance) then {
						private _needReinforcement = [_groupcaller,_enemycaller,CBA_MissionTime,_group] call FUNC(ReinforcementResponse);
						[_Group,_enemycaller,_needReinforcement] call FUNC(CombatResponse);
						if (GVAR(Debug)) then {
							LOG_1("_group: %1 called combatresponse",_group);
						};
					};
				};
			};
		};
	};
} foreach GVAR(GroupArray);
