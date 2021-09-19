#include "script_component.hpp"

// This module is for showing or hiding markers based on what side they belong to.

// [SIDE, MARKER_NAME, DELETE_AFTER_START] call FUNC(MRKCON_Add)
// SIDE is the side of the marker, NAME is the name of the marker.
// If you dont want anyone to see the marker use sideLogic.
// DELETE_AFTER_START set to true will delete marker after briefing

// Example:
// [blufor, "markerBlu", true] call FUNC(MRKCON_Add);
// [blufor, "markerBlu2", false] call FUNC(MRKCON_Add);
// [opfor, "markerRed", true] call FUNC(MRKCON_Add);
