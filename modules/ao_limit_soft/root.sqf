#include "script_component.hpp"

#ifdef description_XEH_PreInit
	class COMPONENT {
		clientInit = "'' call compile preprocessFileLineNumbers 'modules\ao_limit_soft\preInitClient.sqf'";
	};
#endif

#ifdef description_XEH_PostInit
	class COMPONENT {
		clientInit = "'' call compile preprocessFileLineNumbers 'modules\ao_limit_soft\postInitClient.sqf'";
	};
#endif

#ifdef description_titles
	#include "RscAOLimit.hpp"
#endif

#ifdef description_notifications
	#include "CfgNotifications.hpp"
#endif

#ifdef description_external_functions
	#include "functions\CfgFunctions.hpp"
#endif

#undef COMPONENT
