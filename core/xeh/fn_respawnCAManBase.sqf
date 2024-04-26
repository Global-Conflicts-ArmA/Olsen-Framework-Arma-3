#include "..\script_macros.hpp"

params ["_unit", "_body"];
if !(local _unit) exitWith {};
if (
    _unit isKindOf "B_UAV_AI" ||
    _unit isKindOf "O_UAV_AI" ||
    _unit isKindOf "I_UAV_AI"
) exitWith {};

LOG("Respawned_Event called");
//Makes the player go into spectator mode when dead or respawn if he has respawn tickets
if (isPlayer _unit) then {
    LOG_1("respawn XEH handle for isPlayer started: %1",_unit);
    SETVAR(_unit,Body,_body);
    [_unit, _body] call FUNC(SpectatePrep);
} else {
    [QGVAR(RespawnedEvent), _unit] call CBA_fnc_serverEvent;
};
