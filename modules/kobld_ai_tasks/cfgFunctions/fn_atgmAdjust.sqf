//[this,"init","_this addEventHandler ['Fired', { _this call kobld_fnc_atgm; }];"] call PZAI_FNC_setInit;
//this addEventHandler ["Fired", { _this call kobld_ai_tasks_fnc_atgm; }];

#include "..\script_component.hpp"

params ["_missile","_unit",["_debug",false]];

private _mv = velocity _missile;
private _vel = (3.6 * sqrt( (_mv select 0) ^ 2 + (_mv select 1) ^ 2 + (_mv select 2) ^ 2)) * 0.278;
private _skill = _unit skill "aimingShake";
private _amt = ((0.13 - ((_skill) * 0.01)) + ((_unit distance2D _missile) * (0.00005 * (1.6 - _skill))));

if((random 10000) > 9999) then {
	_amt = _amt * (random 100);

	if (_debug) then {
		drop ["\Ca\Data\Cl_basic","","Billboard",1,20,(getPosATL _missile),[0,0,0],1,1.275,1.0,0.0,[10],[[1,1,0,1]],[0],0.0,2.0,"","",""];
	};
};

if(!alive (gunner _unit) || !alive _unit) then {
	_amt = _amt + random(5);

	if (_debug) then {
		drop ["\Ca\Data\Cl_basic","","Billboard",1,20,(getPosATL _missile),[0,0,0],1,1.275,1.0,0.0,[1],[[1,0,0,1]],[0],0.0,2.0,"","",""];
	};
} else {
	if (_debug) then {
		drop ["\Ca\Data\Cl_basic","","Billboard",1,20,(getPosATL _missile),[0,0,0],1,1.275,1.0,0.0,[1],[[0,1,0,1]],[0],0.0,2.0,"","",""];
	};
};

private _vd = (vectorDir _missile);

private _vdNew = [];

_vdNew pushBack ((_vd select 0) - (_amt / 1.1) + (random _amt));
_vdNew pushBack ((_vd select 1) - (_amt / 1.1) + (random _amt));
_vdNew pushBack ((_vd select 2) - (_amt / 1.1) + (random _amt));

_missile setVectorDir _vdNew;

if (_debug) then {
	systemChat format["%1 Vel:%2 Amt:%3 Skill:%4", diag_tickTime, _vel, _amt, _skill];
};