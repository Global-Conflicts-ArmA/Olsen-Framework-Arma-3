#include "script_component.hpp"

#ifdef description_XEH_PreInit
	class COMPONENT {
		clientInit = "'' call compile preprocessFileLineNumbers 'modules\acre_setup\preInitClient.sqf'";
	};
#endif

#ifdef description_XEH_PostInit
	class COMPONENT {
		serverInit = "'' call compile preprocessFileLineNumbers 'modules\acre_setup\postInitServer.sqf'";
	};
#endif

#ifdef description_XEH_InitPost_CAManBase
	class COMPONENT {
        onRespawn = true;
		clientInit = "_this call compile preprocessFileLineNumbers 'modules\acre_setup\initPostClient.sqf'";
	};
#endif

#ifdef description_external_functions
	#include "functions\CfgFunctions.hpp"
#endif

#undef COMPONENT
