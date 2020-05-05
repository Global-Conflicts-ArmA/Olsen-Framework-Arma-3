#include "script_macros.hpp"

#ifdef description

	#include "dia\rscdefinitions.hpp" //Must have for the end screen to work, if removed Arma 3 will crash on mission load

	respawn = "BASE"; //Do not change, spectator script needs people to respawn, to be declared as dead and put into spectator mode
	respawndelay = 5; //5 seconds are needed to make sure people properly die and go into spectator
	disabledAI = 1; //disabledAI does so not slotted units do not spawn as ai
	respawnButton = 1; //Disables the respawn button
	respawnDialog = 0; //Disables the score screen while respawning
	respawnTemplates[] = {"Base"}; //Disables respawn countdown
	enableDebugConsole = 1;
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

#ifdef description_functions
	
	#include "CfgFunctions.hpp"
	
#endif

#ifdef description_XEH_PreInit

	class Mission {
		serverInit = "'' call compile preprocessFileLineNumbers 'preinitServer.sqf'";
		init = "'' call compile preprocessFileLineNumbers 'preinit.sqf'";
		clientInit = "'' call compile preprocessFileLineNumbers 'preinitClient.sqf'";
	};

#endif

#ifdef description_XEH_Init_CAManBase

	class GVAR(Core) {
		init = QUOTE(_this call FUNC(initCAManBase));
	};

#endif

#ifdef description_XEH_Killed_CAManBase

	class GVAR(Core) {
		killed = QUOTE(_this call FUNC(killedCAManBase));
	};

#endif

#ifdef description_XEH_Respawn_CAManBase

	class GVAR(Core) {
		respawn = QUOTE(_this call FUNC(respawnCAManBase));
	};

#endif

