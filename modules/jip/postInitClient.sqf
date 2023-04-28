#include "script_component.hpp"

if (!hasInterface || !didJIP) exitWith {};

private _west_locationString = ([missionConfigFile >> QGVAR(settings) >> "west" >> "spawnLocation", "string", ""] call CBA_fnc_getConfigEntry);
GVAR(west_spawnLocation) = missionNamespace getVariable [_west_locationString, objNull];
GVAR(west_transporters) = ([missionConfigFile >> QGVAR(settings) >> "west" >> "transporters", "array", []] call CBA_fnc_getConfigEntry) select {
    missionNamespace getVariable [_x, objNull] isNotEqualTo objNull
} apply {
    missionNamespace getVariable [_x, objNull]
};

private _east_locationString = ([missionConfigFile >> QGVAR(settings) >> "east" >> "spawnLocation", "string", ""] call CBA_fnc_getConfigEntry);
GVAR(east_spawnLocation) = missionNamespace getVariable [_east_locationString, objNull];
GVAR(east_transporters) = ([missionConfigFile >> QGVAR(settings) >> "east" >> "transporters", "array", []] call CBA_fnc_getConfigEntry) select {
    missionNamespace getVariable [_x, objNull] isNotEqualTo objNull
} apply {
    missionNamespace getVariable [_x, objNull]
};

private _independent_locationString = ([missionConfigFile >> QGVAR(settings) >> "independent" >> "spawnLocation", "string", ""] call CBA_fnc_getConfigEntry);
GVAR(independent_spawnLocation) = missionNamespace getVariable [_independent_locationString, objNull];
GVAR(independent_transporters) = ([missionConfigFile >> QGVAR(settings) >> "independent" >> "transporters", "array", []] call CBA_fnc_getConfigEntry) select {
    missionNamespace getVariable [_x, objNull] isNotEqualTo objNull
} apply {
    missionNamespace getVariable [_x, objNull]
};

private _civilian_locationString = ([missionConfigFile >> QGVAR(settings) >> "civilian" >> "spawnLocation", "string", ""] call CBA_fnc_getConfigEntry);
GVAR(civilian_spawnLocation) = missionNamespace getVariable [_civilian_locationString, objNull];
GVAR(civilian_transporters) = ([missionConfigFile >> QGVAR(settings) >> "civilian" >> "transporters", "array", []] call CBA_fnc_getConfigEntry) select {
    missionNamespace getVariable [_x, objNull] isNotEqualTo objNull
} apply {
    missionNamespace getVariable [_x, objNull]
};

private _typeVar = QGVAR(west_type);
private _deniedVar = QGVAR(west_JIPDenied);
private _distanceVar = QGVAR(west_distance);
private _spawnDistanceVar = QGVAR(west_spawnDistance);
private _spawnLocationVar = QGVAR(west_spawnLocation);
private _dismountVehiclesVar = QGVAR(west_dismountVehicles);
private _transportersVar = QGVAR(west_transporters);

switch side player do {
    case east: {
        _typeVar = QGVAR(east_type);
        _deniedVar = QGVAR(east_JIPDenied);
        _distanceVar = QGVAR(east_distance);
        _spawnDistanceVar = QGVAR(east_spawnDistance);
        _spawnLocationVar = QGVAR(east_spawnLocation);
        _dismountVehiclesVar = QGVAR(east_dismountVehicles);
        _transportersVar = QGVAR(east_transporters);
    };
    case independent: {
        _typeVar = QGVAR(independent_type);
        _deniedVar = QGVAR(independent_JIPDenied);
        _distanceVar = QGVAR(independent_distance);
        _spawnDistanceVar = QGVAR(independent_spawnDistance);
        _spawnLocationVar = QGVAR(independent_spawnLocation);
        _dismountVehiclesVar = QGVAR(independent_dismountVehicles);
        _transportersVar = QGVAR(independent_transporters);
    };
    default {
        _typeVar = QGVAR(civilian_type);
        _deniedVar = QGVAR(civilian_JIPDenied);
        _distanceVar = QGVAR(civilian_distance);
        _spawnDistanceVar = QGVAR(civilian_spawnDistance);
        _spawnLocationVar = QGVAR(civilian_spawnLocation);
        _dismountVehiclesVar = QGVAR(civilian_dismountVehicles);
        _transportersVar = QGVAR(civilian_transporters);
    };
};

