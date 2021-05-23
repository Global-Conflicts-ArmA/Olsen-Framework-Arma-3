#ifdef description_XEH_PreInit
	class VEHBOOST {
		clientInit = "'' call compile preprocessFileLineNumbers 'modules\vehicle_boost\preInitClient.sqf'";
	};
#endif

#ifdef description_XEH_PostInit
	class VEHBOOST {
		clientInit = "'' call compile preprocessFileLineNumbers 'modules\vehicle_boost\postInitClient.sqf'";
	};
#endif

#ifdef description_functions
	#include "functions\CfgFunctions.hpp"
#endif
