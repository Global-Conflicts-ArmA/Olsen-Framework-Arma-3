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
    private _teamTicketVar = QGVAR(RespawnTickets_West);
    //private _waveCountVar = QGVAR(CurrentWaveCount_West);
    //private _waveSizeVar = QGVAR(WaveSize_West);
    //private _waveUnlockedVar = QGVAR(CurrentWaveUnlocked_West);
    //private _respawnPenVar = QGVAR(RespawnPenGate_West);
    switch _side do {
        case east: {
            _teamTicketVar = QGVAR(RespawnTickets_East);
            //_waveCountVar = QGVAR(CurrentWaveCount_East);
            //_waveSizeVar = QGVAR(WaveSize_East);
            //_waveUnlockedVar = QGVAR(CurrentWaveUnlocked_East);
            //_respawnPenVar = QGVAR(RespawnPenGate_East);
        };
        case independent: {
            _teamTicketVar = QGVAR(RespawnTickets_Ind);
            //_waveCountVar = QGVAR(CurrentWaveCount_Ind);
            //_waveSizeVar = QGVAR(WaveSize_Ind);
            //_waveUnlockedVar = QGVAR(CurrentWaveUnlocked_Ind);
            //_respawnPenVar = QGVAR(RespawnPenGate_Ind);
        };
        case civilian: {
            _teamTicketVar = QGVAR(RespawnTickets_Civ);
            //_waveCountVar = QGVAR(CurrentWaveCount_Civ);
            //_waveSizeVar = QGVAR(WaveSize_Civ);
            //_waveUnlockedVar = QGVAR(CurrentWaveUnlocked_Civ);
            //_respawnPenVar = QGVAR(RespawnPenGate_Civ);
        };
        default {};
    };
    TRACE_2("",_side,_teamTicketVar);
    private _teamTickets = missionNamespace getVariable [_teamTicketVar, 0];
    TRACE_2("",_side,_teamTickets);
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
    private _type = if (_localTickets isEqualTo -1) then {
        // local tickets are unlimited, only substract from team tickets
        "TEAM_LIMITED"
    } else {
        // local tickets are limited, subtract from both
        "BOTH LIMITED"
    };
    private _newValue = (_teamTickets - 1) max 0;
    missionNamespace setVariable [_teamTicketVar, _newValue];
    [QGVAR(eventCheckRespawnTickets_Response), [_type, _newValue], _unit] call CBA_fnc_targetEvent;
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
