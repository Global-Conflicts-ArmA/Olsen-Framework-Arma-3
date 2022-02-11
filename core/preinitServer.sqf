#define preInitServer

#include "script_macros.hpp"

GVAR(Teams) = []; //DO NOT REMOVE
GVAR(TeamSides) = []; //DO NOT REMOVE
GVAR(MissionEnded) = false; //Mission has not ended

[QGVAR(spawnedEvent), {
    params ["_unit"];
    //LOG_1("spawnedEvent started: %1",_unit);
	_unit call FUNC(eventSpawned);
}] call CBA_fnc_addEventHandler;

[QGVAR(untrackEvent), {
    params ["_unit"];
    //LOG_1("untrackEvent started: %1",_unit);
	_unit call FUNC(untrackUnit);
}] call CBA_fnc_addEventHandler;

[QGVAR(killedEvent), {
    params [["_unit", objNull, [objNull]], ["_killer", objNull, [objNull]]];
    //LOG_1("killedevent started: %1",_unit);
	[_unit, _killer] call FUNC(EventKilled);
}] call CBA_fnc_addEventHandler;

[QGVAR(respawnEvent), {
    params [["_unit", objNull, [objNull]], ["_spectator", false, [false]]];
    LOG_2("respawnEvent started: %1 spectator: %2",_unit,_spectator);
	[_unit, _spectator] call FUNC(EventRespawned);
}] call CBA_fnc_addEventHandler;

[QGVAR(eventCheckRespawnTickets), {
    params [
        ["_unit", objNull, [objNull]],
        ["_side", west, [sideEmpty]],
        ["_localTickets", 0, [0]]
    ];
    TRACE_2("eventCheckRespawnTickets started",_unit,_side);
    // First get appropriate variable names for unit side
    private _teamTicketVar = "RespawnTickets_West";
    private _waveCountVar = "CurrentWaveCount_West";
    private _waveSizeVar = "WaveSize_West";
    private _waveUnlockedVar = "CurrentWaveUnlocked_West";
    private _respawnPenVar = "RespawnPenGate_West";
    switch _side do {
        case east: {
            _teamTicketVar = "RespawnTickets_East";
            _waveCountVar = "CurrentWaveCount_East";
            _waveSizeVar = "WaveSize_East";
            _waveUnlockedVar = "CurrentWaveUnlocked_East";
            _respawnPenVar = "RespawnPenGate_East";
        };
        case independent: {
            _teamTicketVar = "RespawnTickets_Ind";
            _waveCountVar = "CurrentWaveCount_Ind";
            _waveSizeVar = "WaveSize_Ind";
            _waveUnlockedVar = "CurrentWaveUnlocked_Ind";
            _respawnPenVar = "RespawnPenGate_Ind";
        };
        case civilian: {
            _teamTicketVar = "RespawnTickets_Civ";
            _waveCountVar = "CurrentWaveCount_Civ";
            _waveSizeVar = "WaveSize_Civ";
            _waveUnlockedVar = "CurrentWaveUnlocked_Civ";
            _respawnPenVar = "RespawnPenGate_Civ";
        };
        default {};
    };
    private _teamTickets = missionNamespace getVariable [_teamTicketVar, -1];
    //TRACE_2("",_side,_teamTickets);
    // If team tickets are unlimited, exit with response event with client mode
    if (_teamTickets isEqualTo -1) exitWith {
        if (_localTickets isEqualTo -1) then {
            [QGVAR(eventCheckRespawnTickets_Response), ["C_UNLIMITED"], _unit] call CBA_fnc_targetEvent;
        } else {
            [QGVAR(eventCheckRespawnTickets_Response), ["C_LIMITED"], _unit] call CBA_fnc_targetEvent;
        };
    };
    // If team tickets are zero / used up:
    if (_teamTickets isEqualTo 0) exitWith {
        [QGVAR(eventCheckRespawnTickets_Response), ["TEAM_ZERO"], _unit] call CBA_fnc_targetEvent;
    };
    switch _localTickets do {
        // local tickets are unlimited, only substract from team tickets
        case -1: {
            private _newValue = (_teamTickets - 1) max 0;
            missionNamespace setVariable [_teamTicketVar, _newValue];
            [QGVAR(eventCheckRespawnTickets_Response), ["TEAM_LIMITED", _newValue], _unit] call CBA_fnc_targetEvent;
        };
        // local tickets are limited, subtract from both
        default {
            private _newValue = (_teamTickets - 1) max 0;
            missionNamespace setVariable [_teamTicketVar, _newValue];
            [QGVAR(eventCheckRespawnTickets_Response), ["BOTH LIMITED", _newValue], _unit] call CBA_fnc_targetEvent;
        };
    };
    //private _canRespawn = false;
    //switch (_side) do {
    //    case west: {
    //        if (GVAR(RespawnTickets_West) > 0) then {
    //            GVAR(RespawnTickets_West) = GVAR(RespawnTickets_West) - 1;
    //            GVAR(CurrentWaveCountWest) = GVAR(CurrentWaveCountWest) + 1;
    //            if (GVAR(CurrentWaveCountWest) >= GVAR(WaveSizeWest) && {!(GVAR(RespawnPenGateWest) isEqualTo objnull)}) then {
    //                GVAR(CurrentWaveUnlockedWest) = true;
    //                GVAR(RespawnPenGateWest) hideObjectGlobal true;
    //                [{
    //                    GVAR(RespawnPenGateWest) hideObjectGlobal false;
    //                    GVAR(CurrentWaveCountWest) = 0;
    //                    GVAR(CurrentWaveUnlockedWest) = false;
    //                }, [], 30] call CBA_fnc_waitAndExecute;
    //            };
    //            _canRespawn = true;
    //        };
    //    };
    //    case east: {
    //        if (GVAR(RespawnTickets_East) > 0) then {
    //            GVAR(RespawnTickets_East) = GVAR(RespawnTickets_East) - 1;
    //            GVAR(CurrentWaveCountEast) = GVAR(CurrentWaveCountEast) + 1;
    //            if (GVAR(CurrentWaveCountEast) >= GVAR(WaveSizeEast) && {!(GVAR(RespawnPenGateEast) isEqualTo objnull)}) then {
    //                GVAR(CurrentWaveUnlockedEast) = true;
    //                GVAR(RespawnPenGateEast) hideObjectGlobal true;
    //                [{
    //                    GVAR(RespawnPenGateEast) hideObjectGlobal false;
    //                    GVAR(CurrentWaveCountEast) = 0;
    //                    GVAR(CurrentWaveUnlockedEast) = false;
    //                }, [], 30] call CBA_fnc_waitAndExecute;
    //            };
    //            _canRespawn = true;
    //        };
    //    };
    //    case independent: {
    //        if (GVAR(RespawnTickets_Ind) > 0) then {
    //            GVAR(RespawnTickets_Ind) = GVAR(RespawnTickets_Ind) - 1;
    //            GVAR(CurrentWaveCountInd) = GVAR(CurrentWaveCountInd) + 1;
    //            if (GVAR(CurrentWaveCountInd) >= GVAR(WaveSizeInd) && {!(GVAR(RespawnPenGateInd) isEqualTo objnull)}) then {
    //                GVAR(CurrentWaveUnlockedInd) = true;
    //                GVAR(RespawnPenGateInd) hideObjectGlobal true;
    //                [{
    //                    GVAR(RespawnPenGateInd) hideObjectGlobal false;
    //                    GVAR(CurrentWaveCountInd) = 0;
    //                    GVAR(CurrentWaveUnlockedInd) = false;
    //                }, [], 30] call CBA_fnc_waitAndExecute;
    //            };
    //            _canRespawn = true;
    //        };
    //    };
    //    case civilian: {
    //        if (GVAR(RespawnTickets_Civ) > 0) then {
    //            GVAR(RespawnTickets_Civ) = GVAR(RespawnTickets_Civ) - 1;
    //            GVAR(CurrentWaveCountCiv) = GVAR(CurrentWaveCountCiv) + 1;
    //            if (GVAR(CurrentWaveCountCiv) >= GVAR(WaveSizeCiv) && {!(GVAR(RespawnPenGateCiv) isEqualTo objnull)}) then {
    //                GVAR(CurrentWaveUnlockedCiv) = true;
    //                GVAR(RespawnPenGateCiv) hideObjectGlobal true;
    //                [{
    //                    GVAR(RespawnPenGateCiv) hideObjectGlobal false;
    //                    GVAR(CurrentWaveCountCiv) = 0;
    //                    GVAR(CurrentWaveUnlockedCiv) = false;
    //                }, [], 30] call CBA_fnc_waitAndExecute;
    //            };
    //            _canRespawn = true;
    //        };
    //    };
    //};
    //LOG_1("eventCheckRespawnTickets_Response called: %1",_unit);
    //[QGVAR(eventCheckRespawnTickets_Response), _canRespawn, _unit] call CBA_fnc_targetEvent;
}] call CBA_fnc_addEventHandler;

