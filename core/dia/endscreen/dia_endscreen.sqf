#include "..\..\script_macros.hpp"

90001 cutRsc ["DIA_ENDSCREEN", "PLAIN"];
private _bg = 3000;
private _endTitle = 3001;
private _left = 3002;
private _right = 3003;
private _bottomLeft = 3004;
private _bottomMiddle = 3005;
private _bottomRight = 3006;

params ["_scenario", "_timeLimit", "_teams"];

{
	_x enableSimulation false;
} forEach vehicles;

[{
	{
		_x enableSimulation false;
	} forEach allUnits;
}, [], 1] call CBA_fnc_waitAndExecute;

private _leftText = "";
private _rightText = "";
private _bottomTextLeft = "";
private _bottomTextMiddle = "";
private _bottomTextRight = "";
private _textSide = 0;
{

	_x params ["_name", "_side", "_type", "_start", "_current", "_disabled", "_destroyed"];

	private _temp = format ["%1<br />Casualties: %2 out of %3<br />", _name, (_start - _current), _start];

	if (count _disabled != 0) then {
		_temp = _temp + "<br />Disabled assets:<br />";
		{
			_temp = _temp + format ["%1<br />", _x];
		} forEach _disabled;
	};

	if (count _destroyed != 0) then {
		_temp = _temp + "<br />Destroyed assets:<br />";
		{
			_temp = _temp + format ["%1<br />", _x];
		} forEach _destroyed;
	};

	_temp = _temp + "<br />";

	if (_textSide isEqualTo 0) then {
		_textSide = 1;
		_leftText = _leftText + _temp;
	} else {
		_textSide = 0;
		_rightText = _rightText + _temp;
	};

} forEach _teams;

private _endTitleText = _scenario;

if (_timeLimit != 0) then {

	private _time = ceil(time / 60);

	if (_time >= _timeLimit) then {

		_time = _timeLimit;

	};

	private _timeLimitText = format ["Mission duration: %1 out of %2 minutes", _time, _timeLimit];

	_endTitleText = format ["%1<br />%2", _scenario, _timeLimitText];

};

if (!isNil "aCount_textBLU" && !isNil "aCount_textRED" && !isNil "aCount_textRES") then {
	_bottomTextLeft = format["%1",aCount_textBLU];
	_bottomTextMiddle = format["%1",aCount_textRED];
	_bottomTextRight = format["%1",aCount_textRES];
};

disableSerialization;
private _dia = uiNamespace getVariable QGVAR(EndScreen);

(_dia displayCtrl _endTitle) ctrlSetStructuredText parseText _endTitleText;
(_dia displayCtrl _left) ctrlSetStructuredText parseText _leftText;
(_dia displayCtrl _right) ctrlSetStructuredText parseText _rightText;
(_dia displayCtrl _bottomLeft) ctrlSetStructuredText parseText _bottomTextLeft;
(_dia displayCtrl _bottomMiddle) ctrlSetStructuredText parseText _bottomTextMiddle;
(_dia displayCtrl _bottomRight) ctrlSetStructuredText parseText _bottomTextRight;


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

