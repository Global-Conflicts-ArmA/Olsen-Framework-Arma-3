#include "script_component.hpp"

if ((count GVAR(markers)) > 0) then {
	private _anySide = sideLogic;
	private _processingMarkers = [];
	private _allowedOutside = true;
	private _vehicle = (vehicle player);

	/* diag_log "INFO: In init.."; */
	/* diag_log format ["INFO: markers = %1", GVAR(markers)]; */

	GVAR(markers) apply {
		_x params ["_side", "_name"];

		/* diag_log format ["INFO: _side == _anySide ? %1", (_side == _anySide)]; */

		if (_side == (side player) || _side == _anySide) then {
			_processingMarkers pushBack _name;

			if (_vehicle inArea  _name) then {
				_allowedOutside = false;
			};
		};
	};

	/* diag_log format ["INFO: processing markers = %1", _processingMarkers]; */
	if ((count _processingMarkers) > 0) then { // If there's at least 1 marker which applies to this player
		private _delay = 0.1;
		[{
			(_this select 0) params ["_vehicle1", "_processingMarkers1", "_allowedOutside1"];
			_vehicle1 = (vehicle player);
			/* private _pos = player getVariable [QGVAR(pos), _startPos1]; */
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

			/* diag_log format ["INFO: outside? = %1", _outSide]; */
			/* diag_log format ["INFO: allowed outside? = %1", _allowedOutside1]; */
			/* diag_log format ["INFO: displayed? = %1", _displayed]; */
			/* diag_log format ["INFO: Vehicle alive? %1", (_vehicle1 call EFUNC(FW,isAlive))]; */

			if (_outSide) then {
				/* diag_log "INFO: Yes we're outside.."; */
				if (!(_allowedOutside1) && !_displayed && (_vehicle1 call EFUNC(FW,isAlive))) then {
					private _timeLeft = if (_air) then {GVAR(AOTimerAir)} else {GVAR(AOTimer)};

					/* diag_log "INFO: Showing warning.."; */
					missionNamespace setVariable ["FW_AOL_TimeLeft", _timeLeft];
					cutRsc ["RscAOLimit", "PLAIN", 0.5, false];
				};
			} else {
				_allowedOutside1 = false;
			};
		}, _delay, [_vehicle, _processingMarkers, _allowedOutside]] call CBA_fnc_addPerFrameHandler;
	};
};
