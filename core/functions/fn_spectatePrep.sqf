/*
 * Author: Olsen
 *
 * Checks and handles if the player should respawn or begin spectating.
 *
 * Arguments:
 * none
 *
 * Return Value:
 * nothing
 *
 * Public: No
 */

#include "..\script_macros.hpp"

if (FW_RespawnTickets > 0) then {

	private _respawnName = toLower(format ["fw_%1_respawn", side player]);
	private _respawnPoint = missionNamespace getVariable [_respawnName, objNull];

	private _loadout = (player getVariable [QGVAR(Loadout), ""]);

	if (_loadout != "") then {

		[player, _loadout] call FUNC(GearScript);

	};

	if (!isNull(_respawnPoint)) then {

		player setPos getPosATL _respawnPoint;

	};

	FW_RespawnTickets = FW_RespawnTickets - 1;

	private _text = "respawns left";

	if (FW_RespawnTickets == 1) then {

		_text = "respawn left";

	};

	call BIS_fnc_VRFadeIn;

	cutText [format ['%1 %2', FW_RespawnTickets, _text], 'PLAIN DOWN'];

	player setVariable [QGVAR(Body), player, true];

} else {

	player setVariable [QGVAR(Dead), true, true]; //Tells the framework the player is dead

	player setCaptive true;
	player allowdamage false;

	player call FUNC(RemoveAllGear);

	player addWeapon "itemMap";

	player setPos [0, 0, 0];
	[player] join grpNull;

	hideObjectGlobal player;

	if (!(GETVAR(player,Spectating,false))) then {

		player setVariable [QGVAR(Spectating), true, true];

		[true] call acre_api_fnc_setSpectator;
		"" execVM "core\spectate.sqf";


	} else {

		call BIS_fnc_VRFadeIn;

	};
};