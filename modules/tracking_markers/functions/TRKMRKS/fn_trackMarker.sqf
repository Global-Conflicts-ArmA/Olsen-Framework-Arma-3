#include "script_component.hpp"

params[
  ["_markerName", "trackingMarker", ["trackingMarker"]],
  ["_objectToTrack", objNull, [objNull, player]]
];

GVAR(trackedMarkers) pushBack [_markerName, _objectToTrack];
