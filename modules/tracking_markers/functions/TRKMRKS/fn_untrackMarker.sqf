#include "script_component.hpp"

params[
  ["_markerName", "trackingMarker", [""]]
];

private _deleteIndex = GVAR(trackedMarkers) findif {_x select 0 == _markerName};
GVAR(trackedMarkers) deleteAt _deleteIndex;
_deleteIndex
