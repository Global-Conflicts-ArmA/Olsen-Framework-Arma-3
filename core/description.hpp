#define COMPONENT FW
#include "script_macros.hpp"

// Description file
// Used to define attributes for the mission
// See: https://community.bistudio.com/wiki/Description.ext

#ifdef description
	#include "dia\rscdefinitions.hpp" //Must have for the end screen to work, if removed Arma 3 will crash on mission load
    #include "dia\briefingMenu\dia_briefingMenu.hpp"
    #include "dia\gearMenu\dia_gearMenu.hpp"

	// DO NOT CHANGE, spectator script needs people to respawn, to be declared as dead and put into spectator mode
	// See: https://community.bistudio.com/wiki/Description.ext#respawn
	respawn = "BASE";

	// 5 seconds are needed to make sure people properly die and go into spectator
	// See: https://community.bistudio.com/wiki/Description.ext#respawnDelay
	respawnDelay = 5;

	// disabledAI does so not slotted units do not spawn as ai
	// See: https://community.bistudio.com/wiki/Description.ext#disabledAI
	disabledAI = 1;

	// Disables the respawn button
	// See: https://community.bistudio.com/wiki/Description.ext#respawnButton
	respawnButton = 1;

	// Disables the score screen while respawning
	// See: https://community.bistudio.com/wiki/Description.ext#respawnDialog
	respawnDialog = 0;

	// Disables respawn countdown
	// See: https://community.bistudio.com/wiki/Description.ext#respawnTemplates
	respawnTemplates[] = {"Base"};

	// Only for logged-in admins
	// See: https://community.bistudio.com/wiki/Description.ext#enableDebugConsole
	enableDebugConsole = 1;

	// Sets the mode for corpse removal manager. 1 = All units are managed by the manager
	// See: https://community.bistudio.com/wiki/Description.ext#corpseManagerMode
	corpseManagerMode = 1;

	// Enable CBA Target Debugging
	// See: https://github.com/CBATeam/CBA_A3/wiki/Target-Debugging
	enableTargetDebug = 1;

	class Extended_DisplayLoad_EventHandlers {
	    class RscDisplayLoading {
	        GVAR(customLoadingScreen) = QUOTE(_this call FUNC(initLoadingScreen));
	    };
		class RscDisplayEGSpectator {
	        GVAR(customLoadingScreen) = QUOTE(_this call FUNC(initSpectateScreen));
	    };
		class RscDisplayMission {
	        GVAR(missionLoaded) = QUOTE(_this call FUNC(initSafeStart));
	    };
		class RscDisplayCamera {
	        GVAR(startedCamera) = QUOTE(_this call FUNC(initCamera));
	    };
	};
    class GVAR(serverSettings) {
        #include "..\customization\serverSettings.hpp"
    };
    class GVAR(debugSettings) {
        #include "..\customization\debugSettings.hpp"
    };
    class GVAR(gearSettings) {
        #include "..\customization\gearSettings.hpp"
    };
    class GVAR(settings) {
        #include "..\customization\settings.hpp"
    };
    class GVAR(clientSettings) {
        #include "..\customization\clientSettings.hpp"
    };
#endif

#ifdef description_debriefing_sections
	class acex_killTracker {
		title = "Acex Killed Events";
		variable = "acex_killTracker_outputText";
	};
#endif

#ifdef description_titles
	#include "dia\debug\dia_debug.hpp"
	#include "dia\endscreen\dia_endscreen.hpp"
#endif

#ifdef description_functions
	#include "CfgFunctions.hpp"
#endif

#ifdef description_XEH_PreInit
	class Mission {
		serverInit = "call compile preprocessFileLineNumbers 'core\preinitServer.sqf'";
		init = "call compile preprocessFileLineNumbers 'core\preinit.sqf'";
		clientInit = "call compile preprocessFileLineNumbers 'core\preinitClient.sqf'";
	};
#endif

#ifdef description_XEH_PostInit
	class Mission {
		serverInit = "call compile preprocessFileLineNumbers 'core\postInitServer.sqf'";
		init = "call compile preprocessFileLineNumbers 'core\postInit.sqf'";
		clientInit = "call compile preprocessFileLineNumbers 'core\postInitClient.sqf'";
	};
#endif

#ifdef description_XEH_InitPost_CAManBase
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
