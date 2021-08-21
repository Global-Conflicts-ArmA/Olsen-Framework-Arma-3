//ace_cookoff_enable = false; //this disables cookoff fire effect
//ace_cookoff_enableAmmoCookoff = false; //this disables secondary explosions

if (isServer) then {

	FW_ServerViewDistance = 2500; //View distance for the server (the ai's)

	FW_TimeLimit = 75; //Time limit in minutes, to disable the time limit set it to 0
	FW_TimeLimitMessage = "TIME LIMIT REACHED!"; //The message displayed when the time runs out
	FW_EndConditionFrequency = 10; // Frequency in seconds that the end conditions are checked

	[west, "BLUFOR", "player"] call FNC_AddTeam; //Adds a player team called USMC on side west
	[east, "OPFOR", "player"] call FNC_AddTeam; //Adds a ai team called VDV on side east
	// [east, "OPFOR", "player"] call FNC_AddTeam; //Adds a ai team called VDV on side east
	// [resistance, "Local Militia", "player"] call FNC_AddTeam; //Adds a player team called Local Militia on side resistance (aka independent)
	// [civilian, "Local Civilians", "player"] call FNC_AddTeam; //Adds a player team called Local Civilians on side civilian

	//Ticket pools for different sides - Sets the overall amount of tickets a team/side has.
	if (isNil "FW_RespawnTicketsWest") then {FW_RespawnTicketsWest = 0};
	if (isNil "FW_RespawnTicketsEast") then {FW_RespawnTicketsEast = 0};
	if (isNil "FW_RespawnTicketsInd") then {FW_RespawnTicketsInd = 0};
	if (isNil "FW_RespawnTicketsCiv") then {FW_RespawnTicketsCiv = 0};

	//wave respawn
	FW_WaveSizeWest = 0; //How many players have to respawn before wave is released
	FW_WaveSizeEast = 0;
	FW_WaveSizeInd = 0;
	FW_WaveSizeCiv = 0;

	
	//Players should be put in enclosed space, when their number reaches treshold, the defined "gate" will disappear for 30 seconds
	//it has to be defined for wave respawn to work
	//FW_RespawnPenGateWest = YourEditorObjectName;
	//FW_RespawnPenGateEast = YourEditorObjectName;
	//FW_RespawnPenGateInd = YourEditorObjectName;
	//FW_RespawnPenGateCiv = YourEditorObjectName;
};

if (!isDedicated) then {
	[{!isNil "FW_RespawnTickets"}, {FW_RespawnTickets = 0}] call CBA_fnc_waitUntilAndExecute; // Sets how many tickets a user/client can use out of the team ticket pool.

	FW_DebugMessagesEnabled = true; //Only disable debug messages when the mission is released

	setViewDistance 2500; //View distance for the player
};