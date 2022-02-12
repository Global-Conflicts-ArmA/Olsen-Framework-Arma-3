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

#include "script_component.hpp"
params ["_unit", ["_spectator", false, [false]]];

LOG("Server Event Respawned called");
if (_spectator || GETVAR(_unit,Spectating,false)) then {
    //_unit call FUNC(UntrackUnit);
} else {
    SETPVAR(_unit,Dead,false);
    SETPVAR(_unit,Spectating,false);
    _unit call FUNC(EventSpawned);
};
