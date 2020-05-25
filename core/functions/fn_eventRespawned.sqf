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

params ["_new", "_corpse"];
SETVAR(_new,Body,_corpse);

LOG("Server Event Respawned called");
if (GETVAR(_new,Spectating,false)) then {
    _new call FUNC(UntrackUnit);
} else {
    SETPVAR(_new,Dead,false);
    SETPVAR(_new,Spectating,false);
    _new call FUNC(EventSpawned);
};