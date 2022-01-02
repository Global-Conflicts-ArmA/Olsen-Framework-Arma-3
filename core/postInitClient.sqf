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
    SETPLVAR(BriefingSide,side player);

	player setVariable [QGVAR(Dead), false, true]; //Tells the framework the player is alive
	player setVariable [QGVAR(Spectating), false, true]; //Player is not spectating
	player setVariable [QGVAR(Body), player, true]; //Remembers his old body for spectating his dead body

	//Various settings
	player addRating 100000; //Makes sure ai doesnt turn hostile when teamkilling
	player setVariable ["BIS_noCoreConversations", true]; //Disable scroll wheel conversations

    GVAR(killcam_killedHandle) = player addEventHandler ["Killed", {
        params ["_unit"];

        GVAR(killcam_killer) = _unit getVariable ["ace_medical_lastDamageSource", objNull];
        if (GVAR(killcam_killer) isEqualTo objNull || GVAR(killcam_killer) isEqualTo player) then {
            GVAR(killcam_killer) = _unit getVariable ["ace_medical_lastInstigator", objNull];
        };
        GVAR(killcam_unit_pos) = ASLtoAGL eyePos _unit;

        if (GVAR(killcam_killer) isEqualTo objnull) then {
            GVAR(killcam_killer_pos) = [0,0,0];
        } else {
            GVAR(killcam_killer_pos) = getPosASL GVAR(killcam_killer);
        };

        if (GETMVAR(eg_instant_death,true)) then {
            cutText ["\n", "BLACK", 0.1, true];
            [QGVAR(death), 0, true] call ace_common_fnc_setHearingCapability;
            0 fadeSound 0;
            [{
                ["<t color='#FF0000'>YOU ARE DEAD</t>", 0, 0.4, 2, 0.5, 0, 1000] spawn BIS_fnc_dynamicText;
            }, [], 1] call CBA_fnc_waitAndExecute;
        } else {
            [{
                cutText ["\n", "BLACK", 0.5, true];
                [QGVAR(death), 0, true] call ace_common_fnc_setHearingCapability;
                [{
                    0 fadeSound 0;
                    [{
                        ["<t color='#FF0000'>YOU ARE DEAD</t>", 0, 0.4, 2, 0.5, 0, 1000] spawn BIS_fnc_dynamicText;
                    }, [], 1] call CBA_fnc_waitAndExecute;
                }, [], 0.5] call CBA_fnc_waitAndExecute;
            }, []] call CBA_fnc_execNextFrame;
        };
    }];
}, []] call CBA_fnc_waitUntilAndExecute;

#include "..\customization\inits\PostInitClient.sqf" //DO NOT REMOVE
#include "..\modules\modules.sqf" //DO NOT REMOVE
