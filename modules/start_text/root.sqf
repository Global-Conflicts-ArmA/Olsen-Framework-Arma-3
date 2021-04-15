#ifdef description_XEH_PreInit
	class START {
		clientInit = "'' call compile preprocessFileLineNumbers 'modules\start_text\preInitClient.sqf'";
	};
#endif

#ifdef description_XEH_InitPost_CAManBase
	class START {
		clientInit = "'' call compile preprocessFileLineNumbers 'modules\start_text\postInitClient.sqf'";
	};
#endif

#ifdef description_functions
	#include "functions\CfgFunctions.hpp"
#endif
