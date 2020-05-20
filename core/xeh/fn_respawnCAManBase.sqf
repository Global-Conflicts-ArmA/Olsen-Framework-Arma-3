#include "..\script_macros.hpp"

params ["_unit", "_body"];
if !(local _unit) exitWith {};

LOG("Respawned_Event called");
//Makes the player go into spectator mode when dead or respawn if he has respawn tickets
if (isPlayer _unit) then {
    LOG_1("respawn XEH handle for isPlayer started: %1",_unit);
    [_unit, _body] call FUNC(SpectatePrep);
} else {
    [QGVAR(RespawnedEvent), _unit] call CBA_fnc_serverEvent;
};

