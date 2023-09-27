#include "script_component.hpp"

private _allowedOutside = true;
private _vehicle = (vehicle player);
private _startPos = getPosATL _vehicle;

GVAR(markers) apply {
	_x params ["_side", "_name"];
	if (_side == (side player) || _side == sideEmpty) then {
		if (_vehicle inArea _name) exitWith {
			_allowedOutside = false;
		};
	};
};

/* diag_log format ["INFO: Processing markers = %1", _processingMarkers]; */

GVAR(mainAOLimitLoop) = [{
	params ["_args", "_idPFH"];
	_args params [
		"_allowedOutside",
		"_lastInPos"
	];
	if (GVAR(markers) isEqualTo []) exitWith {
		[_idPFH] call CBA_fnc_removePerFrameHandler;
	};
	private _vehicle = (vehicle player);
	if !(_vehicle isKindOf "Air") then {
		private _outSide = true;
		//TRACE_1("starting AOLIMIT loop", GVAR(markers));
		GVAR(markers) apply {
			_x params ["_side", "_name"];
			if (_side == (side player) || _side == sideEmpty) then {
				if (_vehicle inArea _name) exitWith {
					_outSide = false;
					//TRACE_1("in AO marker", _name);
				};
			};
		};
		if (_outSide) then {
			if (
				!(_allowedOutside) && 
				{(_vehicle call EFUNC(FW,isAlive))} && 
				{local _vehicle}
			) then {
				//TRACE_1("outside all AOs, resetting pos", _lastInPos);
				_vehicle setPosATL _lastInPos;
				_vehicle setVelocity (velocity _vehicle apply {- _x});
			} else {
				//TRACE_1("outside all AOs but allowed", _lastInPos);
			};
		} else {
			_lastInPos = getPosATL _vehicle;
			//TRACE_1("in AO limit", _lastInPos);
			_allowedOutside = false;
			_args set [0, _allowedOutside];
			_args set [1, _lastInPos];
		};
	} else {
		_allowedOutside = true;
	};
}, 0, [_allowedOutside, _startPos]] call CBA_fnc_addPerFrameHandler;
