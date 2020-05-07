/*
 * Author: Olsen
 *
 * If unit respawns as playable, register it spawning, if respawns as spectator, stop tracking.
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

if !(GETVAR(_unit,Dead,false)) then {
	_unit call FUNC(EventSpawned);
} else {
	_unit call FUNC(UntrackUnit);
};