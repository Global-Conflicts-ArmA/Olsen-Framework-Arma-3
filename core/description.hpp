#ifdef description

	#include "dia\rscdefinitions.hpp" //Must have for the end screen to work, if removed Arma 3 will crash on mission load

	respawn = "BASE"; //Do not change, spectator script needs people to respawn, to be declared as dead and put into spectator mode
	respawndelay = 5; //5 seconds are needed to make sure people properly die and go into spectator
	disabledAI = 1; //disabledAI does so not slotted units do not spawn as ai
	respawnButton = 1; //Disables the respawn button
	respawnDialog = 0; //Disables the score screen while respawning
	respawnTemplates[] = {"Base"}; //Disables respawn countdown
	enableDebugConsole[] = {"76561197960506129"};
	enableTargetDebug = 1; //Enable CBA Target Debugging

	class CfgDebriefingSections {
		class acex_killTracker {
			title = "Acex Killed Events";
			variable = "acex_killTracker_outputText";
		};
	};

#endif

#ifdef description_titles

	#include "dia\debug\dia_debug.hpp" //Must have for the end screen to work, if removed Arma 3 will crash on mission load
	#include "dia\endscreen\dia_endscreen.hpp" //Must have for the end screen to work, if removed Arma 3 will crash on mission load

#endif

#ifdef description_XEH_PreInit

	class Mission {
		init = "'' call compile preprocessFileLineNumbers 'preinit.sqf'";
		serverInit = "'' call compile preprocessFileLineNumbers 'preinitServer.sqf'";
		clientInit = "'' call compile preprocessFileLineNumbers 'preinitClient.sqf'";
	};

#endif