[QGVAR(ShotCountEvent), {
    params ["_side", "_magazine", ["_projectile", "", [""]]];
    private _magName = if (_magazine isEqualTo "GRENADE") then {
        [_projectile, true] call FUNC(getDisplayName);
    } else {
        [_magazine] call FUNC(getDisplayName);
    };
    [_side, _magName] call FUNC(shotCount);
}] call CBA_fnc_addEventHandler;

GVAR(CurrentWaveUnlockedWest) = false;
GVAR(CurrentWaveUnlockedEast) = false;
GVAR(CurrentWaveUnlockedInd) = false;
GVAR(CurrentWaveUnlockedCiv) = false;

GVAR(CurrentWaveCountWest) = if (GVAR(WaveSizeWest) > 0) then {0} else {-1000};
GVAR(CurrentWaveCountEast) = if (GVAR(WaveSizeEast) > 0) then {0} else {-1000};
GVAR(CurrentWaveCountInd) = if (GVAR(WaveSizeInd) > 0) then {0} else {-1000};
GVAR(CurrentWaveCountCiv) = if (GVAR(WaveSizeCiv) > 0) then {0} else {-1000};

GVAR(west_ExpendedAmmo) = [];
GVAR(east_ExpendedAmmo) = [];
GVAR(ind_ExpendedAmmo) = [];
GVAR(civ_ExpendedAmmo) = [];
GVAR(shotClassNames) = [];

#include "..\customization\serverSettings.sqf" //DO NOT REMOVE
#include "..\customization\inits\PreInitServer.sqf" //DO NOT REMOVE
#include "..\modules\modules.sqf" //DO NOT REMOVE
