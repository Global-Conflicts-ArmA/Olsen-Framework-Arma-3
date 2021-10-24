FW_trackedMarkers = [[]]; // Leave this

FNC_trackMarker = {
	params[
	  ["_markerName", "trackingMarker", ["trackingMarker"]],
	  ["_objectToTrack", objNull, [objNull, player]]
	];

	FW_trackedMarkers pushBack [_markerName, _objectToTrack];
};

FNC_untrackMarker = {
	params[
	  ["_markerName", "trackingMarker", ["trackingMarker"]]
	];

	private _deleteIndex = -1;

	{
	    _x params ["_xMarkerName"];

	    if (_xMarkerName == _markerName) then {
	      _deleteIndex = _forEachIndex;
	      FW_trackedMarkers deleteAt _deleteIndex;
	    }
	} forEach FW_trackedMarkers;

	_deleteIndex
};
