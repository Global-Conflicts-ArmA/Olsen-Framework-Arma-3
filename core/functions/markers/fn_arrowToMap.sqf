#include "script_component.hpp"

params ["_position", "_sizeArray", "_colorArray", ["_textArray", [], [[]]]];
_sizeArray params ["_direction", "_length", "_width", "_thickness"];
_colorArray params ["_color", "_alpha"];

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

private _positionArray = [_position];
[
	[-_width atan2 -_width, 2 * _width ^ 2],
	[-_width atan2 (_width / -2), 1.25 * _width ^ 2],
	[-_length atan2 (_width / -2), _length ^ 2 + (_width / 2) ^ 2],
	[-(_length atan2 (_width / 2)), _length ^ 2 + (_width / 2) ^ 2],
	[-(_width atan2 (_width / 2)), 1.25 * _width ^ 2],
	[-(_width atan2 _width), 2 * _width ^ 2]
] apply {
	_positionArray pushBack [
		(_position select 0) + sin (270 + _direction + (_x select 0)) * sqrt (_x select 1),
		(_position select 1) + cos (270 + _direction + (_x select 0)) * sqrt (_x select 1)
	];
};

_positionArray pushBack _position;
private _markerArray = [
	_positionArray,
	_thickness,
	[_color, _alpha]
] call FUNC(drawToMap);

if !(_textArray isEqualTo []) then {
	_textArray params ["_text", "_textPosition", "_textColor", "_textAlpha"];
	_text = " " + _text;
	private _textLength = 0;
	(toArray _text) apply {
		private _symbol = toString [_x] call FUNC(writeToMapFont);
		_textLength = _textLength + (_symbol select 1) * _width / 30;
	};
	private _textOffset = 0;
	private _textDirection = if (_direction / 360 mod 1 <= 0.5) then {
		_textOffset = switch (toUpper _textPosition) do {
			case "front": {
				_width + _textLength
		    };
		    case "back": {
				_length
		    };
		    default {
			    (_length + _textLength) / 2
		    };
		};
		90 - _direction
	} else {
		_textOffset = switch (toUpper _textPosition) do {
			case "front": {
				_width
		    };
		    case "back": {
				_length - _textLength
		    };
		    default {
			    (_length - _textLength) / 2
		    };
		};
		-90 - _direction
	};
	private _markerTextArray = [
		[
			(_position select 0) + sin (180 + _direction) * _textOffset,
			(_position select 1) + cos (180 + _direction) * _textOffset
		],
		[_textDirection, _width / 30],
		[_text, _textColor, _textAlpha]
	] call FUNC(writeToMap);
	_markerArray append _markerTextArray;
};

_markerArray append (GETMVAR(markerArray,[]));
SETMVAR(markerArray,_markerArray);

_markerArray
