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
            QGVAR(IndividualRespawnTickets_West)
        };
        case east: {
            QGVAR(IndividualRespawnTickets_East)
        };
        case independent: {
            QGVAR(IndividualRespawnTickets_Ind)
        };
        case civilian: {
            QGVAR(IndividualRespawnTickets_Civ)
        };
    };
    if ((missionNamespace getVariable [_indTicketVar, -1]) isEqualTo -1 || (missionNamespace getVariable [_indTicketVar, -1]) > 0) then {
        if ((missionNamespace getVariable [_indTicketVar, -1]) > 0) then {
            missionNamespace setVariable [_indTicketVar, (missionNamespace getVariable [_indTicketVar, -1]) - 1];
        };
        LOG_1("eventCheckRespawnTickets called: %1",_unit);
        [QGVAR(eventCheckRespawnTickets), _unit] call CBA_fnc_serverEvent;
    } else {
        [] call FUNC(StartSpectator); // spectator var is set in this function
        [QGVAR(respawnEvent), [player, true]] call CBA_fnc_serverEvent;
    };
};
