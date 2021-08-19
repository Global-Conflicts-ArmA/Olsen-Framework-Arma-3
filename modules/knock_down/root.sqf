// AUTHOR: StatusRed
#ifdef description_XEH_PreInit
	class KnockDown {
		clientInit = "'' call compile preprocessFileLineNumbers 'modules\knock_down\preInitClient.sqf'";
	};
#endif

#ifdef description_XEH_PostInit
	class KnockDown {
		clientInit = "'' call compile preprocessFileLineNumbers 'modules\knock_down\postInitClient.sqf'";
	};
#endif

#ifdef description_functions
	#include "functions\CfgFunctions.hpp"
#endif
