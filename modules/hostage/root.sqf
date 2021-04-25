#include "script_component.hpp"

#ifdef description_XEH_PreInit
	class HOST {
		clientInit = "'' call compile preprocessFileLineNumbers 'modules\hostage\preInitClient.sqf'";
	};
#endif

#ifdef description_XEH_InitPost_CAManBase
	class HOST {
		clientInit = "[_unit] call compile preprocessFileLineNumbers 'modules\hostage\postInitClient.sqf'";
	};
#endif

#ifdef description_external_functions
	#include "functions\CfgFunctions.hpp"
#endif

#undef COMPONENT
