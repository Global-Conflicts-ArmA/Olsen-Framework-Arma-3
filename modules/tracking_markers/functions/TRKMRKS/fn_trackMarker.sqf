#include "script_component.hpp"

params[
  ["_markerName", "trackingMarker", [""]],
  ["_objectToTrack", objNull, [objNull]]
];

GVAR(trackedMarkers) pushBackUnique [_markerName, _objectToTrack];
