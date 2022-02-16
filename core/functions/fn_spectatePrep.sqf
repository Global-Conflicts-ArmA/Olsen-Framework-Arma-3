/*
 * Author: Olsen
 *
 * Checks and handles if the player should respawn or begin spectating.
 *
 * Arguments:
 * none
 *
 * Return Value:
 * nothing
 *
 * Public: No
 */

#include "script_component.hpp"

params ["_unit", "_body"];
SETMVAR(killcam_body,_body);

LOG_1("spectatePrep started: %1",_unit);

// no spawns allowed or tickets are used up
if (GVAR(RespawnTickets) isEqualTo 0) exitWith {
    [] call FUNC(StartSpectator); // spectator var is set in this function
    [QGVAR(respawnEvent), [_unit, true]] call CBA_fnc_serverEvent;
};
// individual tickets active, send event with unit, side, and local tickers to see if player can respawn
TRACE_3("eventCheckRespawnTickets called",_unit, side _unit, GVAR(RespawnTickets));
[QGVAR(eventCheckRespawnTickets), [_unit, side _unit, GVAR(RespawnTickets)]] call CBA_fnc_serverEvent;
