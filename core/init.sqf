#include "script_macros.hpp"

enableSaving [false, false];

if (isServer) then {

	{
		_x call FUNC(CreateRespawnMarker);
	} foreach ["west","east","guer","civ"];

	GVAR(EventPlayerSpawnedHandle) = [QGVAR(PlayerSpawned), {_this call FUNC(EventPlayerSpawned);}] call CBA_fnc_addEventHandler;

	GVAR(EventDisconnectHandle) = addMissionEventHandler ["HandleDisconnect", {_this call FUNC(EventDisconnect);}];
	
	//"" call FUNC(StartingCount); //DO NOT REMOVE
	
	setViewDistance GVAR(ServerViewDistance);
	
	[{
		GVAR(endConditionsPFH) = [{
		    params ["_args", "_idPFH"];
			
			if (GETMVAR(Disable_Endconditions,false)) exitWith {
				[_idPFH] call CBA_fnc_removePerFrameHandler;
			};
			
			#include "..\customization\endConditions.sqf" //DO NOT REMOVE
			
			//The time limit in minutes variable called GVAR(TimeLimit) is set in customization/settings.sqf, to disable the time limit set it to 0
			if ((GVAR(TimeLimit) > 0) && {((CBA_MissionTime / 60) >= GVAR(TimeLimit))}) exitWith { //It is recommended that you do not remove the time limit end condition
				GVAR(TimeLimitMessage) call FUNC(EndMission);
				[_idPFH] call CBA_fnc_removePerFrameHandler;
			};
			
			if (missionNamespace getVariable [QGVAR(MissionEnded), false]) exitWith {
				[_idPFH] call CBA_fnc_removePerFrameHandler;
			};
			
		}, GVAR(EndConditionFrequency), []] call CBA_fnc_addPerFrameHandler;
	}, [], 3] call CBA_fnc_waitAndExecute;
};

if (hasInterface) then {

	//Anything done using "player" must be past this line for JIP compatibility
	waitUntil {!(isNull player)};

	if (!isServer) then {

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

	//QGVAR(EndMission) player event sends the received variables to the end screen
	GVAR(EndMissionEh) = [QGVAR(EndMission), {_this call FW_fnc_EndScreen}] call CBA_fnc_addEventHandler;

	//Various settings
	enableEngineArtillery false; //Disable Arma 3 artillery computer
	enableRadio false; //Disable Arma 3 regular radio
	enableSentences false; //Disable Arma 3 regular radio chatter
	0 fadeRadio 0; //Lower radio volume to 0

	//Creates the briefing notes for the player
	"" call FUNC(Briefing);
	"" call FUNC(Menu);

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
		if (hasInterface) then {
			[{
				if (currentWeapon player != "") then {
					[player, currentWeapon player, currentMuzzle player] call ace_safemode_fnc_lockSafety;
				};
			}, []] call CBA_fnc_execNextFrame;
		};
	};
};
