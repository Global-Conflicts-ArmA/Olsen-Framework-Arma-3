if (hasInterface) then {
	["Tracking Markers", "Markers which track objects and units, updating on the map.", "StatusRed"] call FNC_RegisterModule;
};

if (isServer) then {
	#include "settings.sqf"

	[{
	  FW_trackedMarkers apply {
	    _x params [
	      ["_markerName", "trackingMarker", ["trackingMarker"]],
	      ["_objectToTrack", objNull, [objNull, player]]
	    ];

	    private _objPos = getPos _objectToTrack;

	    [_markerName, _objPos] remoteExec ["setMarkerPosLocal", 0, true];
	    _markerName setMarkerAlpha 1;
	  };
	}, FW_markerUpdateInterval, []] call CBA_fnc_addPerFrameHandler;
};
