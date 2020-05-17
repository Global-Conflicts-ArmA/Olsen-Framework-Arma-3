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

	player setVariable [QGVAR(Dead), false, true]; //Tells the framework the player is alive
	player setVariable [QGVAR(Spectating), false, true]; //Player is not spectating
	player setVariable [QGVAR(Body), player, true]; //Remembers his old body for spectating his dead body

	//Various settings
	player addRating 100000; //Makes sure ai doesnt turn hostile when teamkilling
	player setVariable ["BIS_noCoreConversations", true]; //Disable scroll wheel conversations
    
    killcam_hitHandle = player addEventHandler ["Hit", {
        params ["_unit", "_causedBy", "_damage"];
        if (vehicle _causedBy != vehicle player && {_causedBy != objNull}) then {
            //we store this information in case it's needed if killed EH doesn't fire
            killcam_LastHit = [_this, CBA_missionTime, ASLtoAGL eyePos _unit, ASLtoAGL eyePos _causedBy];
        };
        if (_damage > 1) then {_damage = 1};
        killcam_LastHitDamage = _damage;
    }];
    
    killcam_killedHandle = player addEventHandler ["Killed", {
        params ["_unit", "_killer"];
        //let's remove hit EH, it's not needed
        player removeEventHandler ["hit", killcam_hitHandle];
        
        //we check if player didn't kill himself or died for unknown reasons
        if (vehicle _killer != vehicle _unit && {_killer != objNull}) then {
            //this is the standard case (killed EH got triggered by getting shot)
            killcam_unit_pos = ASLtoAGL eyePos _unit;
            killcam_killer = _killer;
            killcam_killer_pos = ASLtoAGL eyePos _killer;
        } else {
            //we will try to retrieve info from our hit EH
            private _last_hit_info = [];
            if (!isNil "killcam_LastHit") then {
                _last_hit_info = killcam_LastHit;
            };
            
            //hit info retrieved, now we check if it's not caused by fall damage etc.
            //also we won't use info that's over 10 seconds old
            if (count _last_hit_info != 0) then {
                _last_hit_info params ["_data", "_time", "_unitPos", "_killerPos"];
                if (_time + 10 > CBA_missionTime &&
                {(_data select 1) != objNull} &&
                {(_data select 1) != player}
                ) then {
                    killcam_unit_pos = _unitPos;
                    killcam_killer = _data select 1;
                    killcam_killer_pos = _killerPos;
                }
                else {
                    //everything failed, we set value we will detect later
                    killcam_killer_pos = [0,0,0];
                    killcam_unit_pos = ASLtoAGL eyePos _unit;
                    killcam_killer = objNull;
                };
            }
            else {
                killcam_killer_pos = [0,0,0];
                killcam_unit_pos = ASLtoAGL eyePos _unit;
                killcam_killer = objNull;
            };
        };
    
        if (eg_instant_death) then {
            private _damage = 0.5;
            if (!isNil "killcam_LastHitDamage") then {
                _damage = killcam_LastHitDamage;
            };
            cutText ["\n", "BLACK", 0.1, true];
            [QGVAR(death), 0, true] call ace_common_fnc_setHearingCapability;
            0 fadeSound 0;
            [{
                ["<t color='#FF0000'>YOU ARE DEAD</t>", 0, 0.4, 2, 0.5, 0, 1000] spawn BIS_fnc_dynamicText;
            }, [], 1] call CBA_fnc_waitAndExecute;
        } else {
            private _damage = 0.5;
            if (!isNil "killcam_LastHitDamage") then {
                _damage = killcam_LastHitDamage;
            };
            [{
                params ["_damage"];
                cutText ["\n", "BLACK", (1.01 - _damage), true];
                [QGVAR(death), 0, true] call ace_common_fnc_setHearingCapability;
                [{
                    params ["_damage"];
                    0 fadeSound 0;
                    [{
                        ["<t color='#FF0000'>YOU ARE DEAD</t>", 0, 0.4, 2, 0.5, 0, 1000] spawn BIS_fnc_dynamicText;
                    }, [], (1.01 - _damage)] call CBA_fnc_waitAndExecute;
                }, [_damage], (1.01 - _damage)] call CBA_fnc_waitAndExecute;
            }, [_damage]] call CBA_fnc_execNextFrame;
        };
    }];
	
	if (GVAR(StartOnSafe)) then {
		[{(!isNull ace_player)}, {
			if !(currentWeapon player isEqualTo "") then {
				[player, currentWeapon player, currentMuzzle player] call ace_safemode_fnc_lockSafety;
                if (GETMVAR(StartOnSafe_Lowered,true)) then {
                    player action ["WeaponOnBack", player];
                };
                if (GETMVAR(StartOnSafe_Unloaded,true)) then {
                    private _magazineClass = currentMagazine player;
                    [player, _magazineClass, -1, true] call CBA_fnc_addMagazine;
                    player removePrimaryWeaponItem _magazineClass;
                };
			};
		}, []] call CBA_fnc_waitUntilAndExecute;
	};
}, []] call CBA_fnc_waitUntilAndExecute;

#include "..\customization\inits\PostInitClient.sqf" //DO NOT REMOVE
#include "..\modules\modules.sqf" //DO NOT REMOVE