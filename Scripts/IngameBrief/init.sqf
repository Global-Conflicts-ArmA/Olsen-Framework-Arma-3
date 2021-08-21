if (isServer) then 
{
	// Ingame Brief Variable Defines
	bluforIsReady = false;
	publicVariable "bluforIsReady";	
	opforIsReady = false;
	publicVariable "opforIsReady";	
	missionStarter = false;
	publicVariable "missionStarter";	
};	

[] execVM "ingameBrief\ACScripts\missionStarter.sqf"; //init mission start action