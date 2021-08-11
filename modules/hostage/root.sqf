#ifdef description_XEH_PreInit
	class HOST {
		clientInit = "'' call compile preprocessFileLineNumbers 'modules\hostage\preInitClient.sqf'";
	};
#endif

#ifdef description_XEH_InitPost_CAManBase
	class HOST {
		init = "call compile preprocessFileLineNumbers 'modules\hostage\postInitClient.sqf'";
	};
#endif

#ifdef description_functions
	#include "functions\CfgFunctions.hpp"
#endif
