#include "script_component.hpp"

params [
    ["_bypassTeamTickets", false, [false]]
];

[player] call FUNC(thawUnit);
["Terminate", [player]] call BIS_fnc_EGSpectator;
[false] call acre_api_fnc_setSpectator;
SETPLPVAR(Dead,false); //Tells the framework the player is alive
SETPLPVAR(Spectating,false); //Player is no longer spectating
SETPLPVAR(HasDied,false); //Player has not died
SETMVAR(Spectating,false); //set local global var to spectating false
[player, false] remoteExecCall ["hideObject", 0];
[player, false] remoteExecCall ["hideObjectGlobal", 2];
[] call FUNC(ACRES_ClientInit);
[player] joinSilent (createGroup playerSide);
[QGVAR(eventCheckRespawnTickets), [
    player,
    playerSide,
    _bypassTeamTickets,
    GVAR(RespawnTickets)
]] call CBA_fnc_serverEvent;
