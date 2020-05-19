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

params ["_new", "_corpse"];
SETVAR(_new,Body,_corpse);

LOG("Server Event Respawned called");
if (GETVAR(_corpse,Tracked,false)) then {
    if (GETVAR(_new,Spectating,false)) then {
        _new call FUNC(UntrackUnit);
    } else {
        _new call FUNC(EventSpawned);
    };
};