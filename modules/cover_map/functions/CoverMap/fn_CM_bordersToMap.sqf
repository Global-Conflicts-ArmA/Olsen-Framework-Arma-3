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
private _mapAdjustment = worldSize;
private _edgeWidth = 10;
private _p = getMarkerPos _marker;
_p params ["_px", "_py"];
(getMarkerSize _marker) params ["_sizeX", "_sizeY"];

[
	[[-_mapAdjustment - _sizeX, 0], [_mapAdjustment, _sizeY], _backgroundColor],
	[[_mapAdjustment + _sizeX, 0], [_mapAdjustment, _sizeY], _backgroundColor],
	[[0, -_mapAdjustment - _sizeY], [_sizeX, _mapAdjustment], _backgroundColor],
	[[0, _mapAdjustment + _sizeY], [_sizeX, _mapAdjustment], _backgroundColor],
	[[-_mapAdjustment - _sizeX, -_mapAdjustment - _sizeY], [_mapAdjustment, _mapAdjustment], _backgroundColor],
	[[-_mapAdjustment - _sizeX, _mapAdjustment + _sizeY], [_mapAdjustment, _mapAdjustment], _backgroundColor],
	[[_mapAdjustment + _sizeX, -_mapAdjustment - _sizeY], [_mapAdjustment, _mapAdjustment], _backgroundColor],
	[[_mapAdjustment + _sizeX, _mapAdjustment + _sizeY], [_mapAdjustment, _mapAdjustment], _backgroundColor],
	[[_sizeX + _edgeWidth, 0], [_edgeWidth, _sizeY], _borderColor],
	[[-_sizeX - _edgeWidth, 0], [_edgeWidth, _sizeY], _borderColor],
	[[0, _sizeY + _edgeWidth], [_sizeX, _edgeWidth], _borderColor],
	[[0, -_sizeY - _edgeWidth], [_sizeX, _edgeWidth], _borderColor],
	[[_sizeX + _edgeWidth, _sizeY + _edgeWidth], [_edgeWidth, _edgeWidth], _borderColor],
	[[_sizeX + _edgeWidth, -_sizeY - _edgeWidth], [_edgeWidth, _edgeWidth], _borderColor],
	[[-_sizeX - _edgeWidth, _sizeY + _edgeWidth], [_edgeWidth, _edgeWidth], _borderColor],
	[[-_sizeX - _edgeWidth, -_sizeY - _edgeWidth], [_edgeWidth, _edgeWidth], _borderColor],
	[[0, 0], [_sizeX, _sizeY], _lineColor]
	//[[0, 0], [_sizeX + (_edgeWidth * 2), _sizeY + (_edgeWidth * 2)], _lineColor]
] apply {
	private _markerName = "";
	_x params ["_pos", "_size", "_colourArray"];
	_pos params ["_adjustX", "_adjustY"];
	_colourArray params ["_colour", "_brush"];
	for "_y" from 1 to 500 step 1 do {
		_markerName = "CM_m_" + str _y;
		if (markerShape _markerName isEqualTo "") exitWith {};
	};
	createMarkerLocal [_markerName, [_px + _adjustX, _py + _adjustY]];
	_markerName setMarkerShapeLocal "RECTANGLE";
	_markerName setMarkerSizeLocal _size;
	_markerName setMarkerColorLocal _colour;
	_markerName setMarkerBrushLocal _brush;
	GVAR(map_cover) pushBack _markerName;
};