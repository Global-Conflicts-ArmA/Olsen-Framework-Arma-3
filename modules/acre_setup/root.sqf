#ifdef description_XEH_PreInit
	class ACRES {
		clientInit = "'' call compile preprocessFileLineNumbers 'modules\acre_setup\preInitClient.sqf'";
	};
#endif

#ifdef description_XEH_PostInit
	class ACRES {
		serverInit = "'' call compile preprocessFileLineNumbers 'modules\acre_setup\postInitServer.sqf'";
	};
#endif

#ifdef description_XEH_InitPost_CAManBase
	class ACRES {
		clientInit = "_this call compile preprocessFileLineNumbers 'modules\acre_setup\postInitClient.sqf'";
	};
#endif

#ifdef description_functions
	#include "functions\CfgFunctions.hpp"
#endif
