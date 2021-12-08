#include "script_component.hpp"

#include "\A3\ui_f\hpp\defineResinclDesign.inc"

disableserialization;

private _display = _this select 0;
/* private _ctrlTitle = _display displayCtrl 1001;
private _ctrlTitleBG = _display displayCtrl 1002; */
private _ctrlTime = _display displayCtrl 1003;

private _endTime = serverTime + (missionNamespace getVariable ["FW_AOL_TimeLeft", 0]);
private _nextBeep = _endTime - 10;

["AOLimitWarning"] call BIS_fnc_showNotification;

private _delay = 0.08;
[{
	_this params ["_args", "_idPFH"];
	_args params ["_endTime", "_nextBeep", "_ctrlTime"];
	private _break = false;
	private _shouldDisplay = missionNamespace getVariable ["FW_AOL_Display", false];

	if (serverTime >= _nextBeep) then {
		_nextBeep = _nextBeep + 1;
		playSound "Beep_Target";
	};

	private _timeLeft = _endTime - serverTime;

	private _colorSet = ["IGUI","TEXT_RGB"];
	if (_timeLeft <= 10) then {
		_colorSet = ["IGUI","WARNING_RGB"];
	};

	if (_timeLeft <= 5) then {
		_colorSet = ["IGUI","ERROR_RGB"];
	};

	private _color = _colorSet call bis_fnc_displaycolorget;
	_ctrlTime ctrlSetTextColor _color;

	if (_timeLeft > 0) then {
		_ctrlTime ctrlSetText ([_timeLeft,"MM:SS.MS"] call bis_fnc_secondsToString);
	} else {
		_ctrlTime ctrlSetText "00:00.000";
		player setDamage 1;
		_break = true;
	};

	if (_break || !_shouldDisplay) exitWith {
		_display closeDisplay 1;
		[_idPFH] call CBA_fnc_removePerFrameHandler;
	};
}, _delay, [_endTime, _nextBeep, _ctrlTime]] call CBA_fnc_addPerFrameHandler;
