#include "script_component.hpp"

params[
  ["_markerName", "trackingMarker", ["trackingMarker"]]
];

private _deleteIndex = -1;

{
    _x params ["_xMarkerName"];

    if (_xMarkerName == _markerName) then {
      _deleteIndex = _forEachIndex;
      GVAR(trackedMarkers) deleteAt _deleteIndex;
    }
} forEach GVAR(trackedMarkers);

_deleteIndex
