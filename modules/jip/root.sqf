#ifdef description_XEH_PreInit
	class JIP {
		clientInit = "'' call compile preprocessFileLineNumbers 'modules\jip\preInitClient.sqf'";
		serverInit = "'' call compile preprocessFileLineNumbers 'modules\jip\preInitServer.sqf'";
	};
#endif

#ifdef description_functions
	#include "functions\CfgFunctions.hpp"
#endif
