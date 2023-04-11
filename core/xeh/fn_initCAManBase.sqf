#include "..\script_macros.hpp"

params ["_unit"];
//LOG("Spawned_Event called");

if !(local _unit) exitWith {};

if (isNil QEGVAR(PZAI,allSyncedEntities)) then {
    [QGVAR(spawnedEvent), [_unit]] call CBA_fnc_serverEvent;
} else {
    private _synced = _unit in EGVAR(PZAI,allSyncedEntities);
    TRACE_2("sync object check",_unit,_synced);
    if !(_synced) then {
        [QGVAR(spawnedEvent), [_unit]] call CBA_fnc_serverEvent;
    };
};
