#ifdef description_XEH_PreInit
	class SOTC {
		clientInit = "'' call compile preprocessFileLineNumbers 'modules\start_on_team_color\preinitClient.sqf'";
	};
#endif

#ifdef description_functions
	#include "functions\CfgFunctions.hpp"
#endif
