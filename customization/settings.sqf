#include "..\core\script_macros.hpp"

//ace_cookoff_enable = false; //this disables cookoff fire effect
//ace_cookoff_enableAmmoCookoff = false; //this disables secondary explosions

if (isServer) then {

	GVAR(ServerViewDistance) = 2500; //View distance for the server (the ai's)

	GVAR(TimeLimit) = 30; //Time limit in minutes, to disable the time limit set it to 0
	GVAR(TimeLimitMessage) = "TIME LIMIT REACHED!"; //The message displayed when the time runs out
	GVAR(EndConditionFrequency) = 10; // Frequency in seconds that the end conditions are checked

	//Ticket pools for different sides
	GVAR(RespawnTicketsWest) = 0;
	publicVariable QGVAR(RespawnTicketsWest);
	GVAR(RespawnTicketsEast) = 0;
	publicVariable QGVAR(RespawnTicketsEast);
	GVAR(RespawnTicketsInd) = 0;
	publicVariable QGVAR(RespawnTicketsInd);
	GVAR(RespawnTicketsCiv) = 0;
	publicVariable QGVAR(RespawnTicketsCiv);

	//wave respawn
	GVAR(WaveSizeWest) = 0; //How many players have to respawn before wave is released
	GVAR(WaveSizeEast) = 0;
	GVAR(WaveSizeInd) = 0;
	GVAR(WaveSizeCiv) = 0;

	//Players should be put in enclosed space, when their number reaches treshold, the defined "gate" will disappear for 30 seconds
	//it has to be defined for wave respawn to work
	//GVAR(RespawnPenGateWest) = YourEditorObjectName;
	//GVAR(RespawnPenGateEast) = YourEditorObjectName;
	//GVAR(RespawnPenGateInd) = YourEditorObjectName;
	//GVAR(RespawnPenGateCiv) = YourEditorObjectName;
};

if (hasInterface) then {

	GVAR(DebugMessagesEnabled) = true; //Only disable debug messages when the mission is released

	setViewDistance 2500; //View distance for the player
	
	GVAR(StartOnSafe) = true;

	//call FUNC(forceTerrainGrid); //uncomment this to force high terrain setting. This will prevent faraway objects from appearing as floating. Useful for missions with long sightlines.
	
	switch (side player) do { //Checks what team the player is on
		case west: {
			GVAR(RespawnTickets) = 0; //If respawn is enabled you must create empty game logics, for respawn points, following the name format GVAR(side_respawn). Example: GVAR(west_respawn)
		};
		case east: {
			GVAR(RespawnTickets) = 0;
		};
		case independent: {
			GVAR(RespawnTickets) = 0;
		};
		case civilian: {
			GVAR(RespawnTickets) = 0;
		};
	};
};