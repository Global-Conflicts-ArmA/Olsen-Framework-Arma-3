//[this,"init","_this addEventHandler ['Fired', { _this call KBAITSK_fnc_atgm; }];"] call PZAI_FNC_setInit;
//this addEventHandler ["Fired", { _this call KBAITSK_fnc_atgm; }];

#include "script_component.hpp"

private _missile = _this select 6;
private _unit = _this select 0;

private _debug = false;

setAccTime 1;

[{
	params ["_args", "_handle"];
	_args params ["_missile", "_unit", "_debug"];

	if (alive _missile) then {
		[_missile, _unit, _debug] call FUNC(atgmAdjust);
	} else {
		[_handle] call CBA_fnc_removePerFrameHandler;
	};
}, 0.1, [_missile, _unit, _debug]] call CBA_fnc_addPerFrameHandler;
