#ifdef description_XEH_PreInit
	class RM {
		clientInit = "'' call compile preprocessFileLineNumbers 'modules\remove_map\preinitClient.sqf'";
	};
#endif

#ifdef description_XEH_InitPost_CAManBase
	class RM {
		clientInit = "'' call compile preprocessFileLineNumbers 'modules\remove_map\postinitClient.sqf'";
	};
#endif

#ifdef description_functions

	#include "functions\CfgFunctions.hpp"

#endif
