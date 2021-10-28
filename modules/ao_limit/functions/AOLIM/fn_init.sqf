#include "script_component.hpp"

private _anySide = sideLogic;
private _processingMarkers = [];
private _allowedOutside = true;
private _vehicle = (vehicle player);
private _pos = getPosATL _vehicle;

GVAR(markers) apply {
	_x params ["_side", "_name"];

	if (_side == (side player) || _side == _anySide) then {
		_processingMarkers pushBack _name;

		if (_vehicle inArea  _name) then {
			_allowedOutside = false;
		};
	};
};

/* diag_log format ["INFO: Processing markers = %1", _processingMarkers]; */

private _delay = 0.1;
[{
	(_this select 0) params ["_vehicle1", "_processingMarkers1", "_allowedOutside1", "_pos1"];
	_vehicle1 = (vehicle player);

	if !(_vehicle1 isKindOf "Air") then {
		private _outSide = true;
		_processingMarkers1 apply {
			if (_vehicle1 inArea _x) exitWith {
				_outSide = false;
			};
		};

		if (_outSide) then {
			if (!(_allowedOutside1) && (_vehicle1 call EFUNC(FW,isAlive)) && local _vehicle1) then {
				_vehicle1 setPosATL _pos1;
				_vehicle1 setVelocity (velocity _vehicle1 apply {- _x});
			};
		} else {
			_allowedOutside1 = false;
			_pos1 = getPosATL _vehicle1;
		};
	} else {
		_allowedOutside1 = true;
	};
}, _delay, [_vehicle, _processingMarkers, _allowedOutside, _pos]] call CBA_fnc_addPerFrameHandler;
