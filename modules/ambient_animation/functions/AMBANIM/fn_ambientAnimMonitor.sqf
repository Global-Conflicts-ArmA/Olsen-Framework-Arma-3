#include "script_component.hpp"

/*
Function by TinfoilHate. Works in concert with ambientAnim and waypoints, so you can have a unit perform an ambient animation at a waypoint until something happens that it needs to react to. Kind of a waypoint-based replacement for ambientAnimCombat.
//Example: [this,["WATCH","ASIS"],15,true] call AMBANIM_fnc_ambientAnimMonitor;
*/
params[
	["_unit", objNull, [objNull]],
	["_anim", "SIT", ["SIT"]],
	["_cond", false, [true, 0]],
	["_wait", false, [true]]
];

if (!local _unit) exitWith {};
if (behaviour _unit == "COMBAT") exitWith {};

_unit setVariable ["ambientAnimMonitor_exit", false, false];
_unit setVariable ["ambientAnimMonitor_wait", _wait, false];
private _hurt = _unit getVariable ["ambientAnimMonitor_damage", damage _unit];
_anim = [_unit, _anim select 0, _anim select 1];

_anim call FUNC(ambientAnim);

if (_cond isEqualType "SCALAR") then {
	[{_this setVariable ["ambientAnimMonitor_exit",true,false];}, _unit, _cond] call CBA_fnc_waitAndExecute;
	[{!alive (_this select 0) || behaviour (_this select 0) == "COMBAT" || damage (_this select 0) > (_this select 1) || (_this select 0) call BIS_fnc_enemyDetected}, {(_this select 0) setVariable ["ambientAnimMonitor_exit",true,false]}, [_unit,_hurt]] call CBA_fnc_waitUntilAndExecute;
} else {
	[{!alive (_this select 0) || behaviour (_this select 0) == "COMBAT" || damage (_this select 0) > (_this select 1) || (_this select 0) call BIS_fnc_enemyDetected || (_this select 2)}, {(_this select 0) setVariable ["ambientAnimMonitor_exit",true,false]; }, [_unit,_hurt,_cond]] call CBA_fnc_waitUntilAndExecute;
};

[{_this getVariable ["ambientAnimMonitor_exit", false]}, {
	if (_this getVariable ["ambientAnimMonitor_wait", false]) then {_this disableAI "PATH"};
	[_this] call FUNC(ambientAnimTerminate);
	[{behaviour _this != "COMBAT"}, {
		if (_this getVariable ["ambientAnimMonitor_wait", false]) then {_this enableAI "PATH"};
		_this setVariable ["ambientAnimMonitor_damage",damage _this,false];
		_this setVariable ["ambientAnimMonitor_exit", nil, false];
	}, _this] call CBA_fnc_waitUntilAndExecute;
}, _unit] call CBA_fnc_waitUntilAndExecute;
