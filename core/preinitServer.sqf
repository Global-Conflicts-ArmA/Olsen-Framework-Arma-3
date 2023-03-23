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
    private _waveCountVar = QGVAR(CurrentWaveCount_West);
    private _waveSizeVar = QGVAR(WaveSize_West);
    private _waveUnlockedVar = QGVAR(CurrentWaveUnlocked_West);
    private _respawnPenVar = QGVAR(RespawnPenGate_West);
    switch (side _unit) do {
        case east: {
            _waveCountVar = QGVAR(CurrentWaveCount_East);
            _waveSizeVar = QGVAR(WaveSize_East);
            _waveUnlockedVar = QGVAR(CurrentWaveUnlocked_East);
            _respawnPenVar = QGVAR(RespawnPenGate_East);
        };
        case independent: {
            _waveCountVar = QGVAR(CurrentWaveCount_Ind);
            _waveSizeVar = QGVAR(WaveSize_Ind);
            _waveUnlockedVar = QGVAR(CurrentWaveUnlocked_Ind);
            _respawnPenVar = QGVAR(RespawnPenGate_Ind);
        };
        case civilian: {
            _waveCountVar = QGVAR(CurrentWaveCount_Civ);
            _waveSizeVar = QGVAR(WaveSize_Civ);
            _waveUnlockedVar = QGVAR(CurrentWaveUnlocked_Civ);
            _respawnPenVar = QGVAR(RespawnPenGate_Civ);
        };
        default {};
    };
    private _waveSize = missionNamespace getVariable [_waveSizeVar, -1];
    private _waveCount = missionNamespace getVariable [_waveCountVar, 0];
    private _waveUnlocked = missionNamespace getVariable [_waveUnlockedVar, false];
    private _respawnPen = missionNamespace getVariable [_respawnPenVar, []];
    if (_waveSize > 0) then {
        _waveCount = _waveCount + 1;
        missionNamespace setVariable [_waveCountVar, _waveCount];
        if (_waveCount >= _waveSize) then {
            if !(_waveUnlocked) then {
                missionNamespace setVariable [_waveUnlockedVar, true];
                missionNamespace setVariable [_waveCountVar, 0];
                _respawnPen apply {
                    _x hideObjectGlobal true;
                };
                [{
                    params [
                        ["_respawnPen", [], [[]]]
                    ];
                    _respawnPen apply {
                        _x hideObjectGlobal false;
                    };
                    missionNamespace setVariable [_waveUnlockedVar, false];
                }, [_respawnPen], 30] call CBA_fnc_waitAndExecute;
            };
        };
    };
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
    private _teamTicketVar = switch _side do {
        case east: {
            QGVAR(RespawnTickets_East)
        };
        case independent: {
            QGVAR(RespawnTickets_Ind)
        };
        case civilian: {
            QGVAR(RespawnTickets_Civ)
        };
        default {
            QGVAR(RespawnTickets_West)
        };
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

if (isClass (missionConfigFile >> QGVAR(serverSettings) >> "Teams" >> "west")) then {
    GVAR(EndScreenDisplay_West) = ([missionConfigFile >> QGVAR(serverSettings) >> "Teams" >> "west" >> "endScreenDisplay", "number", 1] call CBA_fnc_getConfigEntry) isEqualTo 1;
    private _westTeam = [
        west,
        [missionConfigFile >> QGVAR(serverSettings) >> "Teams" >> "west" >> "name", "string", "USMC"] call CBA_fnc_getConfigEntry,
        [missionConfigFile >> QGVAR(serverSettings) >> "Teams" >> "west" >> "type", "string", "player"] call CBA_fnc_getConfigEntry
    ];
    _westTeam call FUNC(AddTeam);
};
if (isClass (missionConfigFile >> QGVAR(serverSettings) >> "Teams" >> "east")) then {
    GVAR(EndScreenDisplay_East) = ([missionConfigFile >> QGVAR(serverSettings) >> "Teams" >> "east" >> "endScreenDisplay", "number", 1] call CBA_fnc_getConfigEntry) isEqualTo 1;
    private _eastTeam = [
        east,
        [missionConfigFile >> QGVAR(serverSettings) >> "Teams" >> "east" >> "name", "string", "VDV"] call CBA_fnc_getConfigEntry,
        [missionConfigFile >> QGVAR(serverSettings) >> "Teams" >> "east" >> "type", "string", "ai"] call CBA_fnc_getConfigEntry
    ];
    _eastTeam call FUNC(AddTeam);
};
if (isClass (missionConfigFile >> QGVAR(serverSettings) >> "Teams" >> "independent")) then {
    GVAR(EndScreenDisplay_Ind) = ([missionConfigFile >> QGVAR(serverSettings) >> "Teams" >> "independent" >> "endScreenDisplay", "number", 1] call CBA_fnc_getConfigEntry) isEqualTo 1;
    private _indTeam = [
        independent,
        [missionConfigFile >> QGVAR(serverSettings) >> "Teams" >> "independent" >> "name", "string", "Local Militia"] call CBA_fnc_getConfigEntry,
        [missionConfigFile >> QGVAR(serverSettings) >> "Teams" >> "independent" >> "type", "string", "ai"] call CBA_fnc_getConfigEntry
    ];
    _indTeam call FUNC(AddTeam);
};
if (isClass (missionConfigFile >> QGVAR(serverSettings) >> "Teams" >> "civilian")) then {
    GVAR(EndScreenDisplay_Civ) = ([missionConfigFile >> QGVAR(serverSettings) >> "Teams" >> "civilian" >> "endScreenDisplay", "number", 1] call CBA_fnc_getConfigEntry) isEqualTo 1;
    private _civTeam = [
        civilian,
        [missionConfigFile >> QGVAR(serverSettings) >> "Teams" >> "civilian" >> "name", "string", "Local Civilians"] call CBA_fnc_getConfigEntry,
        [missionConfigFile >> QGVAR(serverSettings) >> "Teams" >> "civilian" >> "type", "string", "ai"] call CBA_fnc_getConfigEntry
    ];
    _civTeam call FUNC(AddTeam);
};

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

GVAR(CurrentWaveUnlocked_West) = false;
GVAR(CurrentWaveUnlocked_East) = false;
GVAR(CurrentWaveUnlocked_Ind) = false;
GVAR(CurrentWaveUnlocked_Civ) = false;

GVAR(CurrentWaveCount_West) = if (GVAR(WaveSize_West) > 0) then {0} else {-1000};
GVAR(CurrentWaveCount_East) = if (GVAR(WaveSize_East) > 0) then {0} else {-1000};
GVAR(CurrentWaveCount_Ind) = if (GVAR(WaveSize_Ind) > 0) then {0} else {-1000};
GVAR(CurrentWaveCount_Civ) = if (GVAR(WaveSize_Civ) > 0) then {0} else {-1000};

GVAR(west_ExpendedAmmo) = [];
GVAR(east_ExpendedAmmo) = [];
GVAR(ind_ExpendedAmmo) = [];
GVAR(civ_ExpendedAmmo) = [];
GVAR(shotClassNames) = [];

#include "..\customization\inits\PreInitServer.sqf" //DO NOT REMOVE
#include "..\modules\modules.sqf" //DO NOT REMOVE
