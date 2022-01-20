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

if (GVAR(RespawnTickets) == -1) exitWith {
    [QGVAR(eventPlayerRespawned), [-1]] call CBA_fnc_localEvent;
    [QGVAR(respawnEvent), [_unit]] call CBA_fnc_serverEvent;
};
if (GVAR(RespawnTickets) > 0) then {
    GVAR(RespawnTickets) = GVAR(RespawnTickets) - 1;
    [QGVAR(eventPlayerRespawned), [0]] call CBA_fnc_localEvent;
    [QGVAR(respawnEvent), [_unit]] call CBA_fnc_serverEvent;
} else {
    private _indTicketVar = switch (side _unit) do {
        case west: {
            GVAR(IndividualRespawnTickets_West)
        };
        case east: {
            GVAR(IndividualRespawnTickets_East)
        };
        case independent: {
            GVAR(IndividualRespawnTickets_Ind)
        };
        case civilian: {
            GVAR(IndividualRespawnTickets_Civ)
        };
        default {
            -1
        };
    };
    if (_indTicketVar isEqualTo -1 || _indTicketVar > 0) then {
        _indTicketVar = _indTicketVar - 1;
        LOG_1("eventCheckRespawnTickets called: %1",_unit);
        [QGVAR(eventCheckRespawnTickets), _unit] call CBA_fnc_serverEvent;
    } else {
        [] call FUNC(StartSpectator); // spectator var is set in this function
        [QGVAR(respawnEvent), [player, true]] call CBA_fnc_serverEvent;
    };
};
