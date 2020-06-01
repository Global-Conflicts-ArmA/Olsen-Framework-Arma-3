#ifdef description_XEH_PreInit
	class StartInParachute {
		clientInit = "'' call compile preprocessFileLineNumbers 'modules\start_in_parachute\preinitClient.sqf'";
	};
#endif

#ifdef description_functions
	#include "functions\CfgFunctions.hpp"
#endif
