#include "script_component.hpp"

params ["_marker", ["_centered", true, [true]], ["_zoomlevel", 0.4, [0]], ["_name", "AO", [""]], ["_bgColour", "ColorBlack", [""]]];

//delete old markers if present
if !(GVAR(map_cover) isEqualTo []) then {
	GVAR(map_cover) apply {deletemarker _x}; 
	GVAR(map_cover) = [];
};

GVAR(map_currentAO) = _marker;

private _backgroundColor = [_bgColour, "SolidFull"];
private _borderColor = ["ColorWhite", "SolidFull"];
private _lineColor = ["ColorBlack", "Border"];
private _mapAdjustment = worldSize * 2;
private _edgeWidth = 20;
private _pos = getMarkerPos _marker;
private _dir = markerDir _marker;
_pos params ["_posx", "_posy"];
(getMarkerSize _marker) params ["_sizeX", "_sizeY"];

for "_i" from 0 to 270 step 90 do {
	private _size1 = [_sizeX,_sizeY] select (abs cos _i);
	private _size2 = [_sizeX,_sizeY] select (abs sin _i);
	private _sizeMarker = [_size2,_mapAdjustment] select (abs sin _i);
	private _dirTemp = _dir + _i;
	private _markerPos = [
		_posX + (sin _dirTemp * _mapAdjustment),
		_posY + (cos _dirTemp * _mapAdjustment)
	];

	_marker = format ["CM_side_%1", _i];
	createMarkerLocal [_marker,_markerPos];
	_marker setMarkerPosLocal _markerPos;
	_marker setMarkerSizeLocal [_sizeMarker,_mapAdjustment - _size1];
	_marker setMarkerDirLocal _dirTemp;
	_marker setMarkerShapeLocal "RECTANGLE";
	_marker setMarkerBrushLocal (_backgroundColor select 1);
	_marker setMarkerColorLocal (_backgroundColor select 0);
	GVAR(map_cover) pushBack _marker;
};

for "_i" from 0 to 270 step 90 do {
	private _size1 = [_sizeX,_sizeY] select (abs cos _i);
	private _size2 = [_sizeX,_sizeY] select (abs sin _i);
	private _sizeMarker = _size2;
	private _dirTemp = _dir + _i;
	private _markerPos = [
		_posX + (sin _dirTemp * _size1),
		_posY + (cos _dirTemp * _size1)
	];
	_marker = format ["CM_edge_%1", _i];
	createMarkerLocal [_marker,_markerPos];
	_marker setMarkerPosLocal _markerPos;
	_marker setMarkerSizeLocal [_sizeMarker, _edgeWidth];
	_marker setMarkerDirLocal _dirTemp;
	_marker setMarkerShapeLocal "RECTANGLE";
	_marker setMarkerBrushLocal (_borderColor select 1);
	_marker setMarkerColorLocal (_borderColor select 0);
	GVAR(map_cover) pushBack _marker;
	
	_markerPos = [
		_posX + (sin _dirTemp * _size1) + (sin (_dirTemp + 90) * _size2),
		_posY + (cos _dirTemp * _size1) + (cos (_dirTemp + 90) * _size2)
	];
	_marker = format ["CM_edgecorner_%1", _i];
	createMarkerLocal [_marker,_markerPos];
	_marker setMarkerPosLocal _markerPos;
	_marker setMarkerSizeLocal [_edgeWidth, _edgeWidth];
	_marker setMarkerDirLocal _dirTemp;
	_marker setMarkerShapeLocal "RECTANGLE";
	_marker setMarkerBrushLocal (_borderColor select 1);
	_marker setMarkerColorLocal (_borderColor select 0);
	GVAR(map_cover) pushBack _marker;
};

//--- Frame
_marker = "CM_side_border";
createMarkerLocal [_marker, _pos];
_marker setMarkerPosLocal _pos;
_marker setMarkerSizeLocal [_sizeX - _edgeWidth,_sizeY - _edgeWidth];
_marker setMarkerDirLocal _dir;
_marker setMarkerShapeLocal "RECTANGLE";
_marker setMarkerBrushLocal (_lineColor select 1);
_marker setMarkerColorLocal (_lineColor select 0);
GVAR(map_cover) pushBack _marker;

//--- Frame
_marker = "CM_side_border_outside";
createMarkerLocal [_marker, _pos];
_marker setMarkerPosLocal _pos;
_marker setMarkerSizeLocal [_sizeX + _edgeWidth,_sizeY + _edgeWidth];
_marker setMarkerDirLocal _dir;
_marker setMarkerShapeLocal "RECTANGLE";
_marker setMarkerBrushLocal (_lineColor select 1);
_marker setMarkerColorLocal (_lineColor select 0);
GVAR(map_cover) pushBack _marker;


	
