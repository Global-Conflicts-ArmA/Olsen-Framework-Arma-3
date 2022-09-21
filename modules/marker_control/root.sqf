#include "script_component.hpp"

#ifdef description_XEH_PreInit
	class COMPONENT {
		clientInit = "'' call compile preprocessFileLineNumbers 'modules\marker_control\preInitClient.sqf'";
	};
#endif

#ifdef description_XEH_PostInit
	class COMPONENT {
		clientInit = "'' call compile preprocessFileLineNumbers 'modules\marker_control\postInitClient.sqf'";
	};
#endif

#ifdef description_external_functions
	#include "functions\CfgFunctions.hpp"
#endif
