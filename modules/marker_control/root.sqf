#ifdef description_XEH_PreInit
	class MRKCON {
		clientInit = "'' call compile preprocessFileLineNumbers 'modules\marker_control\preInitClient.sqf'";
	};
#endif

#ifdef description_XEH_PostInit
	class MRKCON {
		clientInit = "'' call compile preprocessFileLineNumbers 'modules\marker_control\postInitClient.sqf'";
	};
#endif

#ifdef description_functions
	#include "functions\CfgFunctions.hpp"
#endif
