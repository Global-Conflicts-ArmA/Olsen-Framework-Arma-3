#ifdef description_XEH_PreInit
	class EXTRACT {
		clientInit = "'' call compile preprocessFileLineNumbers 'modules\extract\preInitClient.sqf'";
	};
#endif

#ifdef description_XEH_PostInit
	class EXTRACT {
		serverInit = "'' call compile preprocessFileLineNumbers 'modules\extract\postInitServer.sqf'";
	};
#endif

#ifdef description_functions
	#include "functions\CfgFunctions.hpp"
#endif
