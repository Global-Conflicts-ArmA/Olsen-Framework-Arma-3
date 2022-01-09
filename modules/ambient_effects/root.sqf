#ifdef description_XEH_PreInit
	class AMBEFF {
		clientInit = "'' call compile preprocessFileLineNumbers 'modules\ambient_effects\preInitClient.sqf'";
	};
#endif

#ifdef description_XEH_PostInit
	class AMBEFF {
		serverInit = "'' call compile preprocessFileLineNumbers 'modules\ambient_effects\postInitServer.sqf'";
	};
#endif

#ifdef description_functions
	#include "functions\CfgFunctions.hpp"
#endif

#ifdef description_sounds
	#include "sounds.hpp"
#endif
