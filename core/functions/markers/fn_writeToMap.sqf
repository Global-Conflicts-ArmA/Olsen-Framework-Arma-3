#include "script_component.hpp"

params ["_position", "_sizeArray", "_textArray"];
_sizeArray params ["_direction", "_scale"];
_textArray params ["_text", "_color", "_alpha"];
_text = toArray _text;
private _markerArray = [];
private _offset = [0, 0];

if !(_position isEqualType []) then {
	if (is3DEN) then {
		all3DENEntities params ["_objects","","","_systems","","_markers"];
		private _index = _markers findIf {((_x get3DENAttribute "markerName") select 0) == _position};
		if (_index > -1) then {
			_position = ((_markers select _index) get3DENAttribute "position") select 0;
		} else {
			private _index = _systems findIf {((_x get3DENAttribute "Name") select 0) == _position};
			if (_index > -1) then {
				_position = ((_systems select _index) get3DENAttribute "position") select 0;
			} else {
				private _index = _objects findIf {((_x get3DENAttribute "Name") select 0) == _position};
				if (_index > -1) then {
					_position = ((_objects select _index) get3DENAttribute "position") select 0;
				};
			};
		};
	} else {
		if !(getMarkerColor _position isEqualTo "") then {
			_position = getMarkerPos _position;
		} else {
			private _var = missionNamespace getVariable [_position, nil];
			if !(isNil "_var") then {
				_position = getPos _var;
			};
		};
	};
};

for "_y" from 0 to (count _text - 1) do {
	private _symbol = (toString [_text select _y]) call FUNC(writeToMapFont);
	(_symbol select 0) apply {
		private _vectorDirection = (_x select 0 select 0) atan2 (_x select 0 select 1) - _direction;
		private _vectorLength = sqrt ((_x select 0 select 0) ^ 2 + (_x select 0 select 1) ^ 2);
		private _adjustPosition = [sin _vectorDirection * _vectorLength * _scale, cos _vectorDirection * _vectorLength * _scale];
		private _adjustSize = _x select 1;
		private _adjustDirection = (_x select 2) - _direction;
		private _marker = if (getMarkerColor "MapLettering_0_1" isEqualTo "") then {
			"MapLettering_0_1"
		} else {
			for "_z" from 1 to 9001 do {
				_marker = "MapLettering_" + str(_y) + "_" + str(_z);
				if (getMarkerColor _marker isEqualTo "") exitWith {
					_marker
				};
			};
		};
		createMarkerLocal [_marker, [(_position select 0) + (_adjustPosition select 0) + (_offset select 0), (_position select 1) + (_adjustPosition select 1) + (_offset select 1)]];
		_marker setMarkerShapeLocal "RECTANGLE";
		_marker setMarkerBrushLocal "SolidFull";
		_marker setMarkerSizeLocal [_scale, _scale * _adjustSize];
		_marker setMarkerDirLocal _adjustDirection;
		_marker setMarkerAlphaLocal _alpha;
		_marker setMarkerColorLocal _color;
		_markerArray pushBack _marker;
	};
	_offset = [
		(_offset select 0) + (_symbol select 1) * _scale * cos _direction,
		(_offset select 1) + (_symbol select 1) * _scale * sin _direction
	];
};

_markerArray append (GETMVAR(markerArray,[]));
SETMVAR(markerArray,_markerArray);

_markerArray