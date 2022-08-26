#include "script_component.hpp"

if ((count GVAR(markers)) > 0) then {
	private _anySide = sideLogic;
	private _processingMarkers = [];
	private _allowedOutside = true;
	private _vehicle = (vehicle player);

	GVAR(markers) apply {
		_x params ["_side", "_name"];

		if (_side == (side player) || _side == _anySide) then {
			_processingMarkers pushBack _name;

			if (_vehicle inArea  _name) then {
				_allowedOutside = false;
			};
		};
	};

	if ((count _processingMarkers) > 0) then { // If there's at least 1 marker which applies to this player
		private _delay = 0.1;
		[{
			(_this select 0) params ["_vehicle1", "_processingMarkers1", "_allowedOutside1"];
			_vehicle1 = (vehicle player);
			private _air = _vehicle1 isKindOf "Air";
			_allowedOutside1 = (GVAR(AOTimer) < 0 && !_air) || (GVAR(AOTimerAir) < 0 && _air);
			private _outSide = true;

			_processingMarkers1 apply {
				if (_vehicle1 inArea  _x) exitWith {
					_outSide = false;
				};
			};

			private _displayed = missionNamespace getVariable ["FW_AOL_Display", false];
			missionNamespace setVariable ["FW_AOL_Display", _outSide];

			if (_outSide) then {
				if (!(_allowedOutside1) && !_displayed && (_vehicle1 call EFUNC(FW,isAlive))) then {
					private _timeLeft = if (_air) then {GVAR(AOTimerAir)} else {GVAR(AOTimer)};

					if (GVAR(AudibleWarning)) then {
						playSound "ao_warning";
					};

					missionNamespace setVariable ["FW_AOL_TimeLeft", _timeLeft];
					cutRsc ["RscAOLimit", "PLAIN", 0.5, false];
				};
			} else {
				_allowedOutside1 = false;
			};
		}, _delay, [_vehicle, _processingMarkers, _allowedOutside]] call CBA_fnc_addPerFrameHandler;
	};
};