if (
    missionNamespace getVariable [_typeVar, "TELEPORT"] isEqualTo "DENY" &&
    {missionNamespace getVariable [_deniedVar, false]}
) exitWith {
    [{
		player call EFUNC(FW,UntrackUnit);
		player setDamage 1;
		[{
		    cutText ["This mission does not support JIP.", "PLAIN DOWN"];
		}, [], 3] call CBA_fnc_waitAndExecute;
	}, [], 2] call CBA_fnc_waitAndExecute;
};

GVAR(teamTransporters) = missionNamespace getVariable [_transportersVar, []];

if (missionNamespace getVariable [_dismountVehiclesVar, true] && {INVEHICLE(player)}) then {
    moveOut player;
};

GVAR(JIPSpawnPos) = getPosATL player;

private _spawnLoc = missionNamespace getVariable [_spawnLocationVar, objNull];
if (_spawnLoc isNotEqualTo objNull) then {
    player setPosATL _spawnLoc;
    GVAR(JIPSpawnPos) = getPosATL _spawnLoc;
};

if (missionNamespace getVariable [_typeVar, "TELEPORT"] isEqualTo "NONE") exitWith {
    ["JIP set to regular spawn, no transport or teleport option available."] call EFUNC(FW,parsedTextDisplay);
};

private _target = leader player;

if (player isEqualTo _target || !(_target call EFUNC(FW,isAlive))) then {
	private _rank = -1;
	((units group player) - [player]) apply {
		if ((rankId _x > _rank) && {(_target call EFUNC(FW,isAlive))}) then {
			_rank = rankId _x;
			_target = _x;
		};
	};
};

private _distance = missionNamespace getVariable [_distanceVar, 50];
if (player isNotEqualTo _target && {player distance _target < _distance}) exitWith {};

private _spawnDistance = missionNamespace getVariable [_spawnDistanceVar, 200];

switch (missionNamespace getVariable [_typeVar, "TELEPORT"]) do {
    case "TELEPORT": {
        private _teleportAction = [QGVAR(TeleportAction), "Teleport To Squad", "", {
            params ["_target", "_player", "_args"];
            _args params ["_spawnDistance"];
            [_target,_args] call FUNC(Teleport);
        }, {((player distance ((_this select 2 ) select 1)) < ((_this select 2 ) select 0))}, {}, [_spawnDistance, _spawnLoc]] call ace_interact_menu_fnc_createAction;
        [player, 1, ["ACE_SelfActions"], _teleportAction] call ace_interact_menu_fnc_addActionToObject;
        [{
            params ["_args","_idPFH"];
            _args params ["_spawnDistance", "_spawnLoc"];
            if (player distance _spawnLoc > _spawnDistance) exitwith {
                [player, 1, ["ACE_SelfActions", QGVAR(TeleportAction)]] call ace_interact_menu_fnc_removeActionFromObject;
                [_idPFH] call CBA_fnc_removePerFrameHandler;
                [["JIP teleport option lost, you went beyond %1 meters from your spawn location",_spawnDistance]] call EFUNC(FW,parsedTextDisplay);
            };
        }, 10, [_spawnDistance, _spawnLoc]] call CBA_fnc_addPerFrameHandler;
    };
    case "TRANSPORT": {
        private _transportAction = [QGVAR(TransportAction), "Request Transport", "", {
            params ["_target", "_player", "_args"];
            _args params ["_spawnDistance"];
            [_target,_args] call FUNC(Transport);
        }, {((player distance ((_this select 2 ) select 1)) < ((_this select 2 ) select 0))}, {}, [_spawnDistance, _spawnLoc]] call ace_interact_menu_fnc_createAction;
        [player, 1, ["ACE_SelfActions"], _transportAction] call ace_interact_menu_fnc_addActionToObject;
        [{
            params ["_args","_idPFH"];
            _args params ["_spawnDistance", "_spawnLoc"];
            if (player distance _spawnLoc > _spawnDistance) exitwith {
                [player,1,["ACE_SelfActions", QGVAR(TransportAction)]] call ace_interact_menu_fnc_removeActionFromObject;
                [_idPFH] call CBA_fnc_removePerFrameHandler;
                [["JIP teleport option lost, you went beyond %1 meters from your spawn location",_spawnDistance]] call FUNC(parsedTextDisplay);
            };
        }, 10, [_spawnDistance, _spawnLoc]] call CBA_fnc_addPerFrameHandler;
    };
};
