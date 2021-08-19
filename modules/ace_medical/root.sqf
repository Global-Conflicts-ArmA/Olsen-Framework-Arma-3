#ifdef description_XEH_PreInit
	class ACEM {
		clientInit = "'' call compile preprocessFileLineNumbers 'modules\ace_medical\preInitClient.sqf'";
		serverInit = "'' call compile preprocessFileLineNumbers 'modules\ace_medical\preInitServer.sqf'";
	};
#endif

#ifdef description_params
	#include "params.hpp"
#endif

#ifdef description_functions
	#include "functions\CfgFunctions.hpp"
#endif
