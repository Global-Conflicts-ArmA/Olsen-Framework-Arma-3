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
    params [["_unit", objNull, [objNull]]];
    private _side = side _unit;
    LOG_1("eventCheckRespawnTickets started: %1",_unit);
    private _canRespawn = false;
    switch (_side) do {
        case west: {
            if (GVAR(RespawnTickets_West) > 0) then {
                GVAR(RespawnTickets_West) = GVAR(RespawnTickets_West) - 1;
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
            if (GVAR(RespawnTickets_East) > 0) then {
                GVAR(RespawnTickets_East) = GVAR(RespawnTickets_East) - 1;
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
            if (GVAR(RespawnTickets_Ind) > 0) then {
                GVAR(RespawnTickets_Ind) = GVAR(RespawnTickets_Ind) - 1;
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
            if (GVAR(RespawnTickets_Civ) > 0) then {
                GVAR(RespawnTickets_Civ) = GVAR(RespawnTickets_Civ) - 1;
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
}] call CBA_fnc_addEventHandler;

[QGVAR(ShotCountEvent), {
    params ["_side", "_magazine", ["_projectile", "", [""]]];
    private _magName = if (_magazine isEqualTo "GRENADE") then {
        [_projectile, true] call FUNC(getDisplayName);
    } else {
        [_magazine] call FUNC(getDisplayName);
    };
    TRACE_3("count event",_magName,(_magazine),_projectile);
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
