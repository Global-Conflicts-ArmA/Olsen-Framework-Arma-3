#include "script_component.hpp"

// This module is for showing or hiding markers based on what side they belong to.

// [SIDE, MARKER_NAME, DELETE_AFTER_START] call FUNC(Add)
// SIDE is the side of the marker, can be a single side or an array of sides.
// NAME is the name of the marker.
// If you dont want anyone to see the marker use sideLogic.
// DELETE_AFTER_START set to true will delete marker after briefing

// [SIDE, LAYER_NAME, DELETE_AFTER_START] call FUNC(AddLayer)
// Adds all markers that are on the named layer

// Example:
// [blufor, "markerBlu", true] call FUNC(Add);
// [[blufor, civilian], "markerBlu2", false] call FUNC(Add);
// [opfor, "markerRed", true] call FUNC(Add);
// [blufor, "bluforMarkers", true] call FUNC(Addlayer);
