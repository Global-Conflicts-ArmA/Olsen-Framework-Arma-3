enableSaving [false, false];

if (isServer) then {

	{
		_x call FNC_CreateRespawnMarker;
	} foreach ["west","east","guer","civ"];

	FW_EventPlayerSpawnedHandle = ["FW_PlayerSpawned", {_this call FNC_EventPlayerSpawned;}] call CBA_fnc_addEventHandler;
	FW_EventRespawnedHandle = addMissionEventHandler ["EntityRespawned", {_this call FNC_EventRespawned;}];
	FW_EventKilledHandle = addMissionEventHandler ["EntityKilled", {_this call FNC_EventKilled;}];

	FW_EventDisconnectHandle = addMissionEventHandler ["HandleDisconnect", {_this call FNC_EventDisconnect;}];
	
	"" call FNC_StartingCount; //DO NOT REMOVE
	
	setViewDistance FW_ServerViewDistance;
	
	[{
		FW_endConditionsPFH = [{
		    params ["_args", "_idPFH"];
			
			if (missionNamespace getVariable ["FW_Disable_Endconditions", false]) exitWith {
				[_idPFH] call CBA_fnc_removePerFrameHandler;
			};
			
			#include "..\customization\endConditions.sqf" //DO NOT REMOVE
			
			//The time limit in minutes variable called FW_TimeLimit is set in customization/settings.sqf, to disable the time limit set it to 0
			if ((FW_TimeLimit > 0) && {((CBA_MissionTime / 60) >= FW_TimeLimit)}) exitWith { //It is recommended that you do not remove the time limit end condition
				FW_TimeLimitMessage call FNC_EndMission;
				[_idPFH] call CBA_fnc_removePerFrameHandler;
			};
			
			if (missionNamespace getVariable ["FW_MissionEnded", false]) exitWith {
				[_idPFH] call CBA_fnc_removePerFrameHandler;
			};
			
		}, FW_EndConditionFrequency, []] call CBA_fnc_addPerFrameHandler;
	}, [], 3] call CBA_fnc_waitAndExecute;
};

if (!isDedicated) then {

	//Anything done using "player" must be past this line for JIP compatibility
	waitUntil {!(isNull player)};

	if (!isServer) then {

		//Tells the server the player has spawned
		["FW_PlayerSpawned", player] call CBA_fnc_serverEvent;

		["endMission", {
			private _msg = "Mission ended by the admin";
			if (count (_this select 0) > 0) then {
				_msg = _msg + ": " + (_this select 0);
			};
			_msg remoteExecCall ["FNC_EndMission", 2];
		}, "admin"] call CBA_fnc_registerChatCommand;
	};

	//"FW_EndMission" player event sends the received variables to the end screen
	FW_EndMissionEh = ["FW_EndMission", {_this execVM "core\dia\endscreen\dia_endscreen.sqf";}] call CBA_fnc_addEventHandler;

	//Various settings
	enableEngineArtillery false; //Disable Arma 3 artillery computer
	enableRadio false; //Disable Arma 3 regular radio
	enableSentences false; //Disable Arma 3 regular radio chatter
	0 fadeRadio 0; //Lower radio volume to 0

	//Creates the briefing notes for the player
	"" call FNC_Briefing;
	"" call FNC_Menu;

	FW_RespawnTickets = 0; //Initialize respawn tickets to 0

	player setVariable ["FW_Dead", false, true]; //Tells the framework the player is alive
	player setVariable ["FW_Spectating", false, true]; //Player is not spectating
	player setVariable ["FW_Body", player, true]; //Remembers his old body for spectating his dead body

	//Makes the player go into spectator mode when dead or respawn if he has respawn tickets
	FW_KilledEh = player addEventHandler ["Killed", {"" spawn FNC_SpectateCheck;}];
	FW_RespawnEh = player addEventHandler ["Respawn", {_this call FNC_SpectatePrep;}];

	//Various settings
	player addRating 100000; //Makes sure ai doesnt turn hostile when teamkilling
	player setVariable ["BIS_noCoreConversations", true]; //Disable scroll wheel conversations

};
