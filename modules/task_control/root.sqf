#ifdef description_XEH_PreInit
	class TASK {
		clientInit = "call compile preprocessFileLineNumbers 'modules\task_control\preInitClient.sqf'";
		serverInit = "call compile preprocessFileLineNumbers 'modules\task_control\preInitServer.sqf'";
	};
#endif

#ifdef description_functions
	#include "functions\CfgFunctions.hpp"
#endif
