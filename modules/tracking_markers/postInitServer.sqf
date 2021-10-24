#include "script_component.hpp"

#include "settings.sqf"

[{
  GVAR(trackedMarkers) apply {
    _x params [
      ["_markerName", "trackingMarker", ["trackingMarker"]],
      ["_objectToTrack", objNull, [objNull, player]]
    ];

    private _objPos = getPos _objectToTrack;

    [_markerName, _objPos] remoteExec ["setMarkerPosLocal", 0, true];
    _markerName setMarkerAlpha 1;
  };
}, GVAR(markerUpdateInterval), []] call CBA_fnc_addPerFrameHandler;
