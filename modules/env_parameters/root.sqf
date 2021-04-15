#ifdef description_XEH_PreInit
	class ENV {
		clientInit = "'' call compile preprocessFileLineNumbers 'modules\env_parameters\preInitClient.sqf'";
		init = "'' call compile preprocessFileLineNumbers 'modules\env_parameters\preInit.sqf'";
		serverInit = "'' call compile preprocessFileLineNumbers 'modules\env_parameters\preInitServer.sqf'";
	};
#endif

#ifdef description_XEH_PostInit
	class ENV {
		serverInit = "'' call compile preprocessFileLineNumbers 'modules\env_parameters\initServer.sqf'";
	};
#endif

#ifdef description_params
	#include "params.hpp"
#endif

#ifdef description_functions
	#include "functions\CfgFunctions.hpp"
#endif
