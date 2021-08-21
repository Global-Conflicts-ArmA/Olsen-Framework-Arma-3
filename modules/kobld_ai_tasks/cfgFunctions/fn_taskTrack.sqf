//Modified Tracker Script by nkenny
//[GROUP,RANGE] call kobld_ai_tasks_fnc_taskTrack;

#include "..\script_component.hpp"

params ["_group",["_range",500],["_cycle",(60 + random 30)]];

if (!local _group) exitWith {};

if (_group isEqualType objNull) then {
	_group = group _group;
};

// orders
_group setBehaviour "SAFE";
_group setSpeedMode "LIMITED";

_group setVariable [QGVAR(nextCycleTime), 0, false];

// Hunting loop
[{
	params ["_args","_handle"];
	_args params ["_group","_range","_cycle"];

	if (simulationEnabled leader _group && {CBA_missionTime > _group getVariable QGVAR(nextCycleTime)} && { {alive _x} count (units _group) > 0 }) then {
		_combat = behaviour leader _group isEqualTo "COMBAT";
		_onFoot = (isNull objectParent (leader _group));

		_target = [_group,_range] call FUNC(findTarget);

		if (!isNull _target) then {
			_group move (_target getPos [random 200,random 360]);
			_group setFormDir (leader _group getDir _target);
			_group setBehaviour "AWARE";
			_group setSpeedMode "NORMAL";
			_group enableGunLights "forceOn";
			_group enableIRLasers true;

			// flare
			if (!_combat && {_onFoot} && {random 1 > 0.8}) then {
				[_group] call FUNC(flare);
			};

			// suppress building BUILDING SUPPRESSION!
			if (_combat && {(nearestBuilding _target distance2D _target < 25)}) then {
				[_group,_target] call FUNC(suppress);
			};
		};
		
		_group setVariable [QGVAR(nextCycleTime), (CBA_missionTime + _cycle), false];
	};
	
	if ({alive _x} count (units _group) < 1) then {
		[_handle] call CBA_fnc_removePerFrameHandler;
	};	
}, 5, [_group,_range,_cycle]] call CBA_fnc_addPerFrameHandler;

true