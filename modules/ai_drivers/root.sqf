#ifdef description_XEH_PreInit
	class AiDrivers {
		clientInit = "'' call compile preprocessFileLineNumbers 'modules\ai_drivers\preinitClient.sqf'";
	};
#endif

#ifdef description_functions
	#include "functions\CfgFunctions.hpp"
#endif