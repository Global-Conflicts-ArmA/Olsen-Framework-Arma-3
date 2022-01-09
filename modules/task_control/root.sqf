#ifdef description_XEH_PreInit
	class TASK {
		clientInit = "call compile preprocessFileLineNumbers 'modules\task_control\preInitClient.sqf'";
	};
#endif

#ifdef description_XEH_PostInit
	class TASK {
		serverInit = "call compile preprocessFileLineNumbers 'modules\task_control\postInitServer.sqf'";
	};
#endif

#ifdef description_functions
	#include "functions\CfgFunctions.hpp"
#endif
