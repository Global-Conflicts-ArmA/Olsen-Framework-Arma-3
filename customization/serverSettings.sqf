GVAR(ServerViewDistance) = 2500; //View distance for the server (the ai's)

GVAR(TimeLimit) = 30; //Time limit in minutes, to disable the time limit set it to 0
GVAR(TimeLimitMessage) = "TIME LIMIT REACHED!"; //The message displayed when the time runs out
GVAR(EndConditionFrequency) = 60; // Frequency in seconds that the end conditions are checked

GVAR(CoC_CheckFrequency) = 30; // Frequency in seconds that the Chain of Command is checked to determine the current Commanding Officer
GVAR(CoC_ManualOverride_Blufor) = []; // List, in order (left to right) of which units are the CO in a mission
GVAR(CoC_ManualOverride_Opfor) = []; // List, in order (left to right) of which units are the CO in a mission
GVAR(CoC_ManualOverride_Indfor) = []; // List, in order (left to right) of which units are the CO in a mission
GVAR(CoC_ManualOverride_Civfor) = []; // List, in order (left to right) of which units are the CO in a mission
GVAR(CoC_Changed_Message) = true;

/*
Time for how long disconnected players should be deleted since mission start (in minutes)
Set this to 0 or a negative number to disable behaviour
*/
GVAR(DisconnectBodyCleanupTime) = 2;

//Sides which should have their gear deleted, all by default (example: [WEST, EAST] will remove unit from WEST and EAST, but keep INDEPENDENT and CIVILIAN)
GVAR(DisconnectBodyCleanupSides) = [WEST, EAST, INDEPENDENT, CIVILIAN];

/*
    If respawn is enabled you must create empty game logics, for respawn points, following the name format GVAR(side_respawn). Example: FW_west_respawn
    Ticket pools for different sides
    Set individual tickets for players on a side in clientSettings
*/
GVAR(RespawnTickets_West) = 0;
GVAR(RespawnTickets_East) = 0;
GVAR(RespawnTickets_Ind) = 0;
GVAR(RespawnTickets_Civ) = 0;

//wave respawn
GVAR(WaveSizeWest) = 0; //How many players have to respawn before wave is released
GVAR(WaveSizeEast) = 0;
GVAR(WaveSizeInd) = 0;
GVAR(WaveSizeCiv) = 0;

/*
Players should be put in enclosed space, when their number reaches treshold, the defined "gate" will disappear for 30 seconds
it has to be defined for wave respawn to work
*/
GVAR(RespawnPenGateWest) = objnull;
GVAR(RespawnPenGateEast) = objnull;
GVAR(RespawnPenGateInd) = objnull;
GVAR(RespawnPenGateCiv) = objnull;

[west, "USMC", "player"] call FUNC(AddTeam); //Adds a player team called USMC on side west
[east, "VDV", "ai"] call FUNC(AddTeam); //Adds a ai team called VDV on side east
[resistance, "Local Militia", "ai"] call FUNC(AddTeam); //Adds a player team called Local Militia on side resistance (aka independent)
[civilian, "Local Civilians", "player"] call FUNC(AddTeam); //Adds a player team called Local Civilians on side civilian
