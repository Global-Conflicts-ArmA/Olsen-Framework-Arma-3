#ifdef description_XEH_PreInit
	class SELFA {
		clientInit = "'' call compile preprocessFileLineNumbers 'modules\self_actions\preInitClient.sqf'";
	};
#endif

#ifdef description_XEH_PostInit
	class SELFA {
		clientInit = "'' call compile preprocessFileLineNumbers 'modules\self_actions\postInitClient.sqf'";
	};
#endif

#ifdef description_functions
	#include "functions\CfgFunctions.hpp"
#endif
