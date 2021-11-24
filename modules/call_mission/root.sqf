#include "script_component.hpp"

#ifdef description_XEH_PreInit
	class COMPONENT {
		clientInit = "'' call compile preprocessFileLineNumbers 'modules\call_mission\preInitClient.sqf'";
		serverInit = "'' call compile preprocessFileLineNumbers 'modules\call_mission\preInitServer.sqf'";
	};
#endif

#ifdef description_external_functions
	#include "functions\CfgFunctions.hpp"
#endif

#undef COMPONENT
