// Tracking Markers - Markers which track objects and units, updating on the map.
// Author: StatusRed

// Functions
/*
 * FNC_trackMarker
 *
 * Make a marker track an object / player / unit.
 *
 * Arguments:
 * 0: markerName <markerName>
 * 1: object <object>
 *
 * Return Value:
 * nothing
 *
 */

 /*
  * FNC_untrackMarker
  *
  * Make a marker tracking stop.
  *
  * Arguments:
  * 0: markerName <markerName>
  *
  * Return Value:
  * Index of the marker removed, -1 if it wasn't found.
  *
  */

FW_markerUpdateInterval = 30; // Number of seconds between marker updates on the map

// Markers to track
/* ["trackingMarker", test_unit] call FNC_trackMarker; */
