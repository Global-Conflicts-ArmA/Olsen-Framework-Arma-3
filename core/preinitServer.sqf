#define preInitServer

#include "script_macros.hpp"

GVAR(Teams) = []; //DO NOT REMOVE
GVAR(TeamSides) = []; //DO NOT REMOVE
GVAR(MissionEnded) = false; //Mission has not ended

[QGVAR(spawnedEvent), {
    params ["_unit"];
	_unit call FUNC(eventSpawned);
}] call CBA_fnc_addEventHandler;

[QGVAR(untrackEvent), {
    params ["_unit"];
    LOG_1("untrackEvent started: %1",_unit);
	_unit call FUNC(untrackUnit);
}] call CBA_fnc_addEventHandler;

[QGVAR(killedEvent), {
    params [["_unit", objNull, [objNull]], ["_killer", objNull, [objNull]]];
    LOG_1("killedevent started: %1",_unit);
	[_unit, _killer] call FUNC(EventKilled);
}] call CBA_fnc_addEventHandler;

[QGVAR(respawnEvent), {
    params [["_unit", objNull, [objNull]]];
    LOG_1("respawnEvent started: %1",_unit);
	[_unit] call FUNC(EventRespawned);
}] call CBA_fnc_addEventHandler;

[QGVAR(eventCheckRespawnTickets), {
    params [["_unit", objNull, [objNull]]];
    private _side = side _unit;
    LOG_1("eventCheckRespawnTickets started: %1",_unit);
    private _canRespawn = false;
    switch (_side) do {
        case west: {
            if (GVAR(RespawnTicketsWest) > 0) then {
                GVAR(RespawnTicketsWest) = GVAR(RespawnTicketsWest) - 1;
                GVAR(CurrentWaveCountWest) = GVAR(CurrentWaveCountWest) + 1;
                if (GVAR(CurrentWaveCountWest) >= GVAR(WaveSizeWest) && {!(GVAR(RespawnPenGateWest) isEqualTo objnull)}) then {
                    GVAR(CurrentWaveUnlockedWest) = true;
                    GVAR(RespawnPenGateWest) hideObjectGlobal true;
                    [{
                        GVAR(RespawnPenGateWest) hideObjectGlobal false;
                        GVAR(CurrentWaveCountWest) = 0;
                        GVAR(CurrentWaveUnlockedWest) = false;
                    }, [], 30] call CBA_fnc_waitAndExecute;
                };
                _canRespawn = true;
            };
        };
        case east: {
            if (GVAR(RespawnTicketsEast) > 0) then {
                GVAR(RespawnTicketsEast) = GVAR(RespawnTicketsEast) - 1;
                GVAR(CurrentWaveCountEast) = GVAR(CurrentWaveCountEast) + 1;
                if (GVAR(CurrentWaveCountEast) >= GVAR(WaveSizeEast) && {!(GVAR(RespawnPenGateEast) isEqualTo objnull)}) then {
                    GVAR(CurrentWaveUnlockedEast) = true;
                    GVAR(RespawnPenGateEast) hideObjectGlobal true;
                    [{
                        GVAR(RespawnPenGateEast) hideObjectGlobal false;
                        GVAR(CurrentWaveCountEast) = 0;
                        GVAR(CurrentWaveUnlockedEast) = false;
                    }, [], 30] call CBA_fnc_waitAndExecute;
                };
                _canRespawn = true;
            };
        };
        case independent: {
            if (GVAR(RespawnTicketsInd) > 0) then {
                GVAR(RespawnTicketsInd) = GVAR(RespawnTicketsInd) - 1;
                GVAR(CurrentWaveCountInd) = GVAR(CurrentWaveCountInd) + 1;
                if (GVAR(CurrentWaveCountInd) >= GVAR(WaveSizeInd) && {!(GVAR(RespawnPenGateInd) isEqualTo objnull)}) then {
                    GVAR(CurrentWaveUnlockedInd) = true;
                    GVAR(RespawnPenGateInd) hideObjectGlobal true;
                    [{
                        GVAR(RespawnPenGateInd) hideObjectGlobal false;
                        GVAR(CurrentWaveCountInd) = 0;
                        GVAR(CurrentWaveUnlockedInd) = false;
                    }, [], 30] call CBA_fnc_waitAndExecute;
                };
                _canRespawn = true;
            };
        };
        case civilian: {
            if (GVAR(RespawnTicketsCiv) > 0) then {
                GVAR(RespawnTicketsCiv) = GVAR(RespawnTicketsCiv) - 1;
                GVAR(CurrentWaveCountCiv) = GVAR(CurrentWaveCountCiv) + 1;
                if (GVAR(CurrentWaveCountCiv) >= GVAR(WaveSizeCiv) && {!(GVAR(RespawnPenGateCiv) isEqualTo objnull)}) then {
                    GVAR(CurrentWaveUnlockedCiv) = true;
                    GVAR(RespawnPenGateCiv) hideObjectGlobal true;
                    [{
                        GVAR(RespawnPenGateCiv) hideObjectGlobal false;
                        GVAR(CurrentWaveCountCiv) = 0;
                        GVAR(CurrentWaveUnlockedCiv) = false;
                    }, [], 30] call CBA_fnc_waitAndExecute;
                };
                _canRespawn = true;
            };
        };
    };
    LOG_1("eventCheckRespawnTickets_Response called: %1",_unit);
    [QGVAR(eventCheckRespawnTickets_Response), _canRespawn, _unit] call CBA_fnc_targetEvent;

  // Wait is necessary so that the client has a chance to update the Spectating variable
  [{
    [_unit] call FUNC(EventRespawned);
  }, [_unit], 2] call CBA_fnc_waitAndExecute;
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

GVAR(serverViewDistance) = [missionConfigFile >> QGVAR(serverSettings) >> "viewDistance", "number", 2500] call CBA_fnc_getConfigEntry;

GVAR(timeLimit) = [missionConfigFile >> QGVAR(serverSettings) >> "timeLimit", "number", 30] call CBA_fnc_getConfigEntry;
GVAR(timeLimitMessage) = [missionConfigFile >> QGVAR(serverSettings) >> "timeLimitMessage", "string", "TIME LIMIT REACHED!"] call CBA_fnc_getConfigEntry;
GVAR(endConditionFrequency) = [missionConfigFile >> QGVAR(serverSettings) >> "endConditionFrequency", "number", 30] call CBA_fnc_getConfigEntry;

GVAR(disconnectBodyCleanupTime) = [missionConfigFile >> QGVAR(serverSettings) >> "disconnectBodyCleanupTime", "number", 2] call CBA_fnc_getConfigEntry;
GVAR(disconnectBodyCleanupSides) = [];
if (([missionConfigFile >> QGVAR(serverSettings) >> "Teams" >> "west" >> "disconnectBodyCleanUp", "number", 1] call CBA_fnc_getConfigEntry) == 1) then {GVAR(disconnectBodyCleanupSides) pushBackUnique west};
if (([missionConfigFile >> QGVAR(serverSettings) >> "Teams" >> "east" >> "disconnectBodyCleanUp", "number", 1] call CBA_fnc_getConfigEntry) == 1) then {GVAR(disconnectBodyCleanupSides) pushBackUnique east};
if (([missionConfigFile >> QGVAR(serverSettings) >> "Teams" >> "independent" >> "disconnectBodyCleanUp", "number", 1] call CBA_fnc_getConfigEntry) == 1) then {GVAR(disconnectBodyCleanupSides) pushBackUnique independent};
if (([missionConfigFile >> QGVAR(serverSettings) >> "Teams" >> "civilian" >> "disconnectBodyCleanUp", "number", 1] call CBA_fnc_getConfigEntry) == 1) then {GVAR(disconnectBodyCleanupSides) pushBackUnique civilian};

GVAR(respawnTickets_West) = [missionConfigFile >> QGVAR(serverSettings) >> "Teams" >> "west" >> "respawnTickets", "number", -1] call CBA_fnc_getConfigEntry;
GVAR(waveSize_West) =  [missionConfigFile >> QGVAR(serverSettings) >> "Teams" >> "west" >> "waveSize", "number", -1] call CBA_fnc_getConfigEntry;
GVAR(respawnPenGate_West) = ([missionConfigFile >> QGVAR(serverSettings) >> "Teams" >> "west" >> "respawnPenGate", "array", ["objNull"]] call CBA_fnc_getConfigEntry) apply {missionNamespace getVariable [_x, objNull]};

GVAR(respawnTickets_East) = [missionConfigFile >> QGVAR(serverSettings) >> "Teams" >> "east" >> "respawnTickets", "number", -1] call CBA_fnc_getConfigEntry;
GVAR(waveSize_East) =  [missionConfigFile >> QGVAR(serverSettings) >> "Teams" >> "east" >> "waveSize", "number", -1] call CBA_fnc_getConfigEntry;
GVAR(respawnPenGate_East) = ([missionConfigFile >> QGVAR(serverSettings) >> "Teams" >> "east" >> "respawnPenGate", "array", ["objNull"]] call CBA_fnc_getConfigEntry) apply {missionNamespace getVariable [_x, objNull]};

GVAR(respawnTickets_Ind) = [missionConfigFile >> QGVAR(serverSettings) >> "Teams" >> "independent" >> "respawnTickets", "number", -1] call CBA_fnc_getConfigEntry;
GVAR(waveSize_Ind) =  [missionConfigFile >> QGVAR(serverSettings) >> "Teams" >> "independent" >> "waveSize", "number", -1] call CBA_fnc_getConfigEntry;
GVAR(respawnPenGate_Ind) = ([missionConfigFile >> QGVAR(serverSettings) >> "Teams" >> "independent" >> "respawnPenGate", "array", ["objNull"]] call CBA_fnc_getConfigEntry) apply {missionNamespace getVariable [_x, objNull]};

GVAR(respawnTickets_Civ) = [missionConfigFile >> QGVAR(serverSettings) >> "Teams" >> "civilian" >> "respawnTickets", "number", -1] call CBA_fnc_getConfigEntry;
GVAR(waveSize_Civ) =  [missionConfigFile >> QGVAR(serverSettings) >> "Teams" >> "civilian" >> "waveSize", "number", -1] call CBA_fnc_getConfigEntry;
GVAR(respawnPenGate_Civ) = ([missionConfigFile >> QGVAR(serverSettings) >> "Teams" >> "civilian" >> "respawnPenGate", "array", ["objNull"]] call CBA_fnc_getConfigEntry) apply {missionNamespace getVariable [_x, objNull]};

GVAR(CoC_CheckFrequency) = [missionConfigFile >> QGVAR(serverSettings) >> "CoC_CheckFrequency", "number", 30] call CBA_fnc_getConfigEntry;
GVAR(CoC_Changed_Message) = ([missionConfigFile >> QGVAR(serverSettings) >> "CoC_Changed_Message", "number", 1] call CBA_fnc_getConfigEntry) isEqualTo 1;

GVAR(CoC_ManualOverride_Blufor) = ([missionConfigFile >> QGVAR(serverSettings) >> "Teams" >> "west" >> "CoC_override", "array", []] call CBA_fnc_getConfigEntry) select {
    private _obj = missionNamespace getVariable [_x, objNull];
    (_obj isNotEqualTo objNull)
} apply {
    private _obj = missionNamespace getVariable [_x, objNull];
    _obj
};
GVAR(CoC_ManualOverride_Opfor) = ([missionConfigFile >> QGVAR(serverSettings) >> "Teams" >> "east" >> "CoC_override", "array", []] call CBA_fnc_getConfigEntry) select {
    private _obj = missionNamespace getVariable [_x, objNull];
    (_obj isNotEqualTo objNull)
} apply {
    private _obj = missionNamespace getVariable [_x, objNull];
    _obj
};
GVAR(CoC_ManualOverride_Indfor) = ([missionConfigFile >> QGVAR(serverSettings) >> "Teams" >> "independent" >> "CoC_override", "array", []] call CBA_fnc_getConfigEntry) select {
    private _obj = missionNamespace getVariable [_x, objNull];
    (_obj isNotEqualTo objNull)
} apply {
    private _obj = missionNamespace getVariable [_x, objNull];
    _obj
};
GVAR(CoC_ManualOverride_Civfor) = ([missionConfigFile >> QGVAR(serverSettings) >> "Teams" >> "civilian" >> "CoC_override", "array", []] call CBA_fnc_getConfigEntry) select {
    private _obj = missionNamespace getVariable [_x, objNull];
    (_obj isNotEqualTo objNull)
} apply {
    private _obj = missionNamespace getVariable [_x, objNull];
    _obj
};

private _westTeam = [
    west,
    [missionConfigFile >> QGVAR(serverSettings) >> "Teams" >> "west" >> "name", "string", "USMC"] call CBA_fnc_getConfigEntry,
    [missionConfigFile >> QGVAR(serverSettings) >> "Teams" >> "west" >> "type", "string", "player"] call CBA_fnc_getConfigEntry
];
_westTeam call FUNC(AddTeam);
private _eastTeam = [
    east,
    [missionConfigFile >> QGVAR(serverSettings) >> "Teams" >> "east" >> "name", "string", "VDV"] call CBA_fnc_getConfigEntry,
    [missionConfigFile >> QGVAR(serverSettings) >> "Teams" >> "east" >> "type", "string", "ai"] call CBA_fnc_getConfigEntry
];
_eastTeam call FUNC(AddTeam);
private _indTeam = [
    independent,
    [missionConfigFile >> QGVAR(serverSettings) >> "Teams" >> "independent" >> "name", "string", "Local Militia"] call CBA_fnc_getConfigEntry,
    [missionConfigFile >> QGVAR(serverSettings) >> "Teams" >> "independent" >> "type", "string", "ai"] call CBA_fnc_getConfigEntry
];
_indTeam call FUNC(AddTeam);
private _civTeam = [
    civilian,
    [missionConfigFile >> QGVAR(serverSettings) >> "Teams" >> "civilian" >> "name", "string", "Local Civilians"] call CBA_fnc_getConfigEntry,
    [missionConfigFile >> QGVAR(serverSettings) >> "Teams" >> "civilian" >> "type", "string", "ai"] call CBA_fnc_getConfigEntry
];
_civTeam call FUNC(AddTeam);

[QGVAR(requestCOEvent), {
    params [["_side", west, [west]], ["_requestingUnit", objNull, [objNull]]];
	private _co = _side call FUNC(getCO);
    private _var = switch (_side) do {
        case west: {
            QGVAR(CO_Blufor)
        };
        case east: {
            QGVAR(CO_Opfor)
        };
        case independent: {
            QGVAR(CO_Indfor)
        };
        case civilian: {
            QGVAR(CO_Civfor)
        };
    };
    missionNamespace setVariable [_var, _co, true];
    TRACE_2("",_co,_requestingUnit);
    [QGVAR(responseCOEvent), [_co, _var], _requestingUnit] call CBA_fnc_targetEvent;
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
