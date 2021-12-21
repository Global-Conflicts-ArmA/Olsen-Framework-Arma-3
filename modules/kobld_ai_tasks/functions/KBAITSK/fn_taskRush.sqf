//Modified fnc_taskRush by nKenny
//[UNIT, DISTANCE] call KBAITSK_fnc_taskRush;

#include "script_component.hpp"

params ["_group",["_range",500],["_cycle",15]];

/* INFO("IN TASK RUSH"); */
/* LOG_2("_group = %1, _range = %2", _group, _range); */

if !(local _group) exitWith {};

if (_group isEqualType objNull) then {
	_group = group _group;
};

_group setSpeedMode "FULL";
_group setFormation "WEDGE";
_group enableAttack false;

(units _group) apply {
	_x disableAI "AUTOCOMBAT";

	dostop _x;
};

_group setVariable [QGVAR(nextCycleTime), 0, false];

[{
	/* INFO("Running loop."); */
	params ["_args","_handle"];
	_args params ["_group","_range","_cycle"];

	if (simulationEnabled leader _group && {CBA_missionTime > _group getVariable QGVAR(nextCycleTime)} && { {alive _x} count (units _group) > 0 }) then {
		private _target = [_group,_range] call FUNC(findTarget);

		if (!isNull _target) then {
			[_group, _target] call FUNC(rushOrders);

			_group setVariable [QGVAR(nextCycleTime), (CBA_missionTime + _cycle), false];
		} else {
			_group setVariable [QGVAR(nextCycleTime), (CBA_missionTime + 60), false];
		};
	};

	if ({alive _x} count (units _group) < 1) then {
		[_handle] call CBA_fnc_removePerFrameHandler;
	};
}, 5, [_group,_range,_cycle]] call CBA_fnc_addPerFrameHandler;

true
