#ifdef description_XEH_PreInit
	class CoverMap {
		clientInit = "'' call compile preprocessFileLineNumbers 'modules\cover_map\preinitClient.sqf'";
	};
#endif

#ifdef description_functions
	#include "functions\CfgFunctions.hpp"
#endif