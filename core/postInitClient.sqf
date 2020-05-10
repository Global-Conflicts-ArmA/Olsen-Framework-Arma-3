#include "script_macros.hpp"
#define postInitClient

[{!isNull ace_player},{

    [] call FUNC(debug);
    [] call FUNC(postChecks);

    setViewDistance GVAR(ClientViewDistance);

	if (isMultiplayer && {!(isServer)}) then {
        //Tells the server the player has spawned
        [QGVAR(PlayerSpawned), player] call CBA_fnc_serverEvent;

		["endMission", {
			private _msg = "Mission ended by the admin";
			if (count (_this select 0) > 0) then {
				_msg = _msg + ": " + (_this select 0);
			};
			_msg remoteExecCall [QFUNC(EndMission), 2];
		}, "admin"] call CBA_fnc_registerChatCommand;
	};

	//Various settings
	enableEngineArtillery false; //Disable Arma 3 artillery computer
	enableRadio false; //Disable Arma 3 regular radio
	enableSentences false; //Disable Arma 3 regular radio chatter
	0 fadeRadio 0; //Lower radio volume to 0

	//Creates the briefing notes for the player
	[] call FUNC(Briefing);
	[] call FUNC(Menu);

	GVAR(RespawnTickets) = 0; //Initialize respawn tickets to 0

	player setVariable [QGVAR(Dead), false, true]; //Tells the framework the player is alive
	player setVariable [QGVAR(Spectating), false, true]; //Player is not spectating
	player setVariable [QGVAR(Body), player, true]; //Remembers his old body for spectating his dead body

	//Makes the player go into spectator mode when dead or respawn if he has respawn tickets
	GVAR(KilledEh) = player addEventHandler ["Killed", {"" spawn FUNC(SpectateCheck);}];
	GVAR(RespawnEh) = player addEventHandler ["Respawn", {_this call FUNC(SpectatePrep);}];

	//Various settings
	player addRating 100000; //Makes sure ai doesnt turn hostile when teamkilling
	player setVariable ["BIS_noCoreConversations", true]; //Disable scroll wheel conversations

	if (GVAR(StartOnSafe)) then {
		[{(!isNull ace_player)}, {
			if (currentWeapon player != "") then {
				[player, currentWeapon player, currentMuzzle player] call ace_safemode_fnc_lockSafety;
                if (GETMVAR(StartOnSafe_Lowered,true)) then {
                    player action ["WeaponOnBack", player];
                };
                if (GETMVAR(StartOnSafe_Unloaded,true)) then {
                    private _magazineClass = currentMagazine player;
                    player setAmmo [currentWeapon player, 0];
                    player addMagazines [_magazineClass, 1];
                    [player, _magazineClass, -1, true] call CBA_fnc_addMagazine;
                };
			};
		}, []] call CBA_fnc_waitUntilAndExecute;
	};
}, []] call CBA_fnc_waitUntilAndExecute;

#include "..\customization\inits\PostInitClient.sqf" //DO NOT REMOVE
#include "..\modules\modules.sqf" //DO NOT REMOVE
