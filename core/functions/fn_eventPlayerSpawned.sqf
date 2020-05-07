/*
 * Author: Olsen
 *
 * Duplicate. Calls FUNC(TrackUnit).
 *
 * Arguments:
 * 0: unit to track <object>
 *
 * Return Value:
 * nothing
 *
 * Public: No
 */

#include "..\script_macros.hpp"

params ["_unit"];

_unit call FUNC(TrackUnit);