//Modified creep script by nKenny
//[UNIT, DISTANCE] call AITSK_fnc_taskCreep;

#include "script_component.hpp"

// init
params ["_group",["_range",500],["_cycle",15]];

// sort grp
if (!local _group) exitWith {};

if (_group isEqualType objNull) then {
	_group = group _group;
};

// orders
_group setbehaviour "AWARE";
_group setFormation "DIAMOND";
_group setSpeedMode "LIMITED";
_group setCombatMode "GREEN";
_group enableAttack false;

///{_x forceWalk true;} foreach units _group;  <-- Use this if behaviour set to "STEALTH"

// failsafe!
{
    doStop _x;

    _x addEventhandler ["FiredNear",{
        params ["_unit"];
        doStop _x;
        _unit setCombatMode "RED";
        _unit suppressFor 4;
        group _unit enableAttack true;
        _unit removeEventHandler ["FiredNear",_thisEventHandler];
	}];

    true
} count units _group;

_group setVariable [QGVAR(nextCycleTime), 0, false];

[{
	params ["_args","_handle"];
	_args params ["_group","_range","_cycle"];

	if (simulationEnabled leader _group && {CBA_missionTime > _group getVariable QGVAR(nextCycleTime)} && { {alive _x} count (units _group) > 0 }) then {
		/* private _combat = behaviour leader _group isEqualTo "COMBAT";
		private _onFoot = (isNull objectParent (leader _group)); */

		private _target = [_group,_range] call FUNC(findTarget);

		if (!isNull _target) then {
			[_group,_target] call FUNC(creepOrders);

			_group setVariable [QGVAR(nextCycleTime), (CBA_missionTime + 30), false];
		} else {
			_group setCombatMode "GREEN";

			_group setVariable [QGVAR(nextCycleTime), (CBA_missionTime + 120), false];
		};
	};

	if ({alive _x} count (units _group) < 1) then {
		[_handle] call CBA_fnc_removePerFrameHandler;
	};
}, 5, [_group,_range,_cycle]] call CBA_fnc_addPerFrameHandler;
