#include "..\..\script_macros.hpp"

params ["_scenario", "_timeLimit", "_teams", "_ammoInfo"];

{
	_x enableSimulation false;
} forEach (vehicles + allUnits);

90001 cutRsc ["DIA_ENDSCREEN", "PLAIN"];
private _bg = 1099;
private _endTitle = 1100;

private _left2 = 1101;
private _right2 = 1102;
private _bottomLeft2 = 1103;
private _bottomRight2 = 1104;

private _left3 = 1105;
private _middle3 = 1106;
private _right3 = 1107;
private _bottomLeft3 = 1108;
private _bottomMiddle3 = 1109;
private _bottomRight3 = 1110;

private _left4 = 1118;
private _middleLeft4 = 1117;
private _middleRight4 = 1115;
private _right4 = 1116;
private _bottomLeft4 = 1113;
private _bottomMiddleLeft4 = 1112;
private _bottomMiddleRight4 = 1111;
private _bottomRight4 = 1114;

private _teamTextArray = [];

{
	_x params ["_name", "_side", "_type", "_total", "_current", "_disabled", "_destroyed"];

	private _temp = format ["%1<br />Casualties: %2 out of %3<br />", _name, (_total - _current), _total];

	if (_disabled isNotEqualTo []) then {
		_temp = _temp + "<br />Disabled assets:<br />";
		{
			_x params ["_assetName", "_count"];
			_temp = _temp + format ["%1 x %2<br />", _assetName, _count];
		} forEach _disabled;
	};

	if (_destroyed isNotEqualTo []) then {
		_temp = _temp + "<br />Destroyed assets:<br />";
		{
			_x params ["_assetName", "_count"];
			_temp = _temp + format ["%1 x %2<br />", _assetName, _count];
		} forEach _destroyed;
	};

	//_temp = _temp + "<br />";
	_teamTextArray pushBack _temp;

} forEach _teams;

private _endTitleText = _scenario;

if (_timeLimit isNotEqualTo 0) then {
	private _time = ceil (CBA_missionTime / 60);
	if (_time >= _timeLimit) then {
		_time = _timeLimit;
	};

	private _timeLimitText = format ["Mission duration: %1 out of %2 minutes", _time, _timeLimit];
	_endTitleText = format ["%1<br />%2", _scenario, _timeLimitText];
};

disableSerialization;
private _dia = uiNamespace getVariable QGVAR(EndScreen);

(_dia displayCtrl _endTitle) ctrlSetStructuredText parseText _endTitleText;

switch (count _teamTextArray) do {
    case 2: {
		(_dia displayCtrl _left2) ctrlSetStructuredText parseText (_teamTextArray select 0);
		(_dia displayCtrl _right2) ctrlSetStructuredText parseText (_teamTextArray select 1);

		(_dia displayCtrl _bottomLeft2) ctrlSetStructuredText parseText (_ammoInfo select 0);
		(_dia displayCtrl _bottomRight2) ctrlSetStructuredText parseText (_ammoInfo select 1);
    };
	case 3: {
		(_dia displayCtrl _left3) ctrlSetStructuredText parseText (_teamTextArray select 0);
		(_dia displayCtrl _middle3) ctrlSetStructuredText parseText (_teamTextArray select 1);
		(_dia displayCtrl _right3) ctrlSetStructuredText parseText (_teamTextArray select 2);

		(_dia displayCtrl _bottomLeft3) ctrlSetStructuredText parseText (_ammoInfo select 0);
		(_dia displayCtrl _bottomMiddle3) ctrlSetStructuredText parseText (_ammoInfo select 1);
		(_dia displayCtrl _bottomRight3) ctrlSetStructuredText parseText (_ammoInfo select 2);
    };
	case 4: {
		(_dia displayCtrl _left4) ctrlSetStructuredText parseText (_teamTextArray select 0);
		(_dia displayCtrl _middleLeft4) ctrlSetStructuredText parseText (_teamTextArray select 1);
		(_dia displayCtrl _middleRight4) ctrlSetStructuredText parseText (_teamTextArray select 2);
		(_dia displayCtrl _right4) ctrlSetStructuredText parseText (_teamTextArray select 3);

		(_dia displayCtrl _bottomLeft4) ctrlSetStructuredText parseText (_ammoInfo select 0);
		(_dia displayCtrl _bottomMiddleLeft4) ctrlSetStructuredText parseText (_ammoInfo select 1);
		(_dia displayCtrl _bottomMiddleRight4) ctrlSetStructuredText parseText (_ammoInfo select 2);
		(_dia displayCtrl _bottomRight4) ctrlSetStructuredText parseText (_ammoInfo select 3);
    };
    default {
    	//code
    };
};

GVAR(endScreenPFH) = [{
    params ["_args", "_idPFH"];
	_args params ["_dia", "_bg", ["_count", 0, [0]]];
	private _alpha = (_count * (1/120));
	_count = _count + 1;
	_args set [2, _count];
    (_dia displayCtrl _bg) ctrlSetBackgroundColor [0, 0, 0, _alpha];
	//if (_count > 120) exitWith {
	//	[_idPFH] call CBA_fnc_removePerFrameHandler;
	//};
}, 0, [_dia, _bg]] call CBA_fnc_addPerFrameHandler;

[{
    endMission "END1";
}, [], 15] call CBA_fnc_waitAndExecute;
