#include "script_component.hpp"

private _markerArray = [];

params ["_posArray", "_width", "_colorArray"];
_colorArray params ["_color", "_alpha"];

for "_x" from 0 to (count _posArray - 2) do {
	private _center = [((_posArray select _x select 0) + (_posArray select _x + 1 select 0)) / 2, ((_posArray select _x select 1) + (_posArray select _x + 1 select 1)) / 2];
	private _direction = ((_posArray select _x + 1 select 0) - (_posArray select _x select 0)) atan2 ((_posArray select _x + 1 select 1) - (_posArray select _x select 1));
	private _length = sqrt (((_posArray select _x select 0) - (_posArray select _x + 1 select 0)) ^ 2 + ((_posArray select _x select 1) - (_posArray select _x + 1 select 1)) ^ 2);
	private _marker = if (getMarkerColor "MapLettering_1" isEqualTo "") then {
		"MapLettering_1"
	} else {
		for "_y" from 1 to 9001 do {
			_marker = "MapLettering_" + str(_y);
			if (getMarkerColor _marker isEqualTo "") exitWith {
				_marker
			};
		};
	};
	createMarkerLocal [_marker, _center];
	_marker setMarkerShapeLocal "RECTANGLE";
	_marker setMarkerBrushLocal "SolidFull";
	_marker setMarkerSizeLocal [_width / 2, _length / 2];
	_marker setMarkerDirLocal _direction;
	_marker setMarkerAlphaLocal _alpha;
	_marker setMarkerColorLocal _color;
	_markerArray pushBack _marker;
};

_posArray apply {
	private _marker = if (getMarkerColor "MapLettering_1" isEqualTo "") then {
		"MapLettering_1"
	} else {
		for "_y" from 1 to 9001 do {
			_marker = "MapLettering_" + str(_y);
			if (getMarkerColor _marker isEqualTo "") exitWith {
				_marker
			};
		};
	};
	createMarkerLocal [_marker, _x];
	_marker setMarkerShapeLocal "ELLIPSE";
	_marker setMarkerBrushLocal "SolidFull";
	_marker setMarkerSizeLocal [_width / 2, _width / 2];
	_marker setMarkerAlphaLocal _alpha;
	_marker setMarkerColorLocal _color;
	_markerArray pushBack _marker;
};

_markerArray
