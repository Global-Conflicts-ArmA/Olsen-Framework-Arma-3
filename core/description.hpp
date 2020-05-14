#include "script_macros.hpp"

#ifdef description
	#include "dia\rscdefinitions.hpp" // Must have for the end screen to work, if removed Arma 3 will crash on mission load

	#include "..\customization\missionAttributes.hpp"

	class CfgDebriefingSections {
		class acex_killTracker {
			title = "Acex Killed Events";
			variable = "acex_killTracker_outputText";
		};
	};
#endif

#ifdef description_titles
	#include "dia\debug\dia_debug.hpp" // Must have for the end screen to work, if removed Arma 3 will crash on mission load
	#include "dia\endscreen\dia_endscreen.hpp" // Must have for the end screen to work, if removed Arma 3 will crash on mission load
#endif

#ifdef description_functions
	#include "CfgFunctions.hpp"
#endif

#ifdef description_XEH_PreInit
	class Mission {
		serverInit = "'' call compile preprocessFileLineNumbers 'core\preinitServer.sqf'";
		init = "'' call compile preprocessFileLineNumbers 'core\preinit.sqf'";
		clientInit = "'' call compile preprocessFileLineNumbers 'core\preinitClient.sqf'";
	};
#endif

#ifdef description_XEH_PostInit
	class Mission {
		serverInit = "'' call compile preprocessFileLineNumbers 'core\postInitServer.sqf'";
		init = "'' call compile preprocessFileLineNumbers 'core\postInit.sqf'";
		clientInit = "'' call compile preprocessFileLineNumbers 'core\postInitClient.sqf'";
	};
#endif

#ifdef description_XEH_Init_CAManBase
	class GVAR(Core) {
		onRespawn = 1;
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

#ifdef description_XEH_FiredMan_CAManBase
	class GVAR(ShotCount) {
		firedMan = QUOTE(_this call FUNC(SC_FiredEH));
	};
#endif
