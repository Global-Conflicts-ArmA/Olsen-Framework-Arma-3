#include "script_component.hpp"

#include "settings.sqf"

[{
  GVAR(trackedMarkers) apply {
    _x params [
      ["_markerName", "trackingMarker", [""]],
      ["_objectToTrack", objNull, [objNull]]
    ];

    _markerName setMarkerPos _objectToTrack;
  };
}, GVAR(markerUpdateInterval), []] call CBA_fnc_addPerFrameHandler;
