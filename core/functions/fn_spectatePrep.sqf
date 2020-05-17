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

#include "..\script_macros.hpp"

params ["_unit", "_body"];
killcam_body = _body;

LOG_1("spectatePrep started: %1",_unit);

if (GVAR(RespawnTickets) > 0) then {
    GVAR(RespawnTickets) = GVAR(RespawnTickets) - 1;
    [QGVAR(eventPlayerRespawned), [0]] call CBA_fnc_localEvent;
    [QGVAR(eventRespawn), [player]] call CBA_fnc_serverEvent;
} else {
    LOG_1("eventCheckRespawnTickets called: %1",_unit);
    [QGVAR(eventCheckRespawnTickets), player] call CBA_fnc_serverEvent;
};